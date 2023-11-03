import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class AppointmentRequestScreen extends StatefulWidget {
  AppointmentRequestScreen(
      {super.key,
      required this.appointmentCharges,
      required this.housevisitCharges});
  int appointmentCharges;
  int housevisitCharges;
  @override
  State<AppointmentRequestScreen> createState() =>
      _AppointmentRequestScreenState();
}

class _AppointmentRequestScreenState extends State<AppointmentRequestScreen> {
  DateTime selectedDate = DateTime.now();
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
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _bookingtypecontroller = SingleValueDropDownController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Booking Request'),
      ),
      body: Padding(
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

            isDateSelected && isTypeSelected
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Please select date and booking type for booking request.",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            SizedBox(
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
                Spacer(),
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
            SizedBox(
              height: 10,
            ),
            DropDownTextField(
              textFieldDecoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.deepPurple),
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
                DropDownValueModel(name: 'Appointment', value: "value1"),
                DropDownValueModel(name: 'House Visit', value: "value2"),
              ],
              onChanged: (val) {
                setState(() {
                  isTypeSelected = true;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            isDateSelected
                ? Text(
                    'Selected Date: ' +
                        '${selectedDate.toLocal()}'.split(' ')[0],
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 10,
            ),
            isTypeSelected
                ? Text(
                    'Selected Type: '
                    '${_bookingtypecontroller.dropDownValue?.name.toString().trim()}',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 10,
            ),
            isTypeSelected ? chargesText() : SizedBox.shrink(),
            SizedBox(
              height: 20,
            ),
            isTypeSelected && isDateSelected
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const SpinKitFadingCircle(
                              color: Colors.deepPurple,
                              size: 60.0,
                            );
                          });
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
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  chargesText() {
    if (_bookingtypecontroller.dropDownValue?.name.toString().trim() ==
        'House Visit') {
      return Text(
        'House Visit Charges: '
        '${widget.housevisitCharges}',
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      );
    } else if (_bookingtypecontroller.dropDownValue?.name.toString().trim() ==
        'Appointment') {
      return Text(
        'Appointment Charges: '
        '${widget.appointmentCharges}',
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
      );
    }
  }
}
