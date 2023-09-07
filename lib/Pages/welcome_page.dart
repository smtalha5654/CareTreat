import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'Welcome! To CareTreat \n Register As',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Signika',
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          toolbarHeight: 200,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(180),
          )),
          elevation: 0,
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueGrey[200]),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/doctor.png',
                            scale: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                border: Border.all(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              'Doctor',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueGrey[200]),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/patient.png',
                            scale: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                border: Border.all(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              'Patient',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueGrey[200]),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/nurse.png',
                            scale: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                border: Border.all(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              'Nurse',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueGrey[200]),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/lab.png',
                            scale: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                border: Border.all(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              'Lab',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have Account?',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        border: Border.all(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
