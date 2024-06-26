import 'package:caretreat/screens/doctor_screen.dart';
import 'package:caretreat/screens/nurse_screen.dart';
import 'package:caretreat/screens/patient_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

final userRef = FirebaseFirestore.instance.collection('users');

class CheckRole extends StatefulWidget {
  const CheckRole({super.key});

  @override
  State<CheckRole> createState() => _CheckRoleState();
}

class _CheckRoleState extends State<CheckRole> {
  @override
  void initState() {
    super.initState();
    getRole();
  }

  getRole() {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      var role = doc.get('role');

      if (role == 'Doctor') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return DoctorScreen();
        }));
      }
      if (role == 'Patient') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const PatientScreen();
        }));
      }
      if (role == 'Nurse') {
        return Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return const NurseScreen();
        }));
      } else {
        return Container();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getRole(),
    );
  }
}
