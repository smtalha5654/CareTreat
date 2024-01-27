import 'package:caretreat/Auth/checkroles.dart';
import 'package:caretreat/components/mybutton.dart';
import 'package:caretreat/components/mytextfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String fname = '';
  String lname = '';
  int phone = 0;
  String gender = '';
  String address = '';
  void getDetails() {
    final String id = FirebaseAuth.instance.currentUser!.uid;
    userRef.doc(id).get().then((DocumentSnapshot doc) {
      setState(() {
        fname = doc.get('first name');
        lname = doc.get('last name');
        phone = doc.get('phone');
        gender = doc.get('gender');
        address = doc.get('address');
      });
    });
  }

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late SingleValueDropDownController _gendercontroller;
  TextEditingController addressController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _gendercontroller = SingleValueDropDownController();
    getDetails();
  }

  Future saveChanges() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const SpinKitFadingCircle(
              color: Colors.deepPurple,
              size: 60.0,
            );
          });

      await updateUserDetails(
        firstNameController.text.trim(),
        lastNameController.text.trim(),
        int.parse(phoneController.text.trim()),
        _gendercontroller.dropDownValue!.name.toString().trim(),
        addressController.text.trim(),
      );

      Navigator.of(context).pop(); // Close the loading indicator
      Navigator.of(context).pop();
      getDetails();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Details Updated Successfully",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading indicator

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Failed to update the details. Try again!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        ),
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.h),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  Future updateUserDetails(String firstName, String lastName, int phone,
      String gender, String address) async {
    final id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'first name': firstName,
      'last name': lastName,
      'address': address,
      'phone': phone,
      'gender': gender,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Edit Profile',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditProfileBottomSheet(context);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileInfoRow('First Name', fname),
                profileInfoRow('Last Name', lname),
                profileInfoRow('Phone No', phone.toString()),
                profileInfoRow('Gender', gender),
                profileInfoRow('Address', address),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditProfileBottomSheet(BuildContext context) {
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
                          'Add New Details',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    MyTextField(
                      hinttext: 'Enter First Name',
                      controller: firstNameController,
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      hinttext: 'Enter Last Name',
                      controller: lastNameController,
                      icon: Icons.person,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      hinttext: 'Enter Phone No',
                      controller: phoneController,
                      icon: Icons.phone,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Your existing code for DropDownTextField
                    DropDownTextField(
                      textFieldDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Select Gender',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      clearOption: true,
                      controller: _gendercontroller,
                      validator: (value) {
                        if (value == null) {
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 2,
                      dropDownList: const [
                        DropDownValueModel(name: 'Male', value: "value1"),
                        DropDownValueModel(name: 'Female', value: "value2"),
                      ],
                      onChanged: (val) {},
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    MyTextField(
                      hinttext: 'Enter Address',
                      controller: addressController,
                      icon: Icons.location_on,
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
                        saveChanges();
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
