import 'package:caretreat/Auth/auth_service.dart';
import 'package:caretreat/components/mybutton.dart';
import 'package:caretreat/components/mytextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isNotificationEnabled = false;
  void changePassword() async {
    AuthService authService = AuthService();
    if (newPasswordController.text.trim() ==
        confirmPassowordController.text.trim()) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return const SpinKitFadingCircle(
                color: Colors.deepPurple,
                size: 60.0,
              );
            });
        // Replace 'newPassword' with the actual new password entered by the user
        await authService.changePassword(newPasswordController.text.trim());

        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Password Changed Successfully",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
          backgroundColor: Colors.deepPurple,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ));
      } catch (e) {
        // Handle errors if any
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Error in changing the password please try again",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
          ),
          backgroundColor: Colors.deepPurple,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ));
        print("Error: $e");
      }
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Password Mismatch",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPassowordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _checkNotificationPermissionStatus();
  }

  Future<void> _checkNotificationPermissionStatus() async {
    final status = await Permission.notification.status;
    setState(() {
      isNotificationEnabled = status.isGranted;
    });
  }

  Future<void> _toggleNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status.isGranted) {
      // If notification permission is already granted, and user wants to toggle off
      await openAppSettings(); // Open app settings
    } else {
      // If notification permission is not granted, or user wants to toggle on
      final newStatus = await Permission.notification.request();
      setState(() {
        isNotificationEnabled = newStatus.isGranted;
      });

      // Handle the case where the user denied the permission
      if (!newStatus.isGranted) {
        // Show the system's default permission dialog
        await openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Enable Notifications'),
                trailing: Switch(
                  value: isNotificationEnabled,
                  onChanged: (bool value) {
                    _toggleNotificationPermission();
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Change Password'),
                trailing: Icon(
                  Icons.lock_reset,
                  size: 35,
                  color: Colors.deepPurple,
                ),
                onTap: () {
                  _showChangePassowrdBottomSheet(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePassowrdBottomSheet(BuildContext context) {
    bool isKeyboardVisible = false;

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Builder(
          builder: (BuildContext context) {
            MediaQuery.of(context).viewInsets.bottom > 0
                ? isKeyboardVisible = true
                : isKeyboardVisible = false;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    MyTextField(
                      hinttext: 'Enter New Password',
                      controller: newPasswordController,
                      icon: Icons.lock,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      hinttext: 'Confrim New Passowrd',
                      controller: confirmPassowordController,
                      icon: Icons.lock,
                    ),
                    Visibility(
                      visible: isKeyboardVisible,
                      child: SizedBox(height: 250),
                    ),
                    SizedBox(height: 16),
                    MyButton(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      title: 'Save Changes',
                      ontap: () {
                        changePassword();
                      },
                      color: Colors.deepPurple,
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
