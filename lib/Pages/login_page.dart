import 'dart:async';

import 'package:caretreat/Pages/forget_password_page.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool passtoggle = false;
  bool isButtonActive = false;

  @override
  void initState() {
    _emailController.addListener(() {
      final isButtonActive = _emailController.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    _passwordcontroller.addListener(() {
      final isButtonActive = _passwordcontroller.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  Future signIn() async {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitFadingCircle(
            color: Colors.deepPurple,
            size: 60.0,
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordcontroller.text.trim());

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      setState(() {
        isButtonActive = true;
        Navigator.of(context).pop();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$e',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
          backgroundColor: Colors.deepPurple,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0.1.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 25.h,
                child: Image.asset(
                  'assets/images/loginlogo.png',
                ),
              ),
              Text('CareTreat',
                  style: TextStyle(fontSize: 45.sp, fontFamily: 'BebasNeue')),
              Text(
                'Welcome Back, You\'ve been missed!',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: TextField(
                  controller: _passwordcontroller,
                  obscureText: passtoggle,
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            passtoggle = !passtoggle;
                          });
                        },
                        child: Icon(passtoggle
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword())),
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 11.5.sp),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  height: 8.h,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isButtonActive
                          ? () {
                              signIn();
                              setState(() {
                                isButtonActive = false;
                              });
                            }
                          : null,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.grey[800],
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Continue With',
                        style: TextStyle(color: Colors.grey[900]),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.grey[800],
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: GestureDetector(
                  onTap: () {
                    AuthService().signInWithGoogle(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[200]),
                    child: Image.asset(
                      'assets/images/googlelogo.png',
                      height: 7.h,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      ' Register now',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 11.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}