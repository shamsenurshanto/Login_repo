import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/otpTester.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class otpPhone extends StatefulWidget {
  
  const otpPhone({super.key});

  @override
  State<otpPhone> createState() => _otpPhoneState();
}

class _otpPhoneState extends State<otpPhone> {
  final FirebaseAuth auth = FirebaseAuth.instance;
   final TextEditingController emailController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: 
         Column(
          children: [
            TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
       
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.person),
              ),
            ),
          ),
          
          
          SizedBox(
        child: ElevatedButton(onPressed: () async {

         try{
           // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: otpTester.verify, smsCode: emailController.text);

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
    print(emailController.text);
         }
         catch(e){
          print(e);
          
         }


        }, child: Text(
          "Ok"
        )
        
        ),
      ),
          ],
       
          
          
           
         )
      )
    );
  }
}