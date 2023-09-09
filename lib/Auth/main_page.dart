import 'package:caretreat/Auth/auth_page.dart';
import 'package:caretreat/Auth/verify_email_page.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({Key? key}) : super(key: key);

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (
        context,
        snapshot,
      ) {
        if (snapshot.hasData) {
          return VerifyEmailPage();
        } else {
          return AuthPage();
        }
      },
    ));
  }
}
