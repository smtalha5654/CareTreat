import 'package:caretreat/Other%20Screens/create_doctor_profile.dart';
import 'package:caretreat/Pages/main_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  String email = '';

  void getName() async {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      fname = doc.get('first name');
      lname = doc.get('last name');
      email = FirebaseAuth.instance.currentUser!.email.toString();
    });
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Drawer(
              elevation: 0,
              width: 44.h,
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  Container(
                    color: Colors.deepPurple,
                    width: double.infinity,
                    height: 26.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 2.h, right: 25.h, top: 3.h),
                          height: 11.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/doctorprofile.jpg'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.5.h),
                          child: Text(
                            "$fname $lname",
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
                            "$email",
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
                              builder: (context) => DoctorScreen()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyProfile()));
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
                              builder: (context) => SettingPage()));
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Favorite()));
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
                        return Main_Page();
                      }));
                    },
                  ),
                  Divider(
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
        shape: RoundedRectangleBorder(
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
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.h),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CreateDoctorProfile();
                        }));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple[300],
                            borderRadius: BorderRadius.circular(24)),
                        height: 7.h,
                        child: Center(
                          child: Text(
                            'Create Your Doctor Profile',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            preferredSize: Size.fromHeight(50)),
      ),
      body: Center(child: Text('Doctor Screen')),
    );
  }
}
