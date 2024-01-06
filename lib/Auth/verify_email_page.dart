import 'dart:async';

import 'package:caretreat/Auth/checkroles.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error while sending verification email",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      setState(() {
        timer?.cancel();
      });
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const CheckRole()
      : SafeArea(
          child: Scaffold(
            appBar: AppBar(
              //backgroundColor: Colors.deepPurple,
              title: const Center(child: Text('Email Verification')),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Verification Email Sent Successfully!',
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                Text('Please Check Your Email',
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w600)),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.h, vertical: 1.5.h),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    height: 8.h,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed:
                            canResendEmail ? sendVerificationEmail : null,
                        icon: const Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Resent Email",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    height: 8.h,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        icon: const Icon(
                          Icons.cancel_sharp,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
}
