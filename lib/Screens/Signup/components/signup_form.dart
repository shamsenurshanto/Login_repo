// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:my_app/Screens/Login/components/login_form.dart';
// import 'package:my_app/Tokener.dart';
// import 'package:my_app/addTransaction2.dart';

// import '../../../components/already_have_an_account_acheck.dart';
// import '../../../constants.dart';
// import '../../Login/login_screen.dart';
// import 'package:http/http.dart' as http;
// class SignUpForm extends StatelessWidget {
  
//   const SignUpForm({
//     Key? key,
//   }) : super(key: key);
    
// //  var _textControllerForName = TextEditingController();
//    postDate(context) async {
  
   

//         String  username = "g";
//         String  PhoneNumber = "g";
//         String  email_ = "g";
//         String  password_ = "g";

//           username = _textControllerForName.text;
//           PhoneNumber = _textControllerForPhoneNumber.text;
//           email_ = _textControllerForEmail.text;
//           password_ = _textControllerForPassword.text;
//            var url = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login");
// //  final responsew = await http.get(Uri.parse('http://your-nodejs-server.com/get-jwt-token'));

//    // Make a request to the Node.js server to get a JWT token
//    if(username==null)
//    {
//        username = "ab03@gmail.com";
//    }
   
//   final response = await http.post(
//     Uri.parse("https://personalrec.onrender.com/api/transaction/usersalltransactions"),
//     body: {
//     "userName":username,
//     "userEmail":email_,
//     "userPhone":PhoneNumber,
//     "userPass":password_
// },
//   );
//   print(response.body);

//  // Extract the cookie from the response headers
//   String cookie = response.headers['set-cookie']!;

//   // Print the cookie
//   print("in Login ------------------------------------");
//   print(cookie);
//   print(username.toString());
//   await Hive.initFlutter();
//   var box = await Hive.openBox("mybox");
//   final _box = Hive.box("mybox");
//   _box.put("tokens", cookie);

//    print("in Login222 ------------------------------------");
//   print(_box.put("tokens", cookie));



//   // Save the JWT token as a global variable
//   // MyCookieClass.jwtToken = cookie;

 
   



  
//     var gh = response.body;
//     print("hoise *****************************************");
//     print(response.body);
//     // print("token from main login " + jwtToken);
//     var jh = json.decode(response.body);
//   print(jh['data']['_id']);
//     // print(username.toString());
//     if(jsonDecode(gh)["success"])
//     {
//       print("hoise");
//       print(jwtToken);

//       _box.put("User_id",jh['data']['_id'] );
//         _box.put("User_email",username );
     
//        Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     // return MyBottomNavigationBar();
//                     return LoginForm();
//                   },
//                 ),
//               );
//     }
//    }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Column(
//         children: [
//           TextField(
//             controller: _text,
//             keyboardType: TextInputType.emailAddress,
//             textInputAction: TextInputAction.next,
//             cursorColor: kPrimaryColor,
//             // onpr: (email) {},
//             decoration: InputDecoration(
//               hintText: "Your Name",
//               prefixIcon: Padding(
//                 padding: const EdgeInsets.all(defaultPadding),
//                 child: Icon(Icons.account_box_sharp),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: TextField(
//               controller: _textControllerForPhoneNumber,
//               textInputAction: TextInputAction.done,
//               obscureText: false,
//               cursorColor: kPrimaryColor,
//               decoration: InputDecoration(
//                 hintText: "Your Phone Number",
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//           ),
//             Padding(
//             padding: const EdgeInsets.symmetric(vertical: 3),
//             child: TextField(
//               controller: _textControllerForEmail,
//               textInputAction: TextInputAction.done,
//               obscureText: false,
//               cursorColor: kPrimaryColor,
//               decoration: InputDecoration(
//                 hintText: "Your Email",
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//           ),
//             Padding(
//             padding: const EdgeInsets.symmetric(vertical: 3),
//             child: TextField(
//               controller: _textControllerForPassword,
//               textInputAction: TextInputAction.done,
//               obscureText: true,
//               cursorColor: kPrimaryColor,
//               decoration: InputDecoration(
//                 hintText: "Your password",
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(defaultPadding),
//                   child: Icon(Icons.lock),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: defaultPadding / 2),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text("Sign Up".toUpperCase()),
//           ),
//           const SizedBox(height: defaultPadding),
//           AlreadyHaveAnAccountCheck(
//             login: false,
//             press: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return LoginScreen();
//                   },
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }