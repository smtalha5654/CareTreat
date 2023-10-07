import 'dart:io';

import 'package:caretreat/Auth/main_page.dart';
import 'package:caretreat/Other%20Screens/create_doctor_profile.dart';
import 'package:caretreat/components/mybutton.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    getProfileData();
  }

  String fname = '';
  String lname = '';
  String email = FirebaseAuth.instance.currentUser!.email.toString();
  String profile = '';
  void getProfileData() {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      setState(() {
        fname = doc.get('first name');
        lname = doc.get('last name');
        profile = doc.get('profile');
      });
    });
  }

  Future submitImage() async {
    try {
      addJustImage(imageUrl.toString().trim());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Image Uploading Error",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  Future addJustImage(
    String profile,
  ) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'profile': imageUrl,
    });
  }

  String imageUrl = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          elevation: 0,
          width: 44.h,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
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
                        Padding(
                          padding: EdgeInsets.only(right: 25.h, top: 2.h),
                          child: Container(
                            height: 14.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  profile,
                                  scale: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12.h, right: 17.h),
                          child: Container(
                            alignment: Alignment.center,
                            height: 5.h,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black),
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
                                                onTap: () async {
                                                  XFile? file =
                                                      await imagePicker
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);

                                                  if (file == null) return;
                                                  //Import dart:core
                                                  String uniqueFileName =
                                                      id.toString();

                                                  /*Step 2: Upload to Firebase storage*/
                                                  //Install firebase_storage
                                                  //Import the library

                                                  //Get a reference to storage root
                                                  Reference referenceRoot =
                                                      FirebaseStorage.instance
                                                          .ref();
                                                  Reference
                                                      referenceDirImages =
                                                      referenceRoot
                                                          .child('profile');

                                                  //Create a reference for the image to be stored
                                                  Reference
                                                      referenceImageToUpload =
                                                      referenceDirImages
                                                          .child(
                                                              uniqueFileName);

                                                  //Handle errors/success
                                                  try {
                                                    //Store the file
                                                    await referenceImageToUpload
                                                        .putFile(
                                                            File(file.path));
                                                    //Success: get the download URL

                                                    imageUrl =
                                                        await referenceImageToUpload
                                                            .getDownloadURL();
                                                    submitImage();
                                                    getProfileData();
                                                  } catch (error) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            SnackBar(
                                                      content: Text(
                                                        "Error while uploading image",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 13.sp),
                                                      ),
                                                      backgroundColor:
                                                          Colors.deepPurple,
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                              vertical: 2.h,
                                                              horizontal:
                                                                  2.h),
                                                      behavior:
                                                          SnackBarBehavior
                                                              .floating,
                                                      duration:
                                                          const Duration(
                                                              seconds: 3),
                                                    ));
                                                  }
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
                                                onTap: () async {
                                                  XFile? file =
                                                      await imagePicker
                                                          .pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);

                                                  if (file == null) return;
                                                  //Import dart:core
                                                  String uniqueFileName =
                                                      id.toString();

                                                  /*Step 2: Upload to Firebase storage*/
                                                  //Install firebase_storage
                                                  //Import the library

                                                  //Get a reference to storage root
                                                  Reference referenceRoot =
                                                      FirebaseStorage.instance
                                                          .ref();
                                                  Reference
                                                      referenceDirImages =
                                                      referenceRoot
                                                          .child('profile');

                                                  //Create a reference for the image to be stored
                                                  Reference
                                                      referenceImageToUpload =
                                                      referenceDirImages
                                                          .child(
                                                              uniqueFileName);

                                                  //Handle errors/success
                                                  try {
                                                    //Store the file
                                                    await referenceImageToUpload
                                                        .putFile(
                                                            File(file.path));
                                                    //Success: get the download URL

                                                    imageUrl =
                                                        await referenceImageToUpload
                                                            .getDownloadURL();
                                                    submitImage();
                                                    getProfileData();
                                                  } catch (error) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            SnackBar(
                                                      content: Text(
                                                        "Error while uploading image",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                            fontSize: 13.sp),
                                                      ),
                                                      backgroundColor:
                                                          Colors.deepPurple,
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                              vertical: 2.h,
                                                              horizontal:
                                                                  2.h),
                                                      behavior:
                                                          SnackBarBehavior
                                                              .floating,
                                                      duration:
                                                          const Duration(
                                                              seconds: 3),
                                                    ));
                                                  }
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
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    size: 2.5.h,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(left: 2.5.h, top: 0.5.h),
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
