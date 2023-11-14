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
                            child: SizedBox(
                              height: 45.h,
                              child: Image.asset(
                                'assets/images/onboardingscreen1.png',
                              ),
                            ),
                          ),
                          Text(
                            'Effortless Appointments',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              'Welcome to CareTreat! Streamline your healthcare journey by effortlessly scheduling appointments at your fingertips. Experience the convenience of personalized care with our intuitive appointment system.Your health is our priority, and with CareTreat, booking appointments has never been smoother.',
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
                                        duration:
                                            const Duration(milliseconds: 500),
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
                            child: SizedBox(
                              height: 45.h,
                              child: Image.asset(
                                  'assets/images/onboardingscreen2.png'),
                            ),
                          ),
                          Text(
                            'In-Home Care Hub',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              "Discover the convenience of CareTreat's innovative house visit feature, a personalized healthcare experience tailored to your doorstep. Effortlessly schedule visits with our user-friendly platform, ensuring medical care is not just accessible but also seamlessly integrated into the comfort of your home. ",
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
                                      duration:
                                          const Duration(milliseconds: 500),
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
                              'assets/images/onboardingscreen3.png',
                              height: 45.h,
                            ),
                          ),
                          Text(
                            'Dynamic Nursing Solutions',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              "CareTreat introduces a revolutionary nursing feature, optimizing your healthcare experience. Seamlessly allocate qualified nurses based on your unique needs, ensuring timely and personalized care. With CareTreat, your well-being is our priority, supported by a dynamic approach to nurse allocation.",
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
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                  },
                                  color: Colors.deepPurple))
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
                            child: SizedBox(
                              height: 45.h,
                              child: Image.asset(
                                'assets/images/onboardingscreen5.png',
                              ),
                            ),
                          ),
                          Text(
                            'Doctor Growth Network',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.h, horizontal: 3.h),
                            child: Text(
                              "Doctors, seize the opportunity with CareTreat! Expand your patient base through our platform's seamless features—easy scheduling, house visits, and dynamic nurse allocation. Elevate your practice and connect with patients in a new era of personalized healthcare.",
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
                                    return const Main_Page();
                                  }));
                                },
                                color: Colors.deepPurple),
                          ),
                        ],
                      )),
                ),
                // SingleChildScrollView(
                //   child: Container(
                //       color: Colors.white,
                //       child: Column(
                //         children: [
                //           Padding(
                //             padding: EdgeInsets.symmetric(vertical: 2.5.h),
                //             child: Image.asset(
                //               'assets/images/onboardingscreen4.png',
                //               height: 45.h,
                //             ),
                //           ),
                //           Text(
                //             'Medical Tests at Home',
                //             style: TextStyle(
                //               fontSize: 21.sp,
                //               fontWeight: FontWeight.bold,
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 2.h, horizontal: 3.h),
                //             child: Text(
                //               "CareTreat provide Laboratory option for patient so that they can make a House call for different medical tests in which a professional comes at patients home and bring their equipment with them to perform different Medical tests. ",
                //               style: TextStyle(
                //                 fontSize: 13.sp,
                //                 fontWeight: FontWeight.w500,
                //               ),
                //               textAlign: TextAlign.center,
                //             ),
                //           ),
                //           Padding(
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 1.5.h, horizontal: 4.h),
                //             child: MyButton(
                //                 textStyle: TextStyle(
                //                     fontSize: 14.sp,
                //                     fontWeight: FontWeight.bold,
                //                     color: Colors.white),
                //                 title: 'Get Started',
                //                 ontap: () async {
                //                   await _storeOnBoardInfo();
                //                   Navigator.pushReplacement(context,
                //                       MaterialPageRoute(
                //                           builder: (BuildContext) {
                //                     return const Main_Page();
                //                   }));
                //                 },
                //                 color: Colors.deepPurple),
                //           ),
                //         ],
                //       )),
                // ),
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
                        return const Main_Page();
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
                      SmoothPageIndicator(
                          effect: const WormEffect(),
                          controller: _controller,
                          count: 4),
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
