import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/abc.dart';
import 'package:my_app/otpTester.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class otpPhone extends StatefulWidget {
  
  const otpPhone({super.key});

  @override
  State<otpPhone> createState() => _otpPhoneState();
}

class _otpPhoneState extends State<otpPhone> {
  var pin ="";
  final FirebaseAuth auth = FirebaseAuth.instance;
   final TextEditingController emailController = TextEditingController();
  void onPinChanged(String value) {
    setState(() {
      pin += value;
      print(pin);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 33, 7, 79),
      body:  SafeArea(
        child: 
         Column(
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
                    
                    child:Container(
                
                      child:  Icon(
                      Icons.lock_open_outlined,size: 150,
                      color: Colors.white,
                    ),
                    )
                    
                    ),
                      Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(padding: EdgeInsets.all(20),
                    
                    child:  Text(
                        "OTP CODE ",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    
                    ),
                    ],
                   ),

           Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                  onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                  onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                 onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            )
            ,
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                 onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                  onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                 onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
           
          ],
        ),
      ),
       SizedBox(
              height: 90,
            ),
          
          
          SizedBox(
        child: ElevatedButton(onPressed: () async {

         try{
           print("--++++++++--------");
    print(pin.toString());
           // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: otpTester.verify, smsCode: pin.toString());

    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential);
   

                 Navigator.push(context,MaterialPageRoute(
                                    builder: (context) {
                                      return abc();

                                      // return userDetails(teams[index].mainMail);
                                    }

                                    ,
                                  )

                                  ,
                                );
               
        
         }
         catch(e){
          print(e);
           print("------------------");
    print(pin.toString());
          
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