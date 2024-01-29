import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PatientAppointmentScreen extends StatefulWidget {
  const PatientAppointmentScreen({super.key});

  @override
  State<PatientAppointmentScreen> createState() =>
      _PatientAppointmentScreenState();
}

class _PatientAppointmentScreenState extends State<PatientAppointmentScreen> {
  late FirebaseFirestore firestore;
  late User currentUser;
  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    currentUser = FirebaseAuth.instance.currentUser!;
    fetchData();
    fetchNurseData();
  }

  List<AppointmentDetails> appointmentList = [];
  List<NurseDetails> NurseappointmentList = [];

  void fetchData() async {
    try {
      // Query the "doctors" collection
      QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
          await firestore.collection('doctors').get();

      print('Number of doctor documents: ${doctorsSnapshot.size}');

      // Iterate through the doctors to find the one with the matching UID in the "appointments" collection
      for (var doctorDocument in doctorsSnapshot.docs) {
        // Get the "appointments" collection reference
        CollectionReference<Map<String, dynamic>> appointmentsCollection =
            doctorDocument.reference.collection('appointments');
        setState(() {
          isLoaded = true;
        });
        // Retrieve the document with a name (document ID) matching the user's UID
        DocumentSnapshot<Map<String, dynamic>> userAppointmentDocument =
            await appointmentsCollection.doc(currentUser.uid).get();

        if (userAppointmentDocument.exists) {
          // If a matching appointment document is found, print the details
          print('Doctor Document ID: ${doctorDocument.id}');
          print('Matching Appointment: ${userAppointmentDocument.data()}');

          // Fetch details of the doctor
          DocumentSnapshot<Map<String, dynamic>> doctorDetailsDocument =
              await doctorDocument.reference.get();

          if (doctorDetailsDocument.exists) {
            // Print or use the details of the doctor
            print('Doctor Details: ${doctorDetailsDocument.data()}');

            // Create an AppointmentDetails object and add it to the list
            var appointmentDetails = AppointmentDetails(
              doctorName: doctorDetailsDocument.data()!['name'],
              doctorProfile: doctorDetailsDocument.data()!['profile'],
              appointmentDate: userAppointmentDocument.data()!['date'],
              appointmentSlot: userAppointmentDocument.data()!['slot'],
              appointmentType: userAppointmentDocument.data()!['type'],
              appointmentCharges: (userAppointmentDocument.data()!['type'] ==
                      'House Visit')
                  ? (doctorDetailsDocument.data()!['visit charges'] as int? ??
                      0)
                  : (doctorDetailsDocument.data()!['appointment charges']
                          as int? ??
                      0),
            );
            setState(() {
              appointmentList.add(appointmentDetails);
            });
          }
        }
      }
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchNurseData() async {
    try {
      // Query the "doctors" collection
      QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
          await firestore.collection('nurses').get();

      print('Number of nurse documents: ${doctorsSnapshot.size}');
      setState(() {
        isLoaded = true;
      });
      // Iterate through the doctors to find the one with the matching UID in the "appointments" collection
      for (var doctorDocument in doctorsSnapshot.docs) {
        // Get the "appointments" collection reference
        CollectionReference<Map<String, dynamic>> appointmentsCollection =
            doctorDocument.reference.collection('appointments');
        setState(() {
          isLoaded = true;
        });
        // Retrieve the document with a name (document ID) matching the user's UID
        DocumentSnapshot<Map<String, dynamic>> userAppointmentDocument =
            await appointmentsCollection.doc(currentUser.uid).get();

        if (userAppointmentDocument.exists) {
          // If a matching appointment document is found, print the details
          print('Nurse Document ID: ${doctorDocument.id}');
          print('Matching Appointment: ${userAppointmentDocument.data()}');

          // Fetch details of the doctor
          DocumentSnapshot<Map<String, dynamic>> doctorDetailsDocument =
              await doctorDocument.reference.get();

          if (doctorDetailsDocument.exists) {
            // Print or use the details of the doctor
            print('Nurse Details: ${doctorDetailsDocument.data()}');

            // Create an AppointmentDetails object and add it to the list
            var nurseDetails = NurseDetails(
                nurseName: doctorDetailsDocument.data()!['name'],
                nurseProfile: doctorDetailsDocument.data()!['profile'],
                appointmentDate: userAppointmentDocument.data()!['date'],
                appointmentSlot: userAppointmentDocument.data()!['slot'],
                appointmentCharges: (doctorDetailsDocument
                        .data()!['housevisit charges'] as int? ??
                    0));
            setState(() {
              isLoaded = true;

              NurseappointmentList.add(nurseDetails);
            });
          }
        }
      }
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'My Bookings',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple),
      body: isLoaded
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: appointmentList.isEmpty && NurseappointmentList.isEmpty
                  ? Center(
                      child: Text(
                        'Currently you have no appointment and house visit schedule with any doctor or nurse',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Doctors Bookings',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: appointmentList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: AppointmentListItem(
                                    appointmentDetails: appointmentList[index]),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              'Nurse Bookings',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: NurseappointmentList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  child: NurseListItem(
                                      nurseDetails:
                                          NurseappointmentList[index]));
                            },
                          ),
                        ],
                      ),
                    ),
            )
          : const SpinKitFadingCircle(
              color: Colors.deepPurple,
              size: 60.0,
            ),
    ));
  }
}

class AppointmentListItem extends StatelessWidget {
  final AppointmentDetails appointmentDetails;

  AppointmentListItem({required this.appointmentDetails});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage:
            NetworkImage(appointmentDetails.doctorProfile, scale: 50),
      ),
      title: Text('Dr. ${appointmentDetails.doctorName}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date: ${appointmentDetails.appointmentDate}'),
          Text('Slot: ${appointmentDetails.appointmentSlot}'),
          Text('Type: ${appointmentDetails.appointmentType}'),
          Text('Charges: ${appointmentDetails.appointmentCharges}'),
        ],
      ),
    );
  }
}

class AppointmentDetails {
  final String doctorName;
  final String doctorProfile;
  final String appointmentDate;
  final String appointmentSlot;
  final String appointmentType;
  final int appointmentCharges;

  AppointmentDetails({
    required this.doctorName,
    required this.doctorProfile,
    required this.appointmentDate,
    required this.appointmentSlot,
    required this.appointmentType,
    required this.appointmentCharges,
  });
}

class NurseListItem extends StatelessWidget {
  final NurseDetails nurseDetails;

  NurseListItem({required this.nurseDetails});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(nurseDetails.nurseProfile, scale: 50),
      ),
      title: Text('Dr. ${nurseDetails.nurseName}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Date: ${nurseDetails.appointmentDate}'),
          Text('Slot: ${nurseDetails.appointmentSlot}'),
          Text('Charges: ${nurseDetails.appointmentCharges}'),
        ],
      ),
    );
  }
}

class NurseDetails {
  final String nurseName;
  final String nurseProfile;
  final String appointmentDate;
  final String appointmentSlot;
  final int appointmentCharges;

  NurseDetails({
    required this.nurseName,
    required this.nurseProfile,
    required this.appointmentDate,
    required this.appointmentSlot,
    required this.appointmentCharges,
  });
}
// void fetchData() async {
  //   try {
  //     // Query the "doctors" collection
  //     QuerySnapshot<Map<String, dynamic>> doctorsSnapshot =
  //         await firestore.collection('doctors').get();

  //     print('Number of doctor documents: ${doctorsSnapshot.size}');

  //     // Iterate through the doctors to find the one with the matching UID in the "appointments" collection
  //     for (var doctorDocument in doctorsSnapshot.docs) {
  //       // Get the "appointments" collection reference
  //       CollectionReference<Map<String, dynamic>> appointmentsCollection =
  //           doctorDocument.reference.collection('appointments');

  //       // Retrieve the document with a name (document ID) matching the user's UID
  //       DocumentSnapshot<Map<String, dynamic>> userAppointmentDocument =
  //           await appointmentsCollection.doc(currentUser.uid).get();

  //       if (userAppointmentDocument.exists) {
  //         // If a matching appointment document is found, create an AppointmentListItem
  //         var appointmentData = userAppointmentDocument.data()!;
  //         var appointmentListItem = AppointmentListItem(
  //           profileUrl: appointmentData['profile'],
  //           firstName: appointmentData['first name'],
  //           lastName: appointmentData['last name'],
  //           date: appointmentData['date'],
  //         );

  //         // Add the ListTile to your UI or display it as needed
  //         print('Doctor Document ID: ${doctorDocument.id}');
  //         print('Matching Appointment: ${userAppointmentDocument.data()}');
  //         print('Appointment Data: $appointmentData');

  //         // For example, add it to a list of widgets
  //         appointmentList.add(appointmentListItem);
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  // }