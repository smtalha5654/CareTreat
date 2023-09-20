import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailcontroller = TextEditingController();
  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailcontroller.text.trim());
   const ScaffoldMessenger(child: Text('Email Sent'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title:const Text('Forget Password'),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
         const Center(
              child: Text(
            'Receive an email to\nreset your password',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          )),
         const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailcontroller,
              decoration: InputDecoration(
                  prefixIcon:const Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderSide:const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide:const BorderSide(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'Enter Email',
                  fillColor: Colors.grey[200],
                  filled: true),
            ),
          ),
         const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: resetPassword,
                  icon:const Icon(Icons.email),
                  label:const Text(
                    "Forget Password",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
            ),
          ),
        ]),
      ),
    );
  }
}
