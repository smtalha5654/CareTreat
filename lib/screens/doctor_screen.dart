import 'package:caretreat/Auth/main_page.dart';
import 'package:caretreat/Other%20Screens/create_doctor_profile.dart';
import 'package:caretreat/components/mybutton.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sizer/sizer.dart';
import '../Drawer Screens/favorite.dart';
import '../Drawer Screens/my_profile.dart';
import '../Drawer Screens/settings_page.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  void initState() {
    super.initState();
    getName();
  }

  String fname = '';
  String lname = '';
  String email = FirebaseAuth.instance.currentUser!.email.toString();

  void getName() {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      setState(() {
        fname = doc.get('first name');
        lname = doc.get('last name');
      });
    });
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          elevation: 0,
          width: 44.h,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    color: Colors.deepPurple,
                    width: double.infinity,
                    height: 26.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 2.h, right: 25.h, top: 3.h),
                            height: 12.h,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/doctorprofile.jpg'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 11.h, right: 16.h),
                            child: Container(
                              alignment: Alignment.center,
                              height: 5.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      ImagePicker imagePicker = ImagePicker();
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    imagePicker.pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                  },
                                                  child: Container(
                                                      height: 15.h,
                                                      width: 15.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white60,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .camera_alt_rounded,
                                                            size: 10.h,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            'Camera',
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                                SizedBox(
                                                  width: 1.h,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    imagePicker.pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                  },
                                                  child: Container(
                                                      height: 15.h,
                                                      width: 15.h,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white60,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.photo,
                                                            size: 10.h,
                                                            color: Colors.black,
                                                          ),
                                                          Text(
                                                            'Gallery',
                                                            style: TextStyle(
                                                                fontSize: 10.sp,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      )),
                                                )
                                              ],
                                            );
                                          });
                                      // imagePicker.pickImage(
                                      //     source: ImageSource.gallery : ImageSource.camera);
                                    },
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      size: 2.5.h,
                                      color: Colors.black,
                                    )),
                              ),
                            ),
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.only(left: 2.5.h),
                          child: Text(
                            '$fname $lname',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.5.h),
                          child: Text(
                            email,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.home_outlined,
                      size: 3.5.h,
                      color: Colors.deepPurple,
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DoctorScreen()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      'My Profile',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.person_2_outlined,
                      size: 3.5.h,
                      color: Colors.deepPurple,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyProfile()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Settings',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.settings_outlined,
                      size: 3.5.h,
                      color: Colors.deepPurple,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingPage()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Favorites',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.favorite_border_outlined,
                      size: 3.5.h,
                      color: Colors.deepPurple,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Favorite()));
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.logout_outlined,
                      size: 3.5.h,
                      color: Colors.deepPurple,
                    ),
                    onTap: () async {
                      await _googleSignIn.signOut();
                      await FirebaseAuth.instance.signOut();

                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return const Main_Page();
                      }));
                    },
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black45,
                  ),
                  ListTile(
                    title: Text(
                      'Report Bug',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.bug_report_outlined,
                      size: 3.5.h,
                      color: Colors.deepPurple,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      'Feedback',
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                    ),
                    leading: Icon(
                      Icons.feedback_outlined,
                      size: 3.5.h,
                      color: Colors.deepPurple,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                bottomLeft: Radius.circular(24))),
        elevation: 0,
        toolbarHeight: 20.h,
        backgroundColor: Colors.deepPurple,
        bottom: PreferredSize(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 2.h,
                  ),
                  child: Text(
                    'Hi! Dr $lname \nFind What You Need',
                    style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Signika'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                  child: MyButton(
                    textStyle: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    color: const Color.fromARGB(255, 150, 115, 210),
                    title: 'Create Your Doctor Profile',
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const CreateDoctorProfile();
                      }));
                    },
                  ),
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(50)),
      ),
      body: const Center(child: Text('Doctor Screen')),
    );
  }
}
