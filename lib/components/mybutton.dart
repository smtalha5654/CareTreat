import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      required this.title,
      required this.ontap,
      required this.color,
      required this.textStyle});
  String title = '';
  final Function()? ontap;
  final Color color;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: ontap,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24), color: color),
          height: 8.h,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              title,
              style: textStyle,
            ),
          )),
    );
  }
}
