import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'otpPhoneCode.dart';

class otpTester extends StatefulWidget {
  const otpTester({super.key});
  static String verify = "";

  @override
  State<otpTester> createState() => _otpTesterState();
}

class _otpTesterState extends State<otpTester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 41, 10, 93),
        body: SafeArea(
          child: Center(
            child: Container(
                child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Padding(padding: EdgeInsets.fromLTRB(20,40,0,30),
                     
                     
                     child:   Text(
                        "Verification Code",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                     )
                    ],
                  ),
                   SizedBox(
                    height: 60,
                   ),

                    Padding(padding: EdgeInsets.fromLTRB(20,0,0,0),
                    
                    child:  Text(
                        "We Want to send You an OTP Code to this number for the Varification ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    
                    ),
                    SizedBox(
                      height: 0,
                    ),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(padding: EdgeInsets.all(20),
                    
                    child:  Text(
                        "019******73",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    
                    ),
                    ],
                   ),

                    SizedBox(
                    height: 300,
                   ),



                  ElevatedButton(
                      onPressed: () async {
                        print("hello");
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber:
                              '+8801964613773', //01850134450  01886144124 735228
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            otpTester.verify = verificationId;

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  // return MyBottomNavigationBar();

                                  // return dash_newMyBottomNavigationBar_new();
                                  // return otpTester();
                                  return otpPhone();

                                  //userdetails_new_with_sidebar
                                },
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      },
                      child: Text("SEND OTP"))
                ],
              ),
            )),
          ),
        ));
  }
}
