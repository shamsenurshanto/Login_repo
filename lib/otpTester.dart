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
import 'models/team.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
  import 'package:intl/intl.dart';
import 'newTbb.dart';

import 'otpPhoneCode.dart';

class otpTester extends StatefulWidget {
  const otpTester({super.key});
  static String verify = "";

  @override
  State<otpTester> createState() => _otpTesterState();
}

var mobile_num2 = "90000000009";

void initState() async {
  // super.initState();
  // await Hive.initFlutter();
  var box = await Hive.openBox("mybox");

  //  setState(){
  //   mobile_num2=_box.get("phone_number").toString();
  //   print(mobile_num2);
  //  }
  //  mobile_num2=_box.get("phone_number");
}

String manipulateString(String input) {
  // Perform string manipulation logic here
  // For example, you can convert the input to uppercase
  var stringMob = "";
  for (int i = 0; i < input.length; i++) {
    {
      if (i > 2 && i < 9) {
        stringMob += "*";
      } else {
        stringMob += input[i];
      }
      print(stringMob);
    }
  }

  // Return the manipulated string
  return stringMob;
}

class _otpTesterState extends State<otpTester> {
  @override
  Widget build(BuildContext context) {
    final _box = Hive.box("mybox");
    print(_box.get("phone_number"));
    var mobile_num33 = _box.get("phone_number").toString();

    var mobile_num3 = manipulateString(_box.get("phone_number").toString());
    print(mobile_num2);

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
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
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
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          mobile_num3.toString(),
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

                        var box = await Hive.openBox("mybox");
                        final _box2 = Hive.box("mybox");
                        var gh = _box2.get("toki");
                        print(gh);
                        // String user_name = _textController_For_EmailSearch.text;

                        //  print("https://personalrec.onrender.com/api/user/searchuser/${_textController_For_EmailSearch.text}");
                        var response;
                        try {
                          response = await http.post(
                            Uri.https(
                                'personalrec.onrender.com', 'api/auth/otp'),
                            headers: {
                              //  'Content-Type': 'application/json; charset=UTF-8',

                              'Cookie': 'jwt_token=$gh'
                            },
                          body: {
                                  "userPhone": "01738042664"
                              }
                          );
                           var  jsonData = jsonDecode(response.body);
                            print(mobile_num33);
                             Fluttertoast.showToast(msg:jsonData["message"]);
                              Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return otpPhone();
                          // return userDetails("email");
                        },
                      ),
                    );
                       
                        } catch (e) {
                          print(e);
                          // Fluttertoast.showToast(msg: "User Not exit ");
                          setState(() {
                            // data = resp['slip']['advice'];
                           
                          });
                        }
                      },
                      child: Text("SEND OTP"))
                ],
              ),
            )),
          ),
        ));
  }
}
