import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Screens/Login/components/login_form.dart';
import 'package:my_app/abc.dart';
import 'package:my_app/otpTester.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/AddTransactions.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/abc.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/tbb.dart';
import 'Forgot_passwords.dart';
import 'models/team.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'newTbb.dart';

// import 'otpPhone_2Code.dart';

class otpPhone_2 extends StatefulWidget {
  var mobile_number = "";
  // const otpPhone_2({super.key});

  otpPhone_2(this.mobile_number);

  @override
  State<otpPhone_2> createState() => _otpPhone_2State();
}

class _otpPhone_2State extends State<otpPhone_2> {
  var pin = "";

  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  void onPinChanged(String value) {
    setState(() {
      print(pin);
      pin += value;
      print(pin);
    });
  }

  String a1 = "";
  String a2 = "";
  String a4 = "";
  String a5 = "";
  String a6 = "";
  String a3 = "";

  @override
  Widget build(BuildContext context) {
    print(widget.mobile_number);
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;

    var temp = 0.0;

    var width_safearea2 = 392;
    var height_safearea2 = 750;
    //  Hive.openBox("mybox");
    // final _box = Hive.box("mybox");
    // print(_box.get("phone_number"));
    // var mobile_num33 = _box.get("phone_number").toString();
    print(height_safearea);
    print(width_safearea);
    // Future<void> initState() async {
    //      await Hive.openBox("mybox");
    // }
 var control_ver=0;
    void SetCircularIndi(){
       setState(() {
                      control_ver=1;
                    });
    }

    var mobile_num3 = "manipulateString(_box.getoString());";
    print(mobile_num2);
   
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 33, 7, 79),
        body: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 40, 0, 30),
                  child: Text(
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
              height: 0.049668874 * height_safearea,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Container(
                  child: Icon(
                    Icons.lock_open_outlined,
                    size: 0.124172185 * height_safearea,
                    color: Colors.white,
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    "OTP CODE ",
                    style: TextStyle(
                        fontSize: 0.025 * width_safearea,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            control_ver==0?
            Center(
              child:
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.09 * height_safearea,
                    width: 0.15 * width_safearea,
                    child: TextField(
                      onChanged: (value) {
                        FocusScope.of(context).nextFocus();
                        onPinChanged(value);
                        setState(() {
                          a1 = value;
                        });
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
                    height: 0.09 * height_safearea,
                    width: 0.15 * width_safearea,
                    child: TextField(
                      onChanged: (value) {
                        FocusScope.of(context).nextFocus();
                        onPinChanged(value);
                        setState(() {
                          a2 = value;
                        });
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
                    height: 0.09 * height_safearea,
                    width: 0.15 * width_safearea,
                    child: TextField(
                      onChanged: (value) {
                        FocusScope.of(context).nextFocus();
                        onPinChanged(value);
                        setState(() {
                          a3 = value;
                        });
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
                    height: 0.09 * height_safearea,
                    width: 0.15 * width_safearea,
                    child: TextField(
                      onChanged: (value) {
                        FocusScope.of(context).nextFocus();
                        onPinChanged(value);
                        setState(() {
                          a4 = value;
                        });
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
                    height: 0.09 * height_safearea,
                    width: 0.15 * width_safearea,
                    child: TextField(
                      onChanged: (value) {
                        FocusScope.of(context).nextFocus();
                        onPinChanged(value);
                        setState(() {
                          a5 = value;
                        });
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
                    height: 0.09 * height_safearea,
                    width: 0.15 * width_safearea,
                    child: TextField(
                      onChanged: (value) {
                        FocusScope.of(context).nextFocus();
                        onPinChanged(value);
                        setState(() {
                          a6 = value;
                        });
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
            )
            :
            SizedBox(
              width: width_safearea,
              height: 150,
              child: Center(
                child: CircularProgressIndicator(

              ),
              )
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 0.074503311 * height_safearea,
            ),
            
                SizedBox(
              child:  
              control_ver==0?
               ElevatedButton(
                 
                  child:  Text("Verified") ,
                   onPressed: () async {
                    SetCircularIndi();
                   

                    var sty = a1 + a2 + a3 + a4 + a5 + a6;
                    // var box = await Hive.openBox("mybox");
                    // final _box2 = Hive.box("mybox");
                    var gh = " _box2.get();";
                    print(gh);
                    // String user_name = _textController_For_EmailSearch.text;

                    //  print("https://personalrec.onrender.com/api/user/searchuser/${_textController_For_EmailSearch.text}");
                    var response;
                    try {
                      print(sty + " -----");
                      print(widget.mobile_number);
                      // int otp_num = int.parse(sty);
                      // var bodyData = {
                      //   "userPhone": mobile_num33.toString(),
                      //   "otp": otp_num, // Remove the toString() method
                      // };

                      print({
                        "userPhone": "01738042664",
                        "otp": sty,
                      });

                      response = await http.post(
                        Uri.https(
                            'personalrec.onrender.com', 'api/auth/resetotp'),
                        headers: {
                          'Content-Type': 'application/json; charset=UTF-8',
                          // 'Cookie': 'jwt_token=$gh',
                        },
                        body: jsonEncode({
                          "userPhone": widget.mobile_number,
                          "otp": sty, // Remove the toString() method
                        }), // Convert bodyData to a JSON string
                      );

                      var jsonData = jsonDecode(response.body);
                      print("  -----  ");
                      print(sty);
                      print(jsonData);
                      Fluttertoast.showToast(msg: jsonData["message"]);
                      if (jsonData["success"]) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPass_page(
                                phoneNumber: widget.mobile_number,
                                otp: sty,
                              );
                              //         // return userDetails("email");
                            },
                          ),
                        );
                      } else {
                        //  Fluttertoast.showToast(msg: jsonData["message"]);
                      } // print(a1 + a2 + a3 + a4 + a5 + a6);
                    } catch (e) {
                      print(e);
                      // Fluttertoast.showToast(msg: "User Not exit ");
                      setState(() {
                        // data = resp['slip']['advice'];
                      });
                    }
                    setState(() {
                      pin = "";
                    });
                  },
                  
                  
                  )
                  :
                   Center(
                    child: CircularProgressIndicator(),
                  )  ,
            )
                   
         
         
          ],
        )));
  }
}