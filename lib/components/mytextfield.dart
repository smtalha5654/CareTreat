import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      required this.controller,
      required this.hinttext,
      required this.icon});
  final TextEditingController controller;
  final IconData icon;
  String hinttext = '';
  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 4,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
              borderRadius: BorderRadius.circular(12)),
          hintText: hinttext,
          fillColor: Colors.grey[200],
          filled: true),
    );
  }
}
