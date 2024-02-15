// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ticket_resale/constants/aapp_routes.dart';
import 'package:ticket_resale/constants/app_colors.dart';
import 'package:ticket_resale/models/models.dart';
import 'package:ticket_resale/utils/app_utils.dart';

class AuthServices {
  static User get getCurrentUser {
    return FirebaseAuth.instance.currentUser!;
  }

  //Google Authentication
  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
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
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.navigationScreen, (route) => false);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log("Error signing in with Google: $e");
    }
    return null;
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
  // static Future<void> signUp({
  //   required String email,
  //   required String password,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     final credentials =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );

  //     if (credentials.user != null) {
  //       log('Account created successfully');
  //     }
  //   } catch (e) {
  //     log('Error: ${e.toString()}');
  //   }
  // }

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

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> storeUserData({required UserModel userModel}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user =
          firestore.collection('user_data').doc(getCurrentUser.uid);

      await user.set({
        "phone_number": userModel.phoneNo,
        "instagram_username": userModel.instaUsername,
      });

      await getCurrentUser.updateDisplayName(userModel.displayName);
    } catch (e) {
      log('Error storing user data: ${e.toString()}');
    }
  }

  static Future<void> storeUserImage({required UserModel userModel}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference user =
          firestore.collection('user_data').doc(getCurrentUser.uid);

      await getCurrentUser.updatePhotoURL(userModel.photoUrl);
      await getCurrentUser.updateDisplayName(userModel.displayName);
      await user.update({'birth_date': userModel.birthDate});
      await user.update({'phone_number': userModel.phoneNo});
      await user.update({'instagram_username': userModel.instaUsername});
    } catch (e) {
      log('Error storing photo url: ${e.toString()}');
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

  static Future<UserModel?> fetchUserDetails() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('user_data')
              .doc(getCurrentUser.uid)
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> mapData = documentSnapshot.data()!;
        return UserModel.fromMap(mapData);
      } else {
        return null;
      }
    } catch (e) {
      log('Error fetching user data: ${e.toString()}');
      return null;
    }
  }
}
