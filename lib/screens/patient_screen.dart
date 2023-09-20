import 'package:caretreat/Auth/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:sizer/sizer.dart';

import '../Drawer Screens/favorite.dart';
import '../Drawer Screens/my_profile.dart';
import '../Drawer Screens/settings_page.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  @override
  void initState() {
    super.initState();
    getName();
    email;
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
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
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
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: 2.h, right: 25.h, top: 3.h),
                              height: 11.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/doctorprofile.jpg'),
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
                                  builder: (context) => const PatientScreen()));
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
                        'Hi! $fname \nFind What You Need',
                        style: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Signika'),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                      child: SizedBox(
                        height: 7.h,
                        child: TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(24)),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.deepPurple,
                            ),
                            hintText: 'Search',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                preferredSize: const Size.fromHeight(50)),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TabBar(
                  splashBorderRadius: BorderRadius.circular(12),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.deepPurple,
                  tabs: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.5.h),
                          child: Image.asset(
                            'assets/images/doctor.png',
                            height: 6.h,
                          ),
                        ),
                        Text('Doctor',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp))
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.5.h),
                          child: Image.asset('assets/images/nurse.png',
                              height: 6.h),
                        ),
                        Text('Nurses',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp))
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0.5.h),
                          child:
                              Image.asset('assets/images/lab.png', height: 6.h),
                        ),
                        Text(
                          'Labs',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp),
                        )
                      ],
                    ),
                  ]),
              Expanded(
                child: TabBarView(children: [
                  Tab(
                    child: DefaultTabController(
                        length: 18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 1.h),
                              child: Container(
                                height: 6.h,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple[100],
                                    borderRadius: BorderRadius.circular(24)),
                                child: TabBar(
                                    indicator: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    splashBorderRadius:
                                        BorderRadius.circular(24),
                                    labelPadding: EdgeInsets.symmetric(
                                      horizontal: 3.h,
                                    ),
                                    isScrollable: true,
                                    labelColor: Colors.white,
                                    unselectedLabelColor: Colors.black,
                                    tabs: [
                                      Text('General practitioner',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text(
                                        'Pediatrician',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp),
                                      ),
                                      Text('gynecologist ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Cardiologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Oncologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Gastroenterologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Pulmonologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Infectious disease',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Nephrologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Endocrinologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Ophthalmologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Dermatologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      const Text('Psychiatrist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      Text('Neurologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Radiologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Anesthesiologist',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Surgeon',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp)),
                                      Text('Physician executive',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12.sp))
                                    ]),
                              ),
                            ),
                            Expanded(
                              child: TabBarView(children: [
                                Tab(
                                  child: Card(
                                    child: ListView(
                                      children: const [
                                        ListTile(
                                          title: Text('hello'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const  Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                                const Tab(
                                  child: Text('hello'),
                                ),
                              ]),
                            ),
                          ],
                        )),
                  ),
                  Tab(
                      child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple[100],
                                borderRadius: BorderRadius.circular(24)),
                            child: TabBar(
                                indicator: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(24)),
                                splashBorderRadius: BorderRadius.circular(24),
                                labelPadding:
                                    EdgeInsets.symmetric(horizontal: 4.h),
                                isScrollable: true,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black,
                                tabs: [
                                  Text('Male',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp)),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const Tab(
                    child: Text('Lab'),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
