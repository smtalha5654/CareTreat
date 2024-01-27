import 'dart:io';

import 'package:caretreat/Other%20Screens/appointment_request_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class CustomTextFieldWithCamera extends StatelessWidget {
  final int maxLines;
  final VoidCallback onCameraTap;
  final TextEditingController controller;

  CustomTextFieldWithCamera(
      {required this.maxLines, required this.onCameraTap, required this.controller});

  // Future submitImage() async {
  //   try {
  //     userRef2.doc(widget.id).get().then((DocumentSnapshot doc) {
  //       addImage(imageUrl.toString().trim());
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(
  //           "Profile Picture Added Successfully",
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
  //         ),
  //         backgroundColor: Colors.deepPurple,
  //         padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
  //         behavior: SnackBarBehavior.floating,
  //         duration: const Duration(seconds: 3),
  //       ));
  //     });
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         "Image Uploading Error",
  //         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
  //       ),
  //       backgroundColor: Colors.deepPurple,
  //       padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
  //       behavior: SnackBarBehavior.floating,
  //       duration: const Duration(seconds: 3),
  //     ));
  //   }
  // }

  // Future addImage(
  //   String profile,
  // ) async {
  //   final id = FirebaseAuth.instance.currentUser!.uid;
  //   await FirebaseFirestore.instance.collection('doctors').doc(id).set({
  //     'profile': imageUrl,
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            height: 35,
            width: double.infinity,
            child: Center(
              child: Text(
                'Add prescription',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: maxLines *
                24.0, // Adjust the height based on the number of lines you want to display
            child: TextField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: 'Write your prescription...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8.0),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            height: 35,
            width: double.infinity,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: onCameraTap,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Tap on camera to upload image (optional)',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
