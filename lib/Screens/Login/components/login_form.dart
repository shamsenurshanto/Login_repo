import 'package:flutter/material.dart';
// import 'package:flutter_auth/Tokener.dart';
import 'package:my_app/Tokener.dart';
import 'package:my_app/homeGrid.dart';
import 'package:my_app/homePage2.dart';
import 'package:my_app/newTbb.dart';
import 'package:my_app/otpPhoneCode.dart';
import 'package:my_app/tbb.dart';
import 'package:my_app/constants.dart';


import '../../../components/already_have_an_account_acheck.dart';
// import '../../../constants.dart';
import '../../../homegrid2.dart';
import '../../../otpTester.dart';
import '../../../testUserdetails.dart';
import '../../../userDetailsTesting.dart';
import '../../Signup/signup_screen.dart';
import 'dart:convert';
// import 'package:flutter_auth/tbb.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var name, email, _selectedLanguage = "English";

//after changes
  void initState() {
    /// here the val_sum = 0
    //  final _box = Hive.box("mybox");
    super.initState();
    print("----------ppppppppppppppppppp");
    // print(_box.get("val_sum"));

    // if( _box.get("val_sum").toString()==null)
    //   {
    //     _box.put("val_sum", 0);
    //   }
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  postDate(context) async {
    String username = "g";
    username = emailController.text;
    var url = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login");
//  final responsew = await http.get(Uri.parse('http://your-nodejs-server.com/get-jwt-token'));

    // Make a request to the Node.js server to get a JWT token
    if (username == null) {
      username = "ab03@gmail.com";
    }
    ////dev.aloitconsultants.com:4000

    final response = await http.post(
      Uri.parse("https://personalrec.onrender.com/api/auth/login"),
      body: {'userEmailPhone': username, 'userPass': '12345678'},
    );
    print(response.body);

    // Extract the cookie from the response headers
    String cookie = response.headers['set-cookie']!;

    // Print the cookie
    print("in Login ------------------------------------");
    print(cookie);
    print(username.toString());
    await Hive.initFlutter();
    var box = await Hive.openBox("mybox");
    final _box = Hive.box("mybox");
    _box.put("tokens", cookie);

    print("in Login222 ------------------------------------");
    print(_box.put("tokens", cookie));

    var gh = response.body;
    print("hoise *****************************************");
    print(response.body);
    // print("token from main login " + jwtToken);
    var jh = json.decode(response.body);
    print(jh['data']['_id']);
    // print(username.toString());
    if (jsonDecode(gh)["success"]) {
      print("hoise");
      print(jwtToken);

      _box.put("User_id", jh['data']['_id']);
      _box.put("User_email", username);
      _box.put("User_id", jh['data']['_id']);
      _box.put("User_name2", jh['data']['userName']);
      _box.put("User_email", username);
      _box.put("Lang_val", "English");
      final _box2 = Hive.box("mybox");
      var name_ = _box2.get("User_name2");
      print("ooooooooooooooooooooooooooooooooooo");
      print(name_);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            // return MyBottomNavigationBar();

            return dash_newMyBottomNavigationBar_new();
            // return otpTester();
            // return otpPhone();

            //userdetails_new_with_sidebar

          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              //it is the button for login here  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+--+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
              onPressed: () {
                print("login_form");
                postDate(context);
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}