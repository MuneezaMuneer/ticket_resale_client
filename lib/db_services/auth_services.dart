// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/utils.dart';

import '../admin_panel/custom_navigation_admin.dart';

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
      'image_url': user.photoURL,
      'profile_levels': {
        'isEmailVerified': true,
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
          if (email == 'test@gmail.com') {
            AppText.preference!
                .setString(AppText.isAdminPrefKey, AppText.admin);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomNavigationAdmin(),
                ));
          } else {
            AppText.preference!
                .setString(AppText.isAdminPrefKey, AppText.client);
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.navigationScreen,
              (route) => false,
            );
          }
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

  static Future<void> deleteUserAccount() async {
    try {
      await deleteUserData();
      await deleteUserTickets();
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

  static Future<void> deleteUserTickets() async {
    try {
      String uid = AuthServices.getCurrentUser.uid;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('tickets')
          .where('user_uid', isEqualTo: uid)
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
      Map<String, dynamic> userData = userModel.toMap();
      await user.set(
          {
            ...userData,
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
      Map<String, dynamic> userData = userModel.toMap();
      await user.set({
        ...userData,
        'profile_levels': {
          'isEmailVerified': true,
          'isInstaVerified': true,
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
          .ref('ticket_image')
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

  static Future<Uint8List?> getImageFromGallery(
      {required BuildContext context}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List image = await pickedFile.readAsBytes();
      return image;
    } else {
      return null;
    }
  }

  static Future<String> storeImageToFirebase(
      {required BuildContext context, required Uint8List image}) async {
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final profileImage = firebaseStorage
        .ref('event_images')
        .child("${DateTime.timestamp().millisecondsSinceEpoch}");
    try {
      await profileImage.putData(
          image, SettableMetadata(contentType: "image/png"));
      return await profileImage.getDownloadURL();
    } on FirebaseException catch (error) {
      log('Image Uploading Error:$error ');
      return '';
    }
  }
}
