import 'package:caretreat/components/mybutton.dart';
import 'package:caretreat/components/mytextfield.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class CreateDoctorProfile extends StatefulWidget {
  const CreateDoctorProfile({super.key});

  @override
  State<CreateDoctorProfile> createState() => _CreateDoctorProfileState();
}

class _CreateDoctorProfileState extends State<CreateDoctorProfile> {
  final _namecontroller = TextEditingController();
  final _experiencecontroller = TextEditingController();
  final _descriptioncontroller = TextEditingController();
  late SingleValueDropDownController _doctortypecontroller;
  late SingleValueDropDownController _gendercontroller;
  final _phonecontroller = TextEditingController();
  @override
  void initState() {
    _doctortypecontroller = SingleValueDropDownController();
    _gendercontroller = SingleValueDropDownController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 0.1.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/loginlogo.png',
                height: 25.h,
              ),
              Text('CareTreat',
                  style: TextStyle(fontSize: 45.sp, fontFamily: 'BebasNeue')),
              Text(
                'Create Your Digital Profile',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 12),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: MyTextField(
                      controller: _namecontroller,
                      hinttext: 'Enter Name',
                      icon: Icons.account_circle)),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Phone Number',
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: DropDownTextField(
                    textFieldDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Select Gender',
                        fillColor: Colors.grey[200],
                        filled: true),
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
                    dropDownList: [
                      DropDownValueModel(name: 'Male', value: "value1"),
                      DropDownValueModel(name: 'Female', value: "value2"),
                    ],
                    onChanged: (val) {},
                  )),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.h),
                  child: DropDownTextField(
                    enableSearch: true,
                    textFieldDecoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Select Doctor Type',
                        fillColor: Colors.grey[200],
                        filled: true),
                    clearOption: true,
                    controller: _doctortypecontroller,
                    validator: (value) {
                      if (value == null) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 6,
                    dropDownList: [
                      DropDownValueModel(
                          name: 'General practitioner', value: "value1"),
                      DropDownValueModel(name: 'Pediatrician', value: "value2"),
                      DropDownValueModel(name: 'Gynecologist', value: "value3"),
                      DropDownValueModel(name: 'Cardiologist', value: "value4"),
                      DropDownValueModel(name: 'Oncologist', value: "value5"),
                      DropDownValueModel(
                          name: 'Gastroenterologist', value: "value6"),
                      DropDownValueModel(
                          name: 'Pulmonologist', value: "value7"),
                      DropDownValueModel(
                          name: 'Infectious disease', value: "value8"),
                      DropDownValueModel(name: 'Nephrologist', value: "value9"),
                      DropDownValueModel(
                          name: 'Endocrinologist', value: "value10"),
                      DropDownValueModel(
                          name: 'Ophthalmologist', value: "value11"),
                      DropDownValueModel(
                          name: 'Dermatologist', value: "value12"),
                      DropDownValueModel(
                          name: 'Psychiatrist', value: "value13"),
                      DropDownValueModel(name: 'Neurologist', value: "value14"),
                      DropDownValueModel(name: 'Radiologist', value: "value15"),
                      DropDownValueModel(
                          name: 'Anesthesiologist', value: "value16"),
                      DropDownValueModel(name: 'Surgeon', value: "value17"),
                      DropDownValueModel(
                          name: 'Physician executive', value: "value18"),
                    ],
                    onChanged: (val) {},
                  )),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: MyTextField(
                      controller: _descriptioncontroller,
                      hinttext: 'About',
                      icon: Icons.description)),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: MyTextField(
                      controller: _descriptioncontroller,
                      hinttext: 'Address',
                      icon: Icons.home_filled)),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: MyTextField(
                      controller: _descriptioncontroller,
                      hinttext: 'Education',
                      icon: Icons.school)),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _phonecontroller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Fee Charges For Appointment (PKR)',
                        fillColor: Colors.grey[200],
                        filled: true),
                  )),
              SizedBox(
                height: 8,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.h,
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: _phonecontroller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.attach_money),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12)),
                        hintText: 'Fee Charges For House Visit (PKR)',
                        fillColor: Colors.grey[200],
                        filled: true),
                  )),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: MyTextField(
                    controller: _experiencecontroller,
                    hinttext: 'Experience (Optional)',
                    icon: Icons.document_scanner),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.h),
                child: MyButton(
                    title: 'Submit',
                    ontap: () {},
                    color: Colors.deepPurple,
                    textStyle: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
