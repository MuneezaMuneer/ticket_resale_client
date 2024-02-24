// Add this import statement
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:ticket_resale/admin_panel/custom_navigation_admin.dart';
import 'package:ticket_resale/admin_panel/snackBar.dart';

class AuthServicesAdmin {
  static Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    log('...............................run login...............');
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        log('..........................user Login');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomNavigationAdmin(),
            ));

        return true;
      }

      log('..........................Not Login');
    } on FirebaseAuthException catch (e) {
      log('..........................Not Login......${e.message}. ${e.code}................ ex');
      if (e.code == 'user-not-found') {
        log('..........................Login');
        SnackBarHelper.showSnackBar(
            context, 'Wrong email provided for that user');

        return false;
      } else if (e.code == 'wrong-password') {
        log('..........................Not ');
        SnackBarHelper.showSnackBar(
            context, 'Wrong password provided for that user');

        return false;
      }
      return false;
    }
    return false;
  }
}
