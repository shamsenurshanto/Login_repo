import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Login.dart';
import 'package:my_app/MainLogin.dart';
import 'package:my_app/api_services.dart';
import 'package:my_app/splashScreen.dart';
class dashBoard extends StatelessWidget {
  const dashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text("Dashboard"),),
      body: FutureBuilder(future: getPost(),
       builder: (context, snapshot) {
          if(!snapshot.hasData)
          {
                return const Center(
                  child: 
                  CircularProgressIndicator(

                  ),
                );
          }
          else
          {

            

         return Container(

        
          child: 
          Center(
                      child: Text(
            'Hello Flutter',
            style: TextStyle(
                fontSize: 50, color: Colors.deepPurpleAccent),
          ),
                      
            
            
            )
            
            ,
            color: Colors.white,
         );
       }
          }
       
      ),
    );
  }
}