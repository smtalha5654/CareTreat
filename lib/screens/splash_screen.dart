import 'package:caretreat/Pages/main_page.dart';
import 'package:caretreat/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:caretreat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/splashscreen.png',
      splashIconSize: double.infinity,
      nextScreen: isViewed !=0 ? WelcomeScreen() : Main_Page(),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      curve: Curves.easeIn,
      centered: true,
    );
  }
}
