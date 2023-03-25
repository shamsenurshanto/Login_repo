
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/splashScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
   postDate() async {
    var response = await http.post(Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login"),
    body: {
      "userEmailPhone":username.toString(),
      "userPass":"12345678",

    });
    print(response.body);
    var gh = response.body;
    print(jsonDecode(gh)["success"]);
    username = _textController.text;
    print(username.toString());
    if(jsonDecode(gh)["success"])
    {
      print("hoise");
    
    }
   }


  final _textController = TextEditingController();
  String username = "G";
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
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

           MaterialButton(onPressed: postDate,
               
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
