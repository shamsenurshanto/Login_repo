import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/dashBoard.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/splashScreen.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'Tokener.dart';

// Create a global variable to hold the cookie value
String? jwtToken;


class MyCookieClass {
  static String? jwtToken;
}
  
   postDate(context) async {
  
    // var response = await http.post(Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login"),
    // body: {
      // "userEmailPhone":username.toString(),
    //   "userPass":"12345678",

    // });
   
        String  username = "g";
          username = _textController.text;
           var url = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login");
//  final responsew = await http.get(Uri.parse('http://your-nodejs-server.com/get-jwt-token'));

   // Make a request to the Node.js server to get a JWT token
   if(username==null)
   {
       username = "ab03@gmail.com";
   }
   
  final response = await http.post(
    Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login"),
    body: {
      'userEmailPhone': username, 
      'userPass': '12345678'
      
      },
  );

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



  // Save the JWT token as a global variable
  MyCookieClass.jwtToken = cookie;

 
   



  
    var gh = response.body;
    print("hoise *****************************************");
    print(response.body);
    // print("token from main login " + jwtToken);
  
    // print(username.toString());
    if(jsonDecode(gh)["success"])
    {
      print("hoise");
      print(jwtToken);
     
       Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return dash2();
                    // return userDetails("email");
                  },
                ),
              );
    }
   }


  final _textController = TextEditingController();

class mainLogin extends StatelessWidget {
  const mainLogin({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     backgroundColor: Colors.white,
     body: SafeArea(child:
        Center(
          child: Column(
      children: [
            
      const SizedBox(
        height: 90,
      ),
        //logo
        Icon(Icons.lock,
        size : 100,
        color: Colors.cyan.shade300,
        ),
         const SizedBox(
              height: 30,
             
            
            ),

           const SizedBox(
              height: 60,
              child: Center(
                child: Text(
                "Welcome Back You have been missed",
                style: 
                TextStyle(
                  color: Colors.cyan,
                  fontWeight:FontWeight.bold,
                  fontSize: 15,
                ),
              )
            ,
            
              )
            
            ),
            const SizedBox(
              height: 30,
             
            
            ),
     

       Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
           child:  TextField(
            controller: _textController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  )
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(
                    color: Colors.blueGrey.shade50,
                  ),

                ),
                fillColor: Colors.white,
                filled:  true,
                hintText: "Enter Your UserName",
                labelText: "User Name",
                  labelStyle: TextStyle(
                    color: Colors.cyan,fontSize:17
                  )
              ),

              

            ),
           ),

             const SizedBox(
              height: 30,          
            
            ),

              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
           child:  TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white
                  )
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide:  BorderSide(
                    color: Colors.blueGrey.shade50,
                  ),

                ),
                fillColor: Colors.white,
                filled:  true,
                hintText: "Enter Your Password",
                 labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.cyan,fontSize:17
                  ),
                
              ),

              

            ),
           ),

           MaterialButton(
            
           onPressed:
             ()=> postDate(context),
           
               
               color: Colors.black,
                height: 30,
                minWidth: 50,
               child: const Text("Submit",style: TextStyle(color: Colors.white),),
               
           ),

          //  Text(username),




        //welcome to the screen

        //username textfield


        

        //forgot password

        //sign in button
      ],
     ),
        )
     
     
     )

    );
  }
}