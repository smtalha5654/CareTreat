import 'dart:io';

import 'package:caretreat/Auth/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sizer/sizer.dart';

import '../Drawer Screens/favorite.dart';
import '../Drawer Screens/my_profile.dart';
import '../Drawer Screens/settings_page.dart';
import 'doctor_profile_screen.dart';

final userRef = FirebaseFirestore.instance.collection('users');
final userRef2 = FirebaseFirestore.instance.collection('doctors');

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
    displayData();
    email;
    getProfile();
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
  var collection = FirebaseFirestore.instance.collection("doctors");
  late List<Map<String, dynamic>> items;
  bool isLoaded = false;

  displayData() async {
    List<Map<String, dynamic>> tempList = [];
    var data = await collection.get();
    data.docs.forEach((element) {
      tempList.add(element.data());
    });

    setState(() {
      items = tempList;
      isLoaded = true;
    });
  }

  String profile = '';
  void getProfile() {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      setState(() {
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

  final id = FirebaseAuth.instance.currentUser!.uid;
  String imageUrl = '';
  Future addJustImage(
    String profile,
  ) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'profile': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
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
                                    shape: BoxShape.circle,
                                    color: Colors.black),
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
                                                          FirebaseStorage
                                                              .instance
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
                                                            .putFile(File(
                                                                file.path));
                                                        //Success: get the download URL

                                                        imageUrl =
                                                            await referenceImageToUpload
                                                                .getDownloadURL();
                                                        submitImage();
                                                        getProfile();
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
                                                                fontSize:
                                                                    13.sp),
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
                                                            color:
                                                                Colors.white60,
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
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            Text(
                                                              'Camera',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
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
                                                      XFile? file = await imagePicker
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
                                                          FirebaseStorage
                                                              .instance
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
                                                            .putFile(File(
                                                                file.path));
                                                        //Success: get the download URL

                                                        imageUrl =
                                                            await referenceImageToUpload
                                                                .getDownloadURL();
                                                        submitImage();
                                                        getProfile();
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
                                                                fontSize:
                                                                    13.sp),
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
                                                            color:
                                                                Colors.white60,
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
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            Text(
                                                              'Gallery',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp,
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
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(24),
                    bottomLeft: Radius.circular(24))),
            elevation: 0,
            toolbarHeight: 20.h,
            backgroundColor: Colors.deepPurple,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.h,
                    ),
                    child: Text(
                      'Hi $fname $lname',
                      style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Signika',
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.h,
                    ),
                    child: Text(
                      'Find What You Need',
                      style: TextStyle(
                          fontSize: 22.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Signika',
                          overflow: TextOverflow.ellipsis),
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
            ),
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
                  ]),
              Expanded(
                child: TabBarView(children: [
                  Tab(
                      child: isLoaded
                          ? MasonryGridView.builder(
                              // physics: const NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              gridDelegate:
                                  SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0.5.h, vertical: 0.5.h),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: ((
                                        context,
                                      ) {
                                        return DoctorProfile(
                                          name: items[index]["name"],
                                          appointmentcharges: items[index]
                                              ["appointment charges"],
                                          doctortype: items[index]
                                              ["doctor type"],
                                          visitcharges: items[index]
                                              ["visit charges"],
                                          profile: items[index]["profile"],
                                          about: items[index]["about"],
                                          address: items[index]["address"],
                                          education: items[index]["education"],
                                          experience: items[index]
                                              ["experience"],
                                          gender: items[index]["gender"],
                                          phone: items[index]["phone"],
                                          id: items[index]['id'],
                                        );
                                      })));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.deepPurple[100],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12)),
                                            child: Image.network(
                                              items[index]['profile'],
                                              height: 180,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          // const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.all(0.9.h),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Dr. ' +
                                                          items[index]
                                                              ["name"] ??
                                                      "Not given",
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Text(
                                                    items[index]["doctor type"],
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        overflow: TextOverflow
                                                            .ellipsis)),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('Appointment',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                                    Text(
                                                        'Rs. ' +
                                                            items[index][
                                                                    "appointment charges"]
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('House vist',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis)),
                                                    Text(
                                                        'Rs.' +
                                                            items[index][
                                                                    "visit charges"]
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : const SpinKitFadingCircle(
                              color: Colors.deepPurple,
                              size: 60.0,
                            )),
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
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
