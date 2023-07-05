import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:my_app/Forgot_passwords.dart';
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
import 'otpPhoneCode_2.dart';

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
  // var box = await Hive.openBox("mybox");

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
    // final _box = Hive.box("mybox");
    // print(_box.get("phone_number"));
        var pin = "";
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final TextEditingController emailController = TextEditingController();
  var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;

    var temp = 0.0;

    var width_safearea2 = 392;
    var height_safearea2 = 750;
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

    var mobile_num33 = "_box.getoString();";

    var mobile_num3 = manipulateString("_box.getphone_number");
    print(mobile_num2);

      final TextEditingController emailController = TextEditingController();
  final TextEditingController _textController_For_EmailSearch = TextEditingController();
     var Verification_page=0;
     var otp_page=0;
        String user_name = _textController_For_EmailSearch.text;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 41, 10, 93),
        body: 
        
        SafeArea(
          child:   Verification_page==0?
                   Center(
            child: Container(
                child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 160,
                  ),
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
                
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "We Want to send You an OTP Code to this number for the Varification ",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                        Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _textController_For_EmailSearch,
                          
                          textInputAction: TextInputAction.done,
                          obscureText: false,
                          // cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            hintText: "Your Phone Number",
                            
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.phone),
                            ),
                          ),
                           keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                      

                  ElevatedButton(
                      onPressed: () async {
                        print("hello");
                        user_name = _textController_For_EmailSearch.text;
                        setState(() {
                          Verification_page=1;
                        });

                        // var box = await Hive.openBox("mybox");
                        // final _box2 = Hive.box("mybox");
                        var gh = "_box2.get()";
                      
                      print("user_name");
                          print(user_name);

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
                                  "userPhone":user_name.toString()
                              }
                          );
                           var  jsonData = jsonDecode(response.body);
                            print(mobile_num33);
                             Fluttertoast.showToast(msg:jsonData["message"]);
                             if(jsonData["success"])
                              {
                               Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return otpPhone_2(user_name);
                      //         // return userDetails("email");
                            },
                          ),
                         );
                              }
                    else{
                      
                    }
                       
                        } catch (e) {
                          print(e);
                          // Fluttertoast.showToast(msg: "User Not exit ");
                          setState(() {
                            // data = resp['slip']['advice'];
                           
                          });
                        }
                      },
                      child: Text("SEND OTP")
                      )
                ],
              ),
            )),
          ):

          // new pages for otp verificatrion of forgot pass

           SizedBox()
        )
            

          



          /// it is now otp accepeted pages 
          /// 
          

        
        
        
        );
        
  }
}
