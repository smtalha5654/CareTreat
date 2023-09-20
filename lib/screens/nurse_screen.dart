
import 'package:caretreat/Auth/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class NurseScreen extends StatefulWidget {
  const NurseScreen({super.key});

  @override
  State<NurseScreen> createState() => _NurseScreenState();
}

class _NurseScreenState extends State<NurseScreen> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nurse Screen'), elevation: 0, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
              onTap: () async {
                await _googleSignIn.signOut();
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const Main_Page();
                }));
              },
              child: const Icon(Icons.person)),
        ),
      ]),
      body: const Center(child: Text('Nurse Screen')),
    );
  }
}
