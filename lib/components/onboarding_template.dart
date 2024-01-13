import 'package:caretreat/components/mybutton.dart';
import 'package:flutter/material.dart';

class OnboardingTemplate extends StatelessWidget {
  const OnboardingTemplate({
    super.key,
    required this.onBoardingImage,
    required this.heading,
    required this.decsription,
    required this.onPressed,
  });
  final String onBoardingImage;
  final String heading;
  final String decsription;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            onBoardingImage,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    heading,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(17, 25, 40, 1)),
                  ),
                ),
                Text(
                  decsription,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'inter',
                      color: Color.fromRGBO(107, 114, 128, 1)),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: MyButton(
                      title: 'Next',
                      ontap: onPressed,
                      // _controller.nextPage(
                      //     duration: const Duration(milliseconds: 400),
                      //     curve: Curves.easeIn);
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
