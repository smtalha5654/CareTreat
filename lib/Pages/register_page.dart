import 'dart:async';
import 'package:caretreat/components/mytextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool passtoggle = true;
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();

  late SingleValueDropDownController _rolecontroller;
  late SingleValueDropDownController _gendercontroller;
  bool isButtonActive = false;

  @override
  void initState() {
    _rolecontroller = SingleValueDropDownController();
    _gendercontroller = SingleValueDropDownController();

    _confirmpasswordcontroller.addListener(() {
      final isButtonActive = _confirmpasswordcontroller.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });

    super.initState();
  }

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const SpinKitFadingCircle(
            color: Colors.deepPurple,
            size: 60.0,
          );
        });
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordcontroller.text.trim());

        addUserDetails(
          _firstnamecontroller.text.trim(),
          _lastnamecontroller.text.trim(),
          _emailController.text.trim(),
          int.parse(_phonecontroller.text.trim()),
          _gendercontroller.dropDownValue!.name.toString().trim(),
          _rolecontroller.dropDownValue!.name.toString().trim(),
          _passwordcontroller.text.trim(),
          _addressController.text.trim(),
        );
        Navigator.of(context).pop();
      } else if (passwordConfirmed() == false) {
        setState(() {
          Navigator.of(context).pop();
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Passwords not matched",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
          backgroundColor: Colors.deepPurple,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
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
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future addUserDetails(
      String firstName,
      String lastName,
      String email,
      int phone,
      String gender,
      String role,
      String password,
      String address) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'address': address,
      'phone': phone,
      'gender': gender,
      'role': role,
      'password': password,
    });
  }

  bool passwordConfirmed() {
    if (_confirmpasswordcontroller.text.trim() ==
        _passwordcontroller.text.trim()) {
      return true;
    } else {
      return false;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/loginlogo.png',
                height: 25.h,
              ),
              Text('CareTreat',
                  style: TextStyle(fontSize: 45.sp, fontFamily: 'BebasNeue')),
              Text(
                'Register Below With Your Details!',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: MyTextField(
                      controller: _firstnamecontroller,
                      hinttext: 'First Name',
                      icon: Icons.account_circle)),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: MyTextField(
                      controller: _lastnamecontroller,
                      hinttext: 'Last Name',
                      icon: Icons.account_circle)),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Phone Number',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: DropDownTextField(
                    textFieldDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Select Gender',
                        fillColor: Colors.grey[200],
                        filled: true),
                    clearOption: true,
                    controller: _gendercontroller,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 2,
                    dropDownList: const [
                      DropDownValueModel(name: 'Male', value: "value1"),
                      DropDownValueModel(name: 'Female', value: "value2"),
                    ],
                    onChanged: (val) {},
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: DropDownTextField(
                    textFieldDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Select Role',
                        fillColor: Colors.grey[200],
                        filled: true),
                    clearOption: true,
                    controller: _rolecontroller,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 3,
                    dropDownList: const [
                      DropDownValueModel(name: 'Doctor', value: "value1"),
                      DropDownValueModel(name: 'Patient', value: "value2"),
                      DropDownValueModel(name: 'Nurse', value: "value3"),
                    ],
                    onChanged: (val) {},
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: MyTextField(
                      controller: _emailController,
                      hinttext: 'Email',
                      icon: Icons.email)),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: MyTextField(
                      controller: _addressController,
                      hinttext: 'Address',
                      icon: Icons.place)),
              const SizedBox(
                height: 8,
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
                      prefixIcon: const Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Password',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: TextField(
                  controller: _confirmpasswordcontroller,
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
                      prefixIcon: const Icon(Icons.lock),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Confirm Password',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              const SizedBox(
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
                              signUp();
                              setState(() {
                                isButtonActive = false;
                              });
                            }
                          : null,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 11.sp),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(
                      ' Login now ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 11.sp),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}


// 