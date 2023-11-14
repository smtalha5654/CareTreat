import 'dart:async';
import 'package:caretreat/Auth/checkroles.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

class CompleteDetail extends StatefulWidget {
  const CompleteDetail({super.key});

  @override
  State<CompleteDetail> createState() => _CompleteDetailState();
}

class _CompleteDetailState extends State<CompleteDetail> {
  final _firstnamecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();

  late SingleValueDropDownController _rolecontroller;
  late SingleValueDropDownController _gendercontroller;
  bool isButtonActive = false;

  @override
  void initState() {
    _rolecontroller = SingleValueDropDownController();
    _gendercontroller = SingleValueDropDownController();

    _rolecontroller.addListener(() {
      final isButtonActive = _rolecontroller.toString().isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });

    super.initState();
  }

  Future submit() async {
    await addUserDetails(
      _firstnamecontroller.text.trim(),
      _lastnamecontroller.text.trim(),
      int.parse(_phonecontroller.text.trim()),
      _gendercontroller.dropDownValue!.name.toString().trim(),
      _rolecontroller.dropDownValue!.name.toString().trim(),
      _addresscontroller.text.trim(),
    );
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const CheckRole();
    }));
  }

  Future addUserDetails(
    String firstName,
    String lastName,
    int phone,
    String gender,
    String role,
    String address,
  ) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'first name': firstName,
      'last name': lastName,
      'phone': phone,
      'gender': gender,
      'role': role,
      'address': address
    });
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
                'Enter Your Complete Details!',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: TextField(
                  controller: _firstnamecontroller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_4_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'First Name',
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
                  controller: _lastnamecontroller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_4_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Last Name',
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
                child: TextField(
                  controller: _addresscontroller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.place),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Address',
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
                              submit();
                              setState(() {
                                isButtonActive = false;
                              });
                            }
                          : null,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
