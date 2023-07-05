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
import 'Screens/Login/login_screen.dart';
import 'models/team.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'newTbb.dart';

class ForgotPass_page extends StatefulWidget {
  late final String phoneNumber;
  late final String otp;

  ForgotPass_page({required this.phoneNumber, required this.otp});

  @override
  State<ForgotPass_page> createState() => _ForgotPass_pageState();
}

class _ForgotPass_pageState extends State<ForgotPass_page> {
  get http => null;

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController _textController_For_EmailSearch =
        TextEditingController();
    print(widget.phoneNumber + " " + widget.otp);

    void initState() {
      //        var box =  Hive.openBox("mybox");
      // final _box2 = Hive.box("mybox");
      //  var _idLoggedIn= _box2.get("User_id");//my user id
      //     var     email= _box2.get("User_email");
      //       var   name= _box2.get("User_name");
    }
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 33, 7, 79),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailController,

                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    // cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Enter Your New Password",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.lock_outline),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _textController_For_EmailSearch,

                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    // cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.lock_open),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: ElevatedButton(
                      onPressed: () async {
                        print(
                            widget.phoneNumber + " ----------- " + widget.otp);

                    

                        
                        try {
                          var lastPassword = emailController.text;
                             var response;
                             print({
                              "userPhone": widget.phoneNumber,
                              "otp": widget.otp,
                              "userPass":lastPassword // Remove the toString() method
                            } );
                            var jscon = {
                              "userPhone": widget.phoneNumber,
                              "otp": widget.otp,
                              "userPass":lastPassword // Remove the toString() method
                            };
                          response = await http.post(
                            Uri.https('personalrec.onrender.com',
                                'api/auth/resetpassword'),
                            headers: {
                              'Content-Type': 'application/json; charset=UTF-8',
                              // 'Cookie': 'jwt_token=$gh',
                            },
                            body: jscon
                          );

                          var jsonData = jsonDecode(response.body);
                          print("  -----  ");
                          print(response.body);
                          print(jsonData);
                          Fluttertoast.showToast(msg: jsonData["message"]);
                          if (jsonData["success"] &&
                              emailController.text ==
                                  _textController_For_EmailSearch.text) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return LoginScreen();
                                  //         // return userDetails("email");
                                },
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(msg: jsonData["message"]);
                          } // print(a1 + a2 + a3 + a4 + a5 + a6);
                        } catch (e) {
                          print(e);
                          Fluttertoast.showToast(msg: "User Not exit ");
                          setState(() {
                            // data = resp['slip']['advice'];
                          });
                        }
                      },
                      child: Text("Verified")),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
        ))

        // ,

        );
  }
}
