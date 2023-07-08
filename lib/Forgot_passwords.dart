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
import 'package:dio/dio.dart';

class ForgotPass_page extends StatefulWidget {
  late final String phoneNumber;
  late final String otp;

  ForgotPass_page({required this.phoneNumber, required this.otp});

  @override
  State<ForgotPass_page> createState() => _ForgotPass_pageState();
}

class _ForgotPass_pageState extends State<ForgotPass_page> {
  @override
  Widget build(BuildContext context) {
    var apiName = "https://personalrec.onrender.com";
    final TextEditingController emailController = TextEditingController();
    final TextEditingController _textController_For_EmailSearch =
        TextEditingController();
    print(widget.phoneNumber + " " + widget.otp);

    Future<void> initState() async {
      //        var box =  Hive.openBox("mybox");
      //  var box = await Hive.openBox("mybox");
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
                        // // var sty = a1 + a2 + a3 + a4 + a5 + a6;
                        // var box = await Hive.openBox("mybox");Ftext
                        // final _box2 = Hive.box("mybox");
                        // var gh = _box2.get("toki");
                        // print(gh);
                        // String user_name = _textController_For_EmailSearch.text;

                        //  print("https://personalrec.onrender.com/api/user/searchuser/${_textController_For_EmailSearch.text}");
                        // var response;
                        print(
                            widget.phoneNumber + " ----------- " + widget.otp);

                        final response = await http.post(
                            Uri.parse(apiName + "/api/auth/resetpassword"),
                            body: {
                              "userPhone": widget.phoneNumber,
                              "otp": widget.otp,
                              "userPass": emailController.text
                            });
                        print(response.body);

                        final jsonData = jsonDecode(response.body);
                        print("  -----  ");
                        // print(response.body.toString());
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
