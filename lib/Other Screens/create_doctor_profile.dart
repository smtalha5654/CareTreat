import 'dart:io';
import 'package:caretreat/components/mybutton.dart';
import 'package:caretreat/components/mytextfield.dart';
import 'package:caretreat/main.dart';
import 'package:caretreat/screens/doctor_profile_screen.dart';
import 'package:caretreat/screens/patient_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CreateDoctorProfile extends StatefulWidget {
  const CreateDoctorProfile({super.key});

  @override
  State<CreateDoctorProfile> createState() => _CreateDoctorProfileState();
}

class _CreateDoctorProfileState extends State<CreateDoctorProfile> {
  final _namecontroller = TextEditingController();
  final _aboutcontroller = TextEditingController();
  final _educationcontroller = TextEditingController();
  final _appointmentchargescontroller = TextEditingController();
  final _visitchargescontroller = TextEditingController();
  final _experiencecontroller = TextEditingController();
  final _addresscontroller = TextEditingController();
  late SingleValueDropDownController _doctortypecontroller;
  late SingleValueDropDownController _gendercontroller;
  final _phonecontroller = TextEditingController();
  @override
  void initState() {
    _doctortypecontroller = SingleValueDropDownController();
    _gendercontroller = SingleValueDropDownController();
    getProfileData();
    super.initState();
  }

  var name = '';
  int phone = 0;
  var gender = '';
  var doctortype = '';
  var about = '';
  var address = '';
  var education = '';
  int appointmentcharges = 0;
  int visitcharges = 0;
  var experience = '';
  String profile = '';

  final userRef = FirebaseFirestore.instance.collection('doctors');
  void getProfileData() {
    print('profile data function load');
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      setState(() {
        profile = doc.get('profile');
        name = doc.get('name');
        phone = doc.get('phone');
        appointmentcharges = doc.get('appointment charges');
        visitcharges = doc.get('visit charges');
        doctortype = doc.get('doctor type');
        education = doc.get('education');
        experience = doc.get('experience');
        address = doc.get('address');
        about = doc.get('about');
        gender = doc.get("gender");
      });
    });
  }

  Future submitImage() async {
    try {
      userRef2.doc(id).get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          updateImage(imageUrl.toString().trim());
          getProfileData();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Profile Picture Updated Successfully",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ));
        } else {
          addImage(imageUrl.toString().trim());
          getProfileData();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Profile Picture Added Successfully",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ));
        }
      });
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

  Future submit() async {
    try {
      userRef2.doc(id).get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          updateDoctorDetails(
              _namecontroller.text.trim(),
              int.parse(_phonecontroller.text.trim()),
              _gendercontroller.dropDownValue!.name.toString().trim(),
              _doctortypecontroller.dropDownValue!.name.toString().trim(),
              _aboutcontroller.text.trim(),
              _addresscontroller.text.trim(),
              _educationcontroller.text.trim(),
              int.parse(_visitchargescontroller.text.trim()),
              int.parse(_appointmentchargescontroller.text.trim()),
              _experiencecontroller.text.trim(),
              id.trim());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Profile Updated Successfully",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ));
        } else {
          addDoctorDetails(
              _namecontroller.text.trim(),
              int.parse(_phonecontroller.text.trim()),
              _gendercontroller.dropDownValue!.name.toString().trim(),
              _doctortypecontroller.dropDownValue!.name.toString().trim(),
              _aboutcontroller.text.trim(),
              _addresscontroller.text.trim(),
              _educationcontroller.text.trim(),
              int.parse(_visitchargescontroller.text.trim()),
              int.parse(_appointmentchargescontroller.text.trim()),
              _experiencecontroller.text.trim(),
              id.trim());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Profile Created Successfully",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Error While Submiting Data",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  Future addDoctorDetails(
    String name,
    int phone,
    String gender,
    String doctortype,
    String about,
    String address,
    String education,
    int visitcharges,
    int appointmentcharges,
    String experience,
    String id,
  ) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('doctors').doc(id).set({
      'name': name,
      'phone': phone,
      'gender': gender,
      'doctor type': doctortype,
      'about': about,
      'address': address,
      'education': education,
      'visit charges': visitcharges,
      'appointment charges': appointmentcharges,
      'experience': experience,
      'id': id,
    });
  }

  Future updateDoctorDetails(
    String name,
    int phone,
    String gender,
    String doctortype,
    String about,
    String address,
    String education,
    int visitcharges,
    int appointmentcharges,
    String experience,
    String id,
  ) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('doctors').doc(id).update({
      'name': name,
      'phone': phone,
      'gender': gender,
      'doctor type': doctortype,
      'about': about,
      'address': address,
      'education': education,
      'visit charges': visitcharges,
      'appointment charges': appointmentcharges,
      'experience': experience,
      'id': id,
    });
  }

  Future addImage(
    String profile,
  ) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('doctors').doc(id).set({
      'profile': imageUrl,
    });
  }

  Future updateImage(
    String profile,
  ) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('doctors').doc(id).update({
      'profile': imageUrl,
    });
  }

  String imageUrl = '';
  final id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Container(
                    height: 22.h,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            profile,
                            scale: 1,
                          ),
                        ))),
                Padding(
                  padding: EdgeInsets.only(top: 17.h, left: 10.h),
                  child: Container(
                    alignment: Alignment.center,
                    height: 6.h,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          XFile? file =
                                              await imagePicker.pickImage(
                                                  source: ImageSource.camera);

                                          if (file == null) return;
                                          //Import dart:core
                                          String uniqueFileName = id.toString();

                                          /*Step 2: Upload to Firebase storage*/
                                          //Install firebase_storage
                                          //Import the library

                                          //Get a reference to storage root
                                          Reference referenceRoot =
                                              FirebaseStorage.instance.ref();
                                          Reference referenceDirImages =
                                              referenceRoot
                                                  .child('digitalprofile');

                                          //Create a reference for the image to be stored
                                          Reference referenceImageToUpload =
                                              referenceDirImages
                                                  .child(uniqueFileName);

                                          //Handle errors/success
                                          try {
                                            //Store the file
                                            await referenceImageToUpload
                                                .putFile(File(file.path));
                                            //Success: get the download URL

                                            imageUrl =
                                                await referenceImageToUpload
                                                    .getDownloadURL();
                                            submitImage();
                                            getProfileData();
                                          } catch (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "Error while uploading image",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp),
                                              ),
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.h,
                                                  horizontal: 2.h),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration:
                                                  const Duration(seconds: 3),
                                            ));
                                          }
                                        },
                                        child: Container(
                                            height: 15.h,
                                            width: 15.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white60,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.camera_alt_rounded,
                                                  size: 10.h,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                              await imagePicker.pickImage(
                                                  source: ImageSource.gallery);

                                          if (file == null) return;
                                          //Import dart:core
                                          String uniqueFileName = id.toString();

                                          /*Step 2: Upload to Firebase storage*/
                                          //Install firebase_storage
                                          //Import the library

                                          //Get a reference to storage root
                                          Reference referenceRoot =
                                              FirebaseStorage.instance.ref();
                                          Reference referenceDirImages =
                                              referenceRoot
                                                  .child('digitalprofile');

                                          //Create a reference for the image to be stored
                                          Reference referenceImageToUpload =
                                              referenceDirImages
                                                  .child(uniqueFileName);

                                          //Handle errors/success
                                          try {
                                            //Store the file
                                            await referenceImageToUpload
                                                .putFile(File(file.path));
                                            //Success: get the download URL

                                            imageUrl =
                                                await referenceImageToUpload
                                                    .getDownloadURL();
                                            submitImage();
                                            getProfileData();
                                          } catch (error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                "Error while uploading image",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13.sp),
                                              ),
                                              backgroundColor:
                                                  Colors.deepPurple,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2.h,
                                                  horizontal: 2.h),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              duration:
                                                  const Duration(seconds: 3),
                                            ));
                                          }
                                        },
                                        child: Container(
                                            height: 15.h,
                                            width: 15.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white60,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                          TextDecoration.none,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                            size: 3.h,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Create Your Digital Profile',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: MyTextField(
                      controller: _namecontroller,
                      hinttext: 'Enter Name',
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
                    enableSearch: true,
                    textFieldDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Select Doctor Type',
                        fillColor: Colors.grey[200],
                        filled: true),
                    clearOption: true,
                    controller: _doctortypecontroller,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 6,
                    dropDownList: const [
                      DropDownValueModel(
                          name: 'General practitioner', value: "value1"),
                      DropDownValueModel(name: 'Pediatrician', value: "value2"),
                      DropDownValueModel(name: 'Gynecologist', value: "value3"),
                      DropDownValueModel(name: 'Cardiologist', value: "value4"),
                      DropDownValueModel(name: 'Oncologist', value: "value5"),
                      DropDownValueModel(
                          name: 'Gastroenterologist', value: "value6"),
                      DropDownValueModel(
                          name: 'Pulmonologist', value: "value7"),
                      DropDownValueModel(
                          name: 'Infectious disease', value: "value8"),
                      DropDownValueModel(name: 'Nephrologist', value: "value9"),
                      DropDownValueModel(
                          name: 'Endocrinologist', value: "value10"),
                      DropDownValueModel(
                          name: 'Ophthalmologist', value: "value11"),
                      DropDownValueModel(
                          name: 'Dermatologist', value: "value12"),
                      DropDownValueModel(
                          name: 'Psychiatrist', value: "value13"),
                      DropDownValueModel(name: 'Neurologist', value: "value14"),
                      DropDownValueModel(name: 'Radiologist', value: "value15"),
                      DropDownValueModel(
                          name: 'Anesthesiologist', value: "value16"),
                      DropDownValueModel(name: 'Surgeon', value: "value17"),
                      DropDownValueModel(
                          name: 'Physician executive', value: "value18"),
                    ],
                    onChanged: (val) {},
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: MyTextField(
                      controller: _aboutcontroller,
                      hinttext: 'About',
                      icon: Icons.description)),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: MyTextField(
                      controller: _addresscontroller,
                      hinttext: 'Address',
                      icon: Icons.home_filled)),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: MyTextField(
                      controller: _educationcontroller,
                      hinttext: 'Education',
                      icon: Icons.school)),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _appointmentchargescontroller,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Fee Charges For Appointment (PKR)',
                        fillColor: Colors.grey[200],
                        filled: true),
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _visitchargescontroller,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.attach_money),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Fee Charges For House Visit (PKR)',
                        fillColor: Colors.grey[200],
                        filled: true),
                  )),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: MyTextField(
                    controller: _experiencecontroller,
                    hinttext: 'Experience',
                    icon: Icons.document_scanner),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: MyButton(
                    title: 'Submit',
                    ontap: () {
                      submit();
                    },
                    color: Colors.deepPurple,
                    textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: MyButton(
                    title: 'Check Profile',
                    ontap: () {
                      setState(() {
                        isOwnProfileSelected = true;
                      });
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DoctorProfile(
                            id: id,
                            name: name,
                            about: about,
                            address: address,
                            appointmentcharges: appointmentcharges,
                            doctortype: doctortype,
                            education: education,
                            experience: experience,
                            gender: gender,
                            phone: phone,
                            profile: profile,
                            visitcharges: visitcharges);
                      }));
                    },
                    color: Colors.deepPurple,
                    textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
