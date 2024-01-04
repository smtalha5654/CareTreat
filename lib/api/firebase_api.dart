import 'dart:convert';
import 'package:caretreat/models/notifications_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:caretreat/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Future<void> addNotificationToDoctor(
  //     String doctorid, RemoteMessage message) async {
  //   final notification = NotificationModel(
  //     title: message.notification?.title ?? '',
  //     body: message.notification?.body ?? '',
  //   );

  //   await _firestore
  //       .collection('doctors')
  //       .doc(doctorid)
  //       .collection('notifications')
  //       .add(notification.toJson());
  // }

  Future<void> addNotificationToPatient(
      String id, RemoteMessage message) async {
    print('id $id');
    final notification = NotificationModel(
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
    );

    await _firestore
        .collection('users')
        .doc(id)
        .collection('notifications')
        .add(notification.toJson());
  }

  Stream<List<NotificationModel>> getPatientNotifications() {
    String id = FirebaseAuth.instance.currentUser!.uid;
    return _firestore
        .collection('users')
        .doc(id)
        .collection('notifications')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              NotificationModel.fromJson(doc.data()))
          .toList();
    });
  }

  final _firebasemessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> showLocalNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false, // Add this line if you don't want to show the timestamp
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: 'notification_details',
    );
  }

  Future<void> InitNotifications() async {
    await _firebasemessaging.requestPermission();
    final FCMToken = await _firebasemessaging.getToken();
    print("FMCToken $FCMToken");
    await _initLocalNotifications();
    InitPushNotifications();
  }

  Future<void> _initLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('Notification clicked: $payload');
          // Handle navigation or other actions based on payload
        }
      },
    );
  }

  void handleMessage(
    RemoteMessage? message,
  ) {
    if (message == null) return;
    print(
        'Handling FCM message: ${message.notification?.title}, ${message.notification?.body}');

    navigatorKey.currentState
        ?.pushNamed('/notification_screen', arguments: message);

    String id = FirebaseAuth.instance.currentUser!.uid;
    addNotificationToPatient(id, message);

    // addNotificationToDoctor(, message);
  }

  Future<void> InitPushNotifications() async {
    _firebasemessaging.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle the notification when the app is in the foreground
      print('onMessage triggered');
      handleMessage(message);
      showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle the notification when the app is opened from terminated state
      print('onMessageopened triggered');
      handleMessage(message);
    });
  }

  Future<void> sendNotificationToDoctor(
      String doctorFCMToken, String patientName, String date) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false, // Add this line if you don't want to show the timestamp
    );

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'New Appointment Booked',
      '$patientName has booked an appointment with you on $date. Check your schedule!',
      platformChannelSpecifics,
      payload: 'appointment_details',
    );
    // Replace 'YOUR_SERVER_KEY' with your actual server key
    print('doctor fmc $doctorFCMToken');
    var serverKey =
        'AAAAfLjBir0:APA91bHiuEwos1whGyS2KieTSzQSL7nfxB5a8YeWUWJVRzefKP0TTUmKtvYge-Gm-bI5dSoCDGSoLghk_J83f_g64vXZ2qD-2OIfDFDKnBgUwrJjg5B9Muv03Rmh7yf89uwOjrglwrBv';

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    var body = {
      'to': doctorFCMToken,
      'notification': {
        'title': 'New Appointment Booked',
        'body':
            '$patientName has booked an appointment with you on $date. Check your schedule!',
      },
    };

    var response =
        await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> sendNotificationToPatient(String doctorName, date) async {
    String? patientFMCToken = await _firebasemessaging.getToken();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false, // Add this line if you don't want to show the timestamp
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Appointment Booked successfully',
      'Your appointment has been booked on $date with $doctorName',
      platformChannelSpecifics,
      payload: 'appointment_details',
    );
    // Replace 'YOUR_SERVER_KEY' with your actual server key
    print('fmc token $patientFMCToken');
    var serverKey =
        'AAAAfLjBir0:APA91bHiuEwos1whGyS2KieTSzQSL7nfxB5a8YeWUWJVRzefKP0TTUmKtvYge-Gm-bI5dSoCDGSoLghk_J83f_g64vXZ2qD-2OIfDFDKnBgUwrJjg5B9Muv03Rmh7yf89uwOjrglwrBv';

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    var body = {
      'to': patientFMCToken,
      'notification': {
        'title': 'Appointment Booked successfully',
        'body': 'Your appointment has been booked on $date with $doctorName',
      },
    };

    var response =
        await http.post(url, headers: headers, body: json.encode(body));

    if (response.statusCode == 200) {
      print('Notification sent successfully');
    } else {
      print('Failed to send notification. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
}
