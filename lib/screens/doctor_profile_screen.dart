import 'package:caretreat/Other%20Screens/appointment_request_screen.dart';
import 'package:caretreat/main.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile(
      {super.key,
      required this.id,
      required this.name,
      required this.about,
      required this.address,
      required this.appointmentcharges,
      required this.doctortype,
      required this.education,
      required this.experience,
      required this.gender,
      required this.phone,
      required this.profile,
      required this.visitcharges});
  String name = '';
  int phone = 0;
  String gender = '';
  String doctortype = '';
  String about = '';
  String address = '';
  String education = '';
  int appointmentcharges = 0;
  int visitcharges = 0;
  String experience = '';
  String profile = '';
  String id = '';

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.network(
                widget.profile,
                width: double.infinity,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 20, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Dr. ${widget.name}',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.doctortype,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${widget.gender} | +92${widget.phone}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.deepPurple),
                                child: const Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 50,
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 1.7,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'About',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.about,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Education',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.education,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Location',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.address,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Experience',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.experience,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Fee/Charges',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        widget.visitcharges == 0
                            ? SizedBox.shrink()
                            : Text(
                                'House Visit Charges ${widget.visitcharges}',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                ),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Appointment Charges ${widget.appointmentcharges}',
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        isOwnProfileSelected
                            ? SizedBox.shrink()
                            : Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AppointmentRequestScreen(
                                        appointmentCharges:
                                            widget.appointmentcharges,
                                        housevisitCharges: widget.visitcharges,
                                        id: widget.id,
                                      );
                                    }));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 2.h),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          border: Border.all(
                                              color: Colors.deepPurple),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Text(
                                        widget.visitcharges == 0
                                            ? 'Book Appointment'
                                            : 'Book Appointment or House Visit',
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[300]),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isOwnProfileSelected = false;
                            });

                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.deepPurple,
                          ),
                        )),
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey[300]),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.deepPurple,
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
