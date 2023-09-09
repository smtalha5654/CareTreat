import 'package:caretreat/Auth/main_page.dart';

import 'package:caretreat/components/mybutton.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

final _controller = PageController();

_storeOnBoardInfo() async {
  int isViewed = 0;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('onBoard', isViewed);
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              children: [
                SingleChildScrollView(
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 2.5.h,
                            ),
                            child: Container(
                              height: 45.h,
                              child: Image.asset(
                                'assets/images/onboardingscreen1.png',
                              ),
                            ),
                          ),
                          Text(
                            'Book Appointments',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              'If you are facing any health issues use CareTreat to book any specialized Doctor Appointment with just one click. We Provide all types of doctors Such as Dental, Injury, Mental health, Muscle strain, Obesity, Arthritis, Asthma, etc. ',
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 4.h),
                              child: MyButton(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  title: 'NEXT',
                                  ontap: () {
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                  color: Colors.deepPurple)),
                        ],
                      )),
                ),
                SingleChildScrollView(
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.5.h),
                            child: Container(
                              height: 45.h,
                              child: Image.asset(
                                  'assets/images/onboardingscreen2.png'),
                            ),
                          ),
                          Text(
                            'Book House Call',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              "CareTreat provide a House Call feature for patients. A house call is medical consultation performed by a doctor or other healthcare professionals visiting the home of a patient or client, instead of the patient visiting the doctor's clinic or hospital",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 4.h),
                            child: MyButton(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                title: 'NEXT',
                                ontap: () {
                                  _controller.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                color: Colors.deepPurple),
                          ),
                        ],
                      )),
                ),
                SingleChildScrollView(
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.5.h),
                            child: Container(
                              height: 45.h,
                              child: Image.asset(
                                'assets/images/onboardingscreen5.png',
                              ),
                            ),
                          ),
                          Text(
                            'Increase Your Patients',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              "CareTreat provide a great opportunity to Doctors they can increase their patient base easily. Doctor can provide both Appointment or House Call service to their patients or can provide any one of them. Providing both service will increase more patient quickly",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.5.h, horizontal: 4.h),
                              child: MyButton(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  title: 'NEXT',
                                  ontap: () {
                                    _controller.nextPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                  color: Colors.deepPurple)),
                        ],
                      )),
                ),
                SingleChildScrollView(
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.5.h),
                            child: Container(
                              child: Image.asset(
                                'assets/images/onboardingscreen3.png',
                                height: 45.h,
                              ),
                            ),
                          ),
                          Text(
                            'Home Nursing Care',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              "In home nursing care is intended mainly for clients who are well enough to be discharged from hospital, but are still in need of a nurse to perform preventative and/or rehabilitative services. Nursing care at home can be short-term, long-term ",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 4.h),
                            child: MyButton(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                title: 'NEXT',
                                ontap: () {
                                  _controller.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                color: Colors.deepPurple),
                          ),
                        ],
                      )),
                ),
                SingleChildScrollView(
                  child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.5.h),
                            child: Image.asset(
                              'assets/images/onboardingscreen4.png',
                              height: 45.h,
                            ),
                          ),
                          Text(
                            'Medical Tests at Home',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              "CareTreat provide Laboratory option for patient so that they can make a House call for different medical tests in which a professional comes at patients home and bring their equipment with them to perform different Medical tests. ",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.5.h, horizontal: 4.h),
                            child: MyButton(
                                textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                title: 'Get Started',
                                ontap: () async {
                                  await _storeOnBoardInfo();
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext) {
                                    return Main_Page();
                                  }));
                                },
                                color: Colors.deepPurple),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 4.h, top: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _storeOnBoardInfo();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext) {
                        return Main_Page();
                      }));
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: SmoothPageIndicator(
                            effect: WormEffect(),
                            controller: _controller,
                            count: 5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
