import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'main.dart';

class DoctorRequestScreen extends StatefulWidget {
  DoctorRequestScreen(
      {super.key,
      required this.requestType,
      required this.name,
      required this.address,
      required this.profile,
      required this.phone,
      required this.date,
      required this.email});
  String requestType = '';
  String name = '';
  String address = '';
  String profile = '';
  String email = '';
  int phone = 0;
  String date = '';

  @override
  State<DoctorRequestScreen> createState() => _DoctorRequestScreenState();
}

class _DoctorRequestScreenState extends State<DoctorRequestScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    setState(() {
      if (timeOfDay != null) {
        selectedTime = timeOfDay;
      }
    });
  }

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
              Image.network(
                widget.profile,
                width: double.infinity,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width,
              ),
              Padding(
                padding: EdgeInsets.only(top: 45.h),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                                  '${widget.name}',
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.requestType + ' Request',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '+92' + widget.phone.toString(),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
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
                          widget.requestType + ' Date',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.date,
                          style: TextStyle(
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Email',
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.email,
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
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              'Select time:',
                              style: TextStyle(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 16.h,
                            ),
                            InkWell(
                              onTap: () {
                                _selectTime(context);
                                setState(() {
                                  isTimeSelected = true;
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Center(
                                    child: Text(
                                  'Select time',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isTimeSelected ? timeText() : SizedBox.shrink()
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 12),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  'Reject',
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        )
                        // Center(
                        //   child: InkWell(
                        //     onTap: () {
                        //       // Navigator.push(context,
                        //       //     MaterialPageRoute(builder: (context) {
                        //       //   return AppointmentRequestScreen(
                        //       //     appointmentCharges:
                        //       //         widget.appointmentcharges,
                        //       //     housevisitCharges: widget.visitcharges,
                        //       //     id: widget.id,
                        //       //   );
                        //       // }));
                        //     },
                        //     child: Padding(
                        //       padding: EdgeInsets.only(bottom: 2.h),
                        //       child: Container(
                        //         padding: const EdgeInsets.symmetric(
                        //             horizontal: 20, vertical: 15),
                        //         decoration: BoxDecoration(
                        //             color: Colors.deepPurple,
                        //             border:
                        //                 Border.all(color: Colors.deepPurple),
                        //             borderRadius: BorderRadius.circular(12)),
                        //         child: Text(
                        //           'Book Appointment & House Visit',
                        //           style: TextStyle(
                        //               fontSize: 16.sp,
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.white),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
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
                    // Container(
                    //     padding: const EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(25),
                    //         color: Colors.grey[300]),
                    //     child: const Icon(
                    //       Icons.favorite,
                    //       color: Colors.deepPurple,
                    //     ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  timeText() {
    if (selectedTime.hour.toString().length == 1 &&
        selectedTime.minute.toString().length == 1) {
      return Text(
        'Selected time: 0${selectedTime.hour}:0${selectedTime.minute}',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      );
    } else if (selectedTime.hour.toString().length == 1) {
      return Text(
        'Selected time: 0${selectedTime.hour}:${selectedTime.minute}',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      );
    } else if (selectedTime.minute.toString().length == 1) {
      return Text(
        'Selected time: ${selectedTime.hour}:0${selectedTime.minute}',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        'Selected time: ${selectedTime.hour}:${selectedTime.minute}',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      );
    }
  }
}
