import 'package:caretreat/Other%20Screens/appointment_request_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorSchedule extends StatefulWidget {
  const DoctorSchedule({super.key});

  @override
  State<DoctorSchedule> createState() => _DoctorScheduleState();
}

TimeOfDay startTime = TimeOfDay.now();
TimeOfDay endTime = TimeOfDay.now();
int duration = 0; // Default duration in minutes

List<String> availableTimeSlots = [];
final _durationController = TextEditingController();

Future updateAvailableSlots(String slots) async {
  final id = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection('doctors').doc(id).update({
    'slots': slots,
  });
}

Future addAvailableSlots(String slots) async {
  final id = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseFirestore.instance.collection('doctors').doc(id).set({
    'slots': slots,
  });
}

class _DoctorScheduleState extends State<DoctorSchedule> {
  List<String> slots = [];
  void getAvailableSots() {
    print('slots loadded');
    final String id = FirebaseAuth.instance.currentUser!.uid;

    final userRef = FirebaseFirestore.instance.collection('doctors');
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      String slotsString = doc.get('slots');
      // Remove extra brackets at the start and end
      slotsString = slotsString.substring(1, slotsString.length - 1);

      List<String> slots = slotsString.split(', ');

      // Print the fetched data to check if it's as expected
      print('Fetched Slots: $slots');

      // Now, update the state with the fetched data
      // Now, update the state with the fetched data
      setState(() {
        this.slots = slots;
      });
    });
  }

  Future submit() async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    try {
      userRef2.doc(id).get().then((DocumentSnapshot doc) {
        if (doc.exists) {
          updateAvailableSlots(availableTimeSlots.toString());
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
          addAvailableSlots(availableTimeSlots.toString());
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

  @override
  void initState() {
    super.initState();
    getAvailableSots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 4.h),
              child: Column(
                children: [
                  Text(
                    'Create Clinic Schedule',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  _buildTimePickerTextField('Select Starting Time', true),
                  SizedBox(height: 16),
                  _buildTimePickerTextField('Select Ending Time', false),
                  SizedBox(height: 16),
                  TextField(
                    controller: _durationController,
                    decoration: InputDecoration(
                      hintText: 'Appointment Duration (min)',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        duration = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: _generateTimeSlots,
                    child: Text('Generate Time Slots'),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Time Slots for Appointment',
                    style:
                        TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                  ),
                  slots.isEmpty
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                    'Time slots is not available please generate time slots for Appointments',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 5, right: 5),
                          child: Wrap(
                            spacing: 15.0,
                            runSpacing: 8.0,
                            children: slots.map((timeSlot) {
                              return buildTimeSlotCard(timeSlot);
                            }).toList(),
                          ),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTimePickerTextField(String buttonText, bool isStart) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        TextField(
          enabled: false,
          controller: TextEditingController(
            text: isStart
                ? _formatTime12Hour(startTime)
                : _formatTime12Hour(endTime),
          ),
          decoration: InputDecoration(
            labelText: isStart ? 'Starting Time' : 'Ending Time',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.grey[200],
            filled: true,
          ),
        ),
        Positioned(
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => selectTime(context, isStart),
              child: Text(buttonText),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void selectTime(BuildContext context, bool isStart) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: isStart ? startTime : endTime,
    );

    if (selectedTime != null) {
      setState(() {
        if (isStart) {
          startTime = selectedTime;
        } else {
          endTime = selectedTime;
        }
      });
    }
  }

  void _generateTimeSlots() {
    // Clear previous time slots
    availableTimeSlots.clear();

    // Convert start and end time to DateTime objects
    DateTime startDate = DateTime(2023, 1, 1, startTime.hour, startTime.minute);
    DateTime endDate = DateTime(2023, 1, 1, endTime.hour, endTime.minute);

    // Generate time slots based on duration
    while (startDate.add(Duration(minutes: duration)).isBefore(endDate) ||
        startDate.isAtSameMomentAs(endDate)) {
      availableTimeSlots.add(
          '${_formatTime12Hour(TimeOfDay.fromDateTime(startDate))} - ${_formatTime12Hour(TimeOfDay.fromDateTime(startDate.add(Duration(minutes: duration))))}');
      startDate = startDate.add(Duration(minutes: duration));
    }

    setState(() {
      // Ensure there is at least one time slot
      if (availableTimeSlots.isEmpty) {
        availableTimeSlots.add('No available time slots');
      }
    });
    submit();
    getAvailableSots();
  }

  String _formatTime12Hour(TimeOfDay time) {
    // Format the time in 12-hour format with AM/PM
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }

  Widget buildTimeSlotCard(String timeSlot) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              timeSlot,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
