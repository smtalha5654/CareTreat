import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CreateDoctorProfile extends StatefulWidget {
  const CreateDoctorProfile({super.key});

  @override
  State<CreateDoctorProfile> createState() => _CreateDoctorProfileState();
}

class _CreateDoctorProfileState extends State<CreateDoctorProfile> {
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
                'Create Your Digital Profile',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: TextField(
                  // controller: _firstnamecontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_4_rounded),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Enter Name',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              SizedBox(
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
                  // controller: _phonecontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Phone Number',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: DropDownTextField(
                    textFieldDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Select Gender',
                        fillColor: Colors.grey[200],
                        filled: true),
                    clearOption: true,
                    // controller: _gendercontroller,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 2,
                    dropDownList: [
                      DropDownValueModel(name: 'Male', value: "value1"),
                      DropDownValueModel(name: 'Female', value: "value2"),
                    ],
                    onChanged: (val) {},
                  )),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: DropDownTextField(
                    textFieldDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Select Role',
                        fillColor: Colors.grey[200],
                        filled: true),
                    clearOption: true,
                    // controller: _rolecontroller,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 4,
                    dropDownList: [
                      DropDownValueModel(name: 'Doctor', value: "value1"),
                      DropDownValueModel(name: 'Patient', value: "value2"),
                      DropDownValueModel(name: 'Nurse', value: "value3"),
                      DropDownValueModel(name: 'Laboratory', value: "value4"),
                    ],
                    onChanged: (val) {},
                  )),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.h,
                ),
                child: TextField(
                  // controller: _emailController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 6.h,
                      ),
                      prefixIcon: Icon(Icons.description),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Description',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
