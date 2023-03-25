import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:my_app/dashBoard.dart';
import 'package:my_app/splashScreen.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';



   postDate(context) async {
    var response = await http.post(Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login"),
    body: {
      "userEmailPhone":username.toString(),
      "userPass":"12345678",

    });
   
      

           var url = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions");
String token = getToken();
final responsew = await http.get(url, headers: {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer $token',
});
print('Token : ${token}');
print(responsew);
   



    print(response.body);
    var gh = response.body;
    print(jsonDecode(gh)["success"]);
    username = _textController.text;
    print(username.toString());
    if(jsonDecode(gh)["success"])
    {
      print("hoise");
     
       Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return dashBoard();
                  },
                ),
              );
    }
   }


  final _textController = TextEditingController();
  String username = "G";
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

           Text(username),




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