import 'package:caretreat/api/firebase_api.dart';
import 'package:caretreat/screens/notification_screen.dart';
import 'package:caretreat/screens/splash_screen.dart';
import 'package:caretreat/temp_payment_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:sizer/sizer.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

int? isViewed;
bool isOwnProfileSelected = false;
bool isTimeSelected = false;
final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Stripe.publishableKey =
      'pk_test_51JCiBhBEJyVxZuHvU25pTiJfbzgGthMsbXpDrcpygBLuejtfLjvcTsLQzYklr2ReB8XDkEJrRm7W0ewf1JuxBYXO0033cAAvKP';
  isViewed = prefs.getInt('onBoard');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().InitNotifications();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CareTreat',
          theme: ThemeData(
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepPurple))),
              primarySwatch: Colors.deepPurple,
              primaryColor: Colors.deepPurple),
          home: const SplashScreen(),
          navigatorKey: navigatorKey,
          routes: {
            '/notification_screen': (context) => const NotificationsScreen(),
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
