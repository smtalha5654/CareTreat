import 'package:caretreat/Auth/checkroles.dart';
import 'package:caretreat/components/mybutton.dart';
import 'package:caretreat/components/mytextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';

class BankDetails extends StatefulWidget {
  BankDetails({super.key});

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  @override
  void initState() {
    super.initState();
    getRole();
  }

  bool isNurse = false;
  getRole() {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      var role = doc.get('role');
      if (role == 'Nurse') {
        setState(() {
          isNurse = true;
        });
      }
    });
  }

  String id = FirebaseAuth.instance.currentUser!.uid;
  Future<void> submitBankDetails() {
    final userRef = isNurse
        ? FirebaseFirestore.instance.collection('nurses')
        : FirebaseFirestore.instance.collection('doctors');
    return userRef
        .doc(id)
        .collection(
            'bankdetails') // Reference to the "posts" collection inside the user's document
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
          'name': nameController.text.trim(),
          'bankname': bankNameController.text.trim(),
          'accountno': accountNoController.text.trim()
        })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Details submitted Succesfully",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            )))
        .catchError((error) =>
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Error while submitting details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            )));
  }

  final TextEditingController nameController = TextEditingController();

  final TextEditingController accountNoController = TextEditingController();

  final TextEditingController bankNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Add Bank Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Column(
          children: [
            Text(
              'Add your bank details accurately. Take a moment to double-check and avoid any mistakes.',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(
                controller: nameController,
                hinttext: 'Account Holder Name',
                icon: Icons.person),
            SizedBox(
              height: 5,
            ),
            MyTextField(
                controller: accountNoController,
                hinttext: 'Account Number',
                icon: Icons.credit_card),
            SizedBox(
              height: 5,
            ),
            MyTextField(
                controller: bankNameController,
                hinttext: 'Bank Name',
                icon: Icons.other_houses_rounded),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.h),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      submitBankDetails();
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
