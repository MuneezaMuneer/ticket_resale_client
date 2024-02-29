// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

class AuthServices {
  static User get getCurrentUser {
    return FirebaseAuth.instance.currentUser!;
  }

  //Google Authentication

  static Future<UserCredential?> signInWithGoogle(
      BuildContext context, ValueNotifier<bool> googleNotifier) async {
    try {
      googleNotifier.value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.blueViolet,
            content: Text(
              'Sign-in with Google canceled.',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        );
        googleNotifier.value = false;
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //store user google credentials to firestore

      await storeGoogleData(userCredential);

      return userCredential;
    } catch (e) {
      log("Error signing in with Google: $e");
      googleNotifier.value = false;
    }
    return null;
  }

  static Future<void> storeGoogleData(UserCredential userCredential) async {
    final user = userCredential.user;
    final userData = {
      'user_name': user!.displayName,
      'email': user.email,
      'status': 'Active',
      // 'photoURL': user.photoURL,
      'profile_levels': {
        'isEmailVerified': true,
        // 'isPhoneNoVerified': false,
        // 'isPaypalVerified': false,
        // 'isInstaVerified': false,
        // 'isTransactionVerified': false,
        // 'isSuperVerified': false
      }
    };

    final userDocumentReference =
        FirebaseFirestore.instance.collection('user_data').doc(user.uid);

    await userDocumentReference.set(userData, SetOptions(merge: true));
  }

  static Future<UserCredential?> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credentials.user != null) {
        return credentials;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AppUtils.toastMessage(
          'Week password',
        );
      } else if (e.code == 'email-already-in-use') {
        AppUtils.toastMessage('Email already in use');
      }
    } catch (e) {
      log('Error: ${e.toString()}');
    }
    return null;
  }

  static Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRoutes.navigationScreen,
            (route) => false,
          );
        });
        return true;
      } else {
        log('Not Login');
        return false;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        AppUtils.toastMessage('No user found for that email.');

        return false;
      } else if (e.code == 'wrong-password') {
        AppUtils.toastMessage('Wrong password provided for that user.');

        return false;
      }
      return false;
    }
  }

 static Future<void> sendVerificationCode(
      String toPhoneNumber, String verificationCode) async {
    // Initialize Twilio
    TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: 'AC4a81b930d51a35fab421fa39ab8bbaf0',
      authToken: '2cc0b71ea0aab26f0f00d26ae4e03849',
      twilioNumber: '',
    );

    try {
      String messageBody = 'Your verification code is: $verificationCode';
      
      await twilioFlutter.sendSMS(
        toNumber: toPhoneNumber,
        messageBody: messageBody,
      );

      print('Verification code sent successfully.');
    } catch (e) {
      print('Error sending verification code: $e');
    }
  }

  static Future<void> deleteUserAccount() async {
    try {
      await deleteUserData();
      await deleteUserEvents();
      await AuthServices.getCurrentUser.delete();
    } on FirebaseAuthException catch (e) {
      log(e.toString());

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> deleteUserData() async {
    try {
      await FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
    } catch (e) {
      log("Error deleting user data: $e");
    }
  }

  static Future<void> deleteUserEvents() async {
    try {
      String uid = AuthServices.getCurrentUser.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('event_ticket')
          .where('user_id', isEqualTo: uid)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.delete();
      }
    } catch (e) {
      log("Error deleting user data: $e");
    }
  }

  static Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData = AuthServices.getCurrentUser.providerData.first;

      if (AppleAuthProvider().providerId == providerData.providerId) {
        await AuthServices.getCurrentUser
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await AuthServices.getCurrentUser
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await AuthServices.getCurrentUser.delete();
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> storeUserImage({required UserModel userModel}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user =
          firestore.collection('user_data').doc(getCurrentUser.uid);

      await getCurrentUser.updatePhotoURL(userModel.photoUrl);
      await getCurrentUser.updateDisplayName(userModel.displayName);
      await user.set(
          {
            'birth_date': userModel.birthDate,
            'phone_number': userModel.phoneNo,
            'instagram_username': userModel.instaUsername,
            'user_name': userModel.displayName,
            'profile_levels': {
              'isInstaVerified': true,
            },
          },
          SetOptions(
            merge: true,
          ));
    } catch (e) {
      log('Error storing photo url: ${e.toString()}');
    }
  }

  static Future<String> forgotPassword(
      {required String email, required BuildContext context}) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return 'success';
    } on FirebaseAuthException catch (err) {
      return "${err.message}";
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

  static Future<void> storeUserData({required UserModel userModel}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user =
          firestore.collection('user_data').doc(getCurrentUser.uid);

      await user.set({
        "phone_number": userModel.phoneNo,
        "instagram_username": userModel.instaUsername,
        "email": userModel.email,
        "user_name": userModel.displayName,
        "status": userModel.status,
        'profile_levels': {
          'isEmailVerified': true,
          // 'isPhoneNoVerified': false,
          // 'isPaypalVerified': false,
          'isInstaVerified': true,
          // 'isTransactionVerified': false,
          // 'isSuperVerified': false
        }
      });

      await getCurrentUser.updateDisplayName(userModel.displayName);
    } catch (e) {
      log('Error storing user data: ${e.toString()}');
    }
  }

  static Future<String?> uploadOrUpdateImage({
    required String imagePath,
  }) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref('profile_image')
          .child(AuthServices.getCurrentUser.uid)
          .child("image");
      await ref.putFile(
          File(imagePath), SettableMetadata(contentType: 'image/png'));
      return await ref.getDownloadURL();
    } on FirebaseException catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        log('Error: ${error.toString()}');
      });
    }
    return null;
  }

  static Future<String?> uploadEventImage({
    required String imagePath,
  }) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref('event_image')
          .child(AuthServices.getCurrentUser.uid)
          .child(
              '${AuthServices.getCurrentUser.uid}${DateTime.timestamp().millisecond}');
      await ref.putFile(
          File(imagePath), SettableMetadata(contentType: 'image/png'));
      return await ref.getDownloadURL();
    } on FirebaseException catch (error) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        log('Error: ${error.toString()}');
      });
    }
    return null;
  }

  static Future<UserModel?> fetchUserDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('user_data')
              .doc(getCurrentUser.uid)
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> mapData = documentSnapshot.data()!;
        return UserModel.fromMap(mapData, documentSnapshot.id);
      } else {
        return null;
      }
    } catch (e) {
      log('Error fetching user data: ${e.toString()}');
      return null;
    }
  }
}
