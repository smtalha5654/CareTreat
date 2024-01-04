import 'package:caretreat/api/firebase_api.dart';
import 'package:caretreat/screens/create_doctor_schedule.dart';
import 'package:caretreat/screens/doctor_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

final userRef2 = FirebaseFirestore.instance.collection('doctors');

class AppointmentRequestScreen extends StatefulWidget {
  AppointmentRequestScreen(
      {super.key,
      required this.id,
      required this.appointmentCharges,
      required this.housevisitCharges,
      required this.FMCToken,
      required this.doctorName});
  int appointmentCharges;
  int housevisitCharges;
  String doctorName;
  String FMCToken = '';
  String id = '';
  @override
  State<AppointmentRequestScreen> createState() =>
      _AppointmentRequestScreenState();
}

class _AppointmentRequestScreenState extends State<AppointmentRequestScreen> {
  List<Map<String, dynamic>> bookedAppointments = [];
  Future<List<Map<String, dynamic>>> fetchData() async {
    List<Map<String, dynamic>> tempList = [];

    try {
      var data = await userRef2.doc(widget.id).collection('appointments').get();

      for (var element in data.docs) {
        if (element.exists) {
          var appointmentData = {
            'date': element['date'] as String? ?? '',
            'slot': element['slot'] as String? ?? '',
          };

          tempList.add(appointmentData);
        }
      }

      // Update the bookedAppointments state variable
      setState(() {
        bookedAppointments = tempList;
      });

      print('date $tempList');
      return tempList;
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  DateTime selectedDate = DateTime.now();
  String simpleDateFormat = '';
  String selectedTimeSlot = '';
  bool isTypeSelected = false;
  bool isDateSelected = false;
  late SingleValueDropDownController _bookingtypecontroller;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        simpleDateFormat = DateFormat('yyyy-MM-dd').format(selectedDate);

        // Fetch booked slots for all dates
        fetchData().then((appointments) {
          bookedAppointments = appointments;

          // Filter available slots based on the selected date
          List<String> availableSlotsForSelectedDate =
              getAvailableTimeSlotsForSelectedDate(bookedAppointments);

          // Now, availableSlotsForSelectedDate contains the filtered slots for the selected date
        });
      });
    }
  }

  String fname = '';
  String lname = '';
  int phone = 0;
  String profile = '';
  String address = '';
  String email = FirebaseAuth.instance.currentUser!.email.toString();

  void getName() {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      setState(() {
        fname = doc.get('first name');
        lname = doc.get('last name');
        phone = doc.get('phone');
        profile = doc.get('profile');
        address = doc.get('address');
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _bookingtypecontroller = SingleValueDropDownController();

    fetchData();
    getName();
    getAvailableSots();
  }

  Future<void> sendBookingRequest() {
    return widget.housevisitCharges == 0
        ? userRef2
            .doc(widget.id)
            .collection(
                'appointments') // Reference to the "posts" collection inside the user's document
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
              'date': simpleDateFormat,
              'slot': selectedTimeSlot,
              'type': 'Appointment',
              'first name': fname,
              'last name': lname,
              'phone': phone,
              'profile': profile,
              'email': FirebaseAuth.instance.currentUser?.email,
              'address': address
              // 'content': 'Lorem ipsum dolor sit amet...',
              // Other post data...
            })
            .then((value) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Requeset Added succesfully",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                )))
            .catchError((error) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Error while sending request",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                )))
        : userRef2
            .doc(widget.id)
            .collection(
                'appointments') // Reference to the "posts" collection inside the user's document
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
              'date': simpleDateFormat,
              'slot': selectedTimeSlot,
              'type':
                  _bookingtypecontroller.dropDownValue?.name.toString().trim(),
              'first name': fname,
              'last name': lname,
              'phone': phone,
              'profile': profile,
              'email': FirebaseAuth.instance.currentUser?.email,
              'address': address
              // 'content': 'Lorem ipsum dolor sit amet...',
              // Other post data...
            })
            .then((value) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Requeset Added succesfully",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                )))
            .catchError((error) =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    "Error while sending request",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                  ),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 3),
                )));
  }

  List<String> slots = [];

  void getAvailableSots() {
    final userRef = FirebaseFirestore.instance.collection('doctors');
    userRef.doc(widget.id).get().then((DocumentSnapshot doc) {
      String slotsString = doc.get('slots');
      slotsString = slotsString.substring(1, slotsString.length - 1);
      slots = slotsString.split(', ');
    });
  }

  List<String> getAvailableTimeSlotsForSelectedDate(
      List<Map<String, dynamic>> bookedAppointments) {
    // Filter out booked slots for the selected date
    List bookedSlots = bookedAppointments
        .where((appointment) => appointment['date'] == simpleDateFormat)
        .map((appointment) => appointment['slot'])
        .toList();

    // Filter out booked slots from all available slots
    List<String> availableSlotsForSelectedDate =
        slots.where((slot) => !bookedSlots.contains(slot)).toList();
    return availableSlotsForSelectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text(
          'Booking Request',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "For booking request select date and booking type then click on request button and wait for the doctor response",
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 14.sp,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              widget.housevisitCharges == 0
                  ? isDateSelected
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            widget.housevisitCharges == 0
                                ? 'Please select date for booking request'
                                : "Please select date and booking type for booking request.",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                  : isDateSelected && isTypeSelected
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            widget.housevisitCharges == 0
                                ? 'Please select date for booking request'
                                : "Please select date and booking type for booking request.",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Select booking date:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      isDateSelected = true;
                      _selectDate(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          border: Border.all(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        'Select Date',
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              widget.housevisitCharges == 0
                  ? const SizedBox.shrink()
                  : DropDownTextField(
                      textFieldDecoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12)),
                          hintText: 'Select Booking Type',
                          fillColor: Colors.grey[200],
                          filled: true),
                      clearOption: false,
                      controller: _bookingtypecontroller,
                      validator: (value) {
                        if (value == null) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 2,
                      dropDownList: const [
                        DropDownValueModel(
                            name: 'Appointment', value: "value1"),
                        DropDownValueModel(
                            name: 'House Visit', value: "value2"),
                      ],
                      onChanged: (val) {
                        setState(() {
                          isTypeSelected = true;
                        });
                      },
                    ),
              const SizedBox(
                height: 20,
              ),
              isDateSelected
                  ? Text(
                      'Selected Date: ${'${selectedDate.toLocal()}'.split(' ')[0]}',
                      style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: isTypeSelected ? 10 : 20,
              ),

              isTypeSelected
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Selected Type: '
                        '${_bookingtypecontroller.dropDownValue?.name.toString().trim()}',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      ),
                    )
                  : const SizedBox.shrink(),

              isTypeSelected ? chargesText() : const SizedBox.shrink(),

              isDateSelected
                  ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.grey[350],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.housevisitCharges == 0
                                ? 'Select Time Slot for Appointment'
                                : 'Select Time Slot for Booking',
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold),
                          ),
                          slots.isEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    Center(
                                      child: Text('Time slots is not available',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(
                                      height: 60,
                                    )
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 20, left: 5, right: 5),
                                  child: Wrap(
                                    spacing: 10.0,
                                    runSpacing: 8.0,
                                    children: slots.map((timeSlot) {
                                      return buildTimeSlotCard(
                                          timeSlot, bookedAppointments);
                                    }).toList(),
                                  ),
                                ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 20,
              ),
              widget.housevisitCharges == 0
                  ? isDateSelected
                      ? GestureDetector(
                          onTap: () {
                            sendBookingRequest();
                            FirebaseApi().sendNotificationToDoctor(
                                widget.FMCToken,
                                "$fname $lname",
                                simpleDateFormat);
                            FirebaseApi().sendNotificationToPatient(
                                widget.doctorName, simpleDateFormat);
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                'Send Booking Request',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                  : isTypeSelected && isDateSelected
                      ? GestureDetector(
                          onTap: () {
                            sendBookingRequest();
                            // showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return const SpinKitFadingCircle(
                            //         color: Colors.deepPurple,
                            //         size: 60.0,
                            //       );
                            //     });
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple,
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Text(
                                'Send Booking Request',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }

  chargesText() {
    if (_bookingtypecontroller.dropDownValue?.name.toString().trim() ==
        'House Visit') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          'House Visit Charges: '
          '${widget.housevisitCharges}',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
      );
    } else if (_bookingtypecontroller.dropDownValue?.name.toString().trim() ==
        'Appointment') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          'Appointment Charges: '
          '${widget.appointmentCharges}',
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  Widget buildTimeSlotCard(
      String timeSlot, List<Map<String, dynamic>> bookedAppointments) {
    bool isSelected = availableTimeSlots.contains(timeSlot);
    bool isBooked = bookedAppointments.any((appointment) =>
        appointment['date'] == simpleDateFormat &&
        appointment['slot'] == timeSlot);

    return InkWell(
      onTap: () {
        setState(() {
          if (isBooked) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Please choose different time slot this one is alreay book by someone",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
              ),
              backgroundColor: Colors.deepPurple,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ));
          } else {
            if (isSelected) {
              // If the slot is already selected, clear the selection
              availableTimeSlots.clear();
            } else {
              // If a new slot is selected, clear the previous selection and add the new one
              availableTimeSlots.clear();
              availableTimeSlots.add(timeSlot);
              selectedTimeSlot = timeSlot;
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isBooked
              ? Colors.red
              : (isSelected ? Colors.deepPurple : Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                timeSlot,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
