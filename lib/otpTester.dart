import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class otpTester extends StatefulWidget {
  const otpTester({super.key});

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
  phoneNumber: '+8801886144124',
  verificationCompleted: (PhoneAuthCredential credential) {},
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: (String verificationId, int? resendToken) {},
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