import 'dart:convert';
import 'dart:developer' as logg;
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:ticket_resale/db_services/firestore_services_admin.dart';
import 'package:ticket_resale/constants/constants.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/models/user_models.dart';
import 'package:ticket_resale/utils/utils.dart';

import '../widgets/custom_navigation_admin.dart';

class AuthServices {
  static User get getCurrentUser {
    return FirebaseAuth.instance.currentUser!;
  }

  ///Below data is for apple login/////
  /// Generates a cryptographically secure random nonce, to be included in a redential request.
  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<UserCredential> signInWithApple(BuildContext context) async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Extract user information
    final givenName = appleCredential.givenName ?? '';
    final familyName = appleCredential.familyName ?? '';
    final fullName = '$givenName $familyName';
    logg.log(
        'givenName: $givenName, familyName: $familyName, fullName: $fullName');

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase.
    UserCredential? userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);

    // Update user . Note this will not update usename on 2nd logg.login as apple provides userName for very first time ONLY.Apple also doesn't provide photoUrl.
    fullName.trim();
    if (fullName.length > 2) {
      await userCredential.user!.updateDisplayName(fullName);
      // await userCredential.user!.updatePhotoURL(photoURL)
    }
    logg.log('userName: ${FirebaseAuth.instance.currentUser!.displayName}');
    return userCredential;
  }

  static Future<UserCredential?> signInWithGoogle(BuildContext context,
      ValueNotifier<bool> googleNotifier, String fcmToken) async {
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

      await storeGoogleData(userCredential, fcmToken: fcmToken);

      return userCredential;
    } catch (e) {
      logg.log("Error signing in with Google: $e");
      googleNotifier.value = false;
    }
    return null;
  }

  static Future<void> storeGoogleData(UserCredential userCredential,
      {required String fcmToken}) async {
    final user = userCredential.user;
    final userData = {
      'user_name': user!.displayName,
      'email': user.email,
      'status': 'Active',
      'fcm_token': fcmToken,
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
      logg.log('Error: ${e.toString()}');
    }
    return null;
  }

  static Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      String? fcmToken = await NotificationServices.getFCMCurrentDeviceToken();
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          if (email == 'test@gmail.com') {
            FirestoreServicesAdmin.storeFCMToken(token: '$fcmToken');
            AppText.preference!
                .setString(AppText.isAdminPrefKey, AppText.admin);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomNavigationAdmin(),
                ));
          } else {
            AuthServices.storeUserSignInFcmToken(fcmToken: '$fcmToken');
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
        logg.log('Not Login');
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
      logg.log(e.toString());

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {}
    } catch (e) {
      logg.log(e.toString());
    }
  }

  static Future<void> deleteUserData() async {
    try {
      await FirebaseFirestore.instance
          .collection('user_data')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
    } catch (e) {
      logg.log("Error deleting user data: $e");
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
      logg.log("Error deleting user data: $e");
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
      logg.log(e.toString());
    }
  }

  static Future<void> storeUserImage(
      {required UserModelClient userModel}) async {
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
      logg.log('Error storing photo url: ${e.toString()}');
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

  static Future<void> storeUserSignInFcmToken(
      {required String fcmToken}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference user =
        firestore.collection('user_data').doc(getCurrentUser.uid);
    await user.set({'fcm_token': fcmToken}, SetOptions(merge: true));
  }

  static Future<void> storeFCMToken({required String fcmToken}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference user =
        firestore.collection('user_data').doc(getCurrentUser.uid);
    await user.set({'fcm_token': fcmToken}, SetOptions(merge: true));
  }

  static Future<void> storePaypalAuthorization(
      {required bool paypalAuthorization}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference user =
        firestore.collection('user_data').doc(AuthServices.getCurrentUser.uid);
    await user.set({
      'profile_levels': {
        'isPaypalVerified': paypalAuthorization,
      }
    }, SetOptions(merge: true));
  }

  static Future<void> storeUserData(
      {required UserModelClient userModel}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user =
          firestore.collection('user_data').doc(getCurrentUser.uid);
      Map<String, dynamic> userData = userModel.toWithTokenMap();
      await user.set({
        ...userData,
        'profile_levels': {
          'isEmailVerified': true,
          'isInstaVerified': true,
        }
      }, SetOptions(merge: true));

      await getCurrentUser.updateDisplayName(userModel.displayName);
    } catch (e) {
      logg.log('Error storing user data: ${e.toString()}');
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
        logg.log('Error: ${error.toString()}');
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
        logg.log('Error: ${error.toString()}');
      });
    }
    return null;
  }

  static Future<UserModelClient?> fetchUserDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('user_data')
              .doc(getCurrentUser.uid)
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> mapData = documentSnapshot.data()!;
        return UserModelClient.fromMap(mapData, documentSnapshot.id);
      } else {
        return null;
      }
    } catch (e) {
      logg.log('Error fetching user data: ${e.toString()}');
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
      logg.log('Image Uploading Error:$error ');
      return '';
    }
  }
}
