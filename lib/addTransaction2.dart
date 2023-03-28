import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class addTrans extends StatefulWidget {
  const addTrans({super.key});

  @override
  State<addTrans> createState() => _addTransState();
}

class _addTransState extends State<addTrans> {

    bool _isLoading=false;
  getUser() async {
     final response = await http.post(
    Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/auth/login"),
    body: {
      'userEmailPhone': "ab33@gmail.com", 
      'userPass': '12345678'
      
      },
  );
    var resp = json.decode(response.body);
    if (response.statusCode != 200) {
      // data = "Oye !! Thare pass Internet naahi hn !!";
    }
    print(resp);
    setState(() {
      // data = resp['slip']['advice'];
      _isLoading = false;
    });
  }
  @override
  void initState() {
    _isLoading = true;
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
       
       appBar: AppBar(title: Text("Add a Transaction"),centerTitle: true,),
       body: Container(

         padding: EdgeInsets.all(30.0),
         child: ListView(

             children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Find The Valid User ",
                  prefixIcon: Icon(Icons.verified_user_outlined),
                  border: OutlineInputBorder(

                  )
                ),
              ),
              Container(

                 margin: const EdgeInsets.only(top: 10.0),
                child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size.fromHeight(55),
                  
                  
                ),
           
            child:  _isLoading
                              ? const CircularProgressIndicator(color: Colors.white,)
                             
                              : Text(
                                 "Search User",
                                  textAlign: TextAlign.center,
                                ),



              onPressed: () {
                          setState(() {
                            _isLoading = true;
                          
                          });
                          getUser();
                        },
                   
          ),
              )
             ,
             ],
         ),
       ),




    );
  }
  }
