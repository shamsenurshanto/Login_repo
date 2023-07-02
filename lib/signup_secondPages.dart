import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screens/Signup/components/sign_up_top_image.dart';
import 'Screens/Signup/components/signup_form_pages.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Screens/Login/login_screen.dart';
import 'package:my_app/components/already_have_an_account_acheck.dart';
import 'package:my_app/otpPhoneCode.dart';
import 'package:my_app/otpTester.dart';

import '../../../constants.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/Screens/Login/components/login_form.dart';
import 'package:my_app/Tokener.dart';
import 'package:my_app/addTransaction2.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
// import '../../Login/login_screen.dart';
import 'package:http/http.dart' as http;

class signup_second_pages extends StatefulWidget {
  const signup_second_pages({super.key});

  @override
  State<signup_second_pages> createState() => _signup_second_pagesState();
}

var _textControllerForName = TextEditingController();
var _textControllerForPhoneNumber = TextEditingController();
var _textControllerForEmail = TextEditingController();
var _textControllerForPassword = TextEditingController();

   
    Future<void> initState() async {
  
 await Hive.initFlutter();
    var box = await Hive.openBox("mybox");
   
    }

   postDate(context) async {
  
     await Hive.initFlutter();
    var box = await Hive.openBox("mybox");

        String  username = "g";
        String  PhoneNumber = "g";
        String  email_ = "g";
        String  password_ = "g";

          username = _textControllerForName.text;
          PhoneNumber = _textControllerForPhoneNumber.text;
          email_ = _textControllerForEmail.text;
          password_ = _textControllerForPassword.text;
           var url = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login");
//  final responsew = await http.get(Uri.parse('http://your-nodejs-server.com/get-jwt-token'));

   // Make a request to the Node.js server to get a JWT token
   if(username==null)
   {
       username = "ab03@gmail.com";
   }
   
  final response = await http.post(
    Uri.parse("https://personalrec.onrender.com/api/auth/signup"),
    body: {
    "userName":username,
    "userEmail":email_,
    "userPhone":PhoneNumber,
    "userPass":password_
},
  );
  print(response.body);

 


  // Save the JWT token as a global variable
  // MyCookieClass.jwtToken = cookie;

 
   



  
    var gh = response.body;
    print("hoise *****************************************");
    print(response.body);
    // print("token from main login " + jwtToken);
    var jh = json.decode(response.body);
  print(jsonDecode(gh)["success"]);
    // print(username.toString());
    if(jsonDecode(gh)["success"])
    {
      // print("hoise");
      // print(jwtToken);

      // _box.put("User_id",jh['data']['_id'] );
      //   _box.put("User_email",username );
      final _box = Hive.box("mybox");
    _box.put("phone_number", _textControllerForPhoneNumber.text);
    print(_box.get("phone_number"));
       Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // return MyBottomNavigationBar();
                    return otpTester();
                  },
                ),
              );
    }
    else
    {
      // give a toast here 
    }
   }

class _signup_second_pagesState extends State<signup_second_pages> {
  @override
  
  Widget build(BuildContext context) {
      var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;

    var temp = 0.0;
   
    var width_safearea2 = 392;
    var height_safearea2 = 750;
    bool showpass = true;
    return Scaffold(
   body: SingleChildScrollView(child: 
          Column(
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  SignUpScreenTopImage(),
              ],
            ),
              SizedBox(
                height: 30,
              ),

                SizedBox(
                  width: width_safearea*.8,
                  child: Form(
      
      child: Column(
        
        children: [

         
         

          TextField(
            controller: _textControllerForName,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            // onpr: (email) {},
            decoration: InputDecoration(
              hintText: "Your Name",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.account_box_sharp),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              controller: _textControllerForPhoneNumber,
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                 prefix: GestureDetector(
                onTap: () {
                  print('tapped');
                },
                child: Text(
                  '+880 ',
                  style: TextStyle(
                   
                      color: const Color.fromARGB(255, 4, 24, 41), fontWeight: FontWeight.bold),
                ),
              ),
                hintText: "Your Phone Number",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: TextField(
              controller: _textControllerForEmail,
              textInputAction: TextInputAction.done,
              obscureText: false,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your Email",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.email),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextField(
              controller: _textControllerForPassword,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                 suffix: GestureDetector(
                onTap: () {
                  print('tapped');
                },
                child: Text(
                  'show Passwords',
                  style: TextStyle(
                   
                      color:Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              ),
                hintText: "Password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.phone),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
               print("sign up");
               postDate(context);


            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    )
       
          ,
                )


            ],
          )
   
   ) 

    );
  }
}