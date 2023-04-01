import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Login.dart';
import 'package:my_app/MainLogin.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/abc.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/dashBoard.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  


  @override
  Widget build(BuildContext context) {
      bool gh ;
      gh=true;
    if(gh){
 return MaterialApp(
    
     
    //  home:  Example(),
      // home:  userDetails("email"),
      //  home:  addTrans(),
      home:  mainLogin(),
      // home:  mainLogin(),
      
      
    );
    }
    else
    {
        return MaterialApp(
    
     
      home:  dash2(),
    );
    }
   
  }
}
