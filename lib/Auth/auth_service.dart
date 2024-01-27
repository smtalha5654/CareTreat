import 'package:caretreat/Pages/complete_detail_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'checkroles.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const SpinKitFadingCircle(
              color: Colors.deepPurple,
              size: 60.0,
            );
          });
      FirebaseAuth auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await auth.signInWithCredential(credential);

      final User? user = authResult.user;

      ///Her to check isNewUser OR Not
      if (authResult.additionalUserInfo!.isNewUser) {
        if (user != null) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const CompleteDetail();
          }));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const CheckRole();
        }));
      }

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: Text(
                e.message.toString(),
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            );
          });
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        print("Password changed successfully");
      } else {
        print("User not signed in");
        // Handle the case when the user is not signed in.
      }
    } catch (e) {
      print("Error changing password: $e");
      // Handle password change errors (e.g., wrong current password)
    }
  }
}
