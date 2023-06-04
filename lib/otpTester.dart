import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'otpPhoneCode.dart';

class otpTester extends StatefulWidget {
  const otpTester({super.key});
  static String verify ="";

  @override
  State<otpTester> createState() => _otpTesterState();
}

class _otpTesterState extends State<otpTester> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:  Center(
        child: Container(
        child: Center(
          child: Column(
          children: [
            Text("hello"),
            ElevatedButton(onPressed: () async {
              print("hello");
     await FirebaseAuth.instance.verifyPhoneNumber(
  phoneNumber: '+8801964613773',//01850134450  01886144124 735228 
  verificationCompleted: (PhoneAuthCredential credential) {},
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) {
    otpTester.verify=verificationId;

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



            }, child: Text("click"))
          ],
        ),
        )
      ),
      ),)
    );
  }
}