import 'package:caretreat/api/firebase_api.dart';
import 'package:caretreat/models/notifications_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '1 New',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<List<NotificationModel>>(
                stream: FirebaseApi().getPatientNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SpinKitFadingCircle(
                      color: Colors.deepPurple,
                      size: 60.0,
                    ); // or another loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final notifications = snapshot.data ?? [];
                    final reversedNotifications =
                        notifications.reversed.toList();
                    return ListView.builder(
                      itemCount: reversedNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = reversedNotifications[index];
                        return ListTile(
                          title: Text(
                            notification.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(notification.body),
                          leading: Icon(
                            Icons.calendar_month,
                            size: 30,
                            color: Colors.deepPurple,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
            // NotificationTemplate(
            //   image: 'assets/images/successnoti.png',
            //   text:
            //       'You have successfully booked your appointment with Ms. Emily Walker.',
            //   heading: 'Appointment Success',
            // ),
            // NotificationTemplate(
            //   image: 'assets/images/cancellednoti.png',
            //   text:
            //       'You have successfully booked your appointment with Ms. Emily Walker.',
            //   heading: 'Appointment Cancelled',
            // ),
            // NotificationTemplate(
            //   image: 'assets/images/reschedulenoti.png',
            //   text:
            //       'You have successfully booked your appointment with Ms. Emily Walker.',
            //   heading: 'Appoinment Reschduled',
            // )
          ],
        ),
      ),
    );
  }
}
