import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorProfile extends StatelessWidget {
  DoctorProfile(
      {super.key,
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Image.network(profile),
              Padding(
                padding: const EdgeInsets.only(top: 360),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[100],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
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
                                  'Dr $name',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  doctortype,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '$gender | +92$phone',
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
                          about,
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
                          education,
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
                          address,
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
                          experience,
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
                        Text(
                          'House Visit Charges $visitcharges \nAppointment Charges $appointmentcharges',
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Text(
                                'House Visit',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Text(
                                'Clinic Appointment',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        )
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
