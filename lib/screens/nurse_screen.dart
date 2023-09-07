import 'package:caretreat/Pages/main_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NurseScreen extends StatefulWidget {
  const NurseScreen({super.key});

  @override
  State<NurseScreen> createState() => _NurseScreenState();
}

class _NurseScreenState extends State<NurseScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nurse Screen'), elevation: 0, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
              onTap: () async {
                await _googleSignIn.signOut();
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return Main_Page();
                }));
              },
              child: Icon(Icons.person)),
        ),
      ]),
      body: Center(child: Text('Nurse Screen')),
    );
  }
}
