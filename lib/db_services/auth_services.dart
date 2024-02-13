import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ticket_resale/constants/aapp_routes.dart';

class AuthServices {
  //Google Authentication
  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign-in with Google canceled.'),
          ),
        );
        return null;
      }

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.navigationScreen, (route) => false);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  static Future<void> signUp({
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
        print('Account created successfully');
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.signIn, (route) => false);
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  static Future<String> _generateReCAPTCHAToken() async {
    return 'YourGeneratedToken';
  }

  static Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credentials.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.navigationScreen, (route) => false);
      }
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
