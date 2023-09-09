
import 'package:caretreat/Pages/complete_detail_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'checkroles.dart';

class AuthService {
  signInWithGoogle(BuildContext context) async {

   try{
 FirebaseAuth _auth = FirebaseAuth.instance;

        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);

        final User? user = authResult.user;

        ///Her to check isNewUser OR Not
        if (authResult.additionalUserInfo!.isNewUser) {
          if (user != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return CompleteDetail();
            }));
          }
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return CheckRole();
          }));
        }

        return await FirebaseAuth.instance.signInWithCredential(credential);

   }on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: Text(
                e.message.toString(),
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            );
          });
    }
  }
}
