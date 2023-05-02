import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/team.dart';

class UserDetails extends StatefulWidget {
   Team teams;
   String namee="";
  

  UserDetails(this.teams);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  var jsonData;
  String id = "";
  String id1 = "";
  String id2 = "";
  String tokenString2 = "";

  Future<void> getTeams2() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    print("Useeeeeeeeeeeeeeer detaaaaails --------------------------------------");
    print(id);
    print(widget.teams.name);
    print(widget.teams.id);
    print(widget.teams.amount);
    print(widget.teams.Transaction_status);
    String Bname = "";
    String Bmail = "";
    String Bamount = "";

    id = widget.teams.id;
    var response = await http.get(
      Uri.https('personalrec.onrender.com', 'api/transaction/getsumofusers/$id'),
      headers: {'Cookie': 'jwt_token=$gh'},
    );
    print(response.body);
    jsonData = jsonDecode(response.body);
    print(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    var height_safearea = MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top;
              var width_safearea = MediaQuery.of(context).size.
              width ;
       alertFunction (){
        print("alert");
        showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Change Status'),
          content: Text('If You Acknowledge or Denied User will get a short notification'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: Text('ACKNOWLEDGED'),
            ),
             TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
              },
              child: Text('DENIED'),
            ),
           
          ],
        );
      },
    );
       }

    return Scaffold(
      
      appBar: AppBar(
        
        
        title: Text("Transaction Details",style: TextStyle(color: Colors.black),
        
        ),
      elevation: 4,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
    color: Colors.black,
      ),
      ),
      // backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: FutureBuilder(
          future: getTeams2(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("done");
              return Scaffold(
                body: Container(
                  margin: EdgeInsets.fromLTRB(2, 50, 2, 0),
                    child: Column(
                      children: [
                        //transaction type
                         Container(
                          margin: EdgeInsets.all(10),
                          child: Card(
                            elevation: 5,
                            
                            child:  Container(
                              
                              width: width_safearea * 0.918367347,
                              // height: 900,
                              child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                               Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Trasaction Type : "+ widget.teams.type.toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),


                             //sender/receiver name

                                                    Padding(
                              padding: EdgeInsets.all(8.0),
                           child:    widget.teams.type=="Loan Taken"?
                                                                Text(
                              "Sender Email : "+ widget.teams.sender_email.toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ):

                               Text(
                              "Receiver Email : "+ widget.teams.receiver_email.toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            ),
                                      


                        // Amount

                          Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Amount: "+ widget.teams.amount.toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),
                        // //
                          
                          //Transaction email

                                      Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Name: "+ widget.teams.name.toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),


                          //Transaction status
                           

                                Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Transaction Status: "+ widget.teams.Transaction_status.toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),
                          
                              Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "This User Total Sent : "+ jsonData['data']['userBSent'].toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ), 

                           //user B received 

                             Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "This User Total Received : "+ jsonData['data']['userBReceived'].toString(),style: TextStyle(fontSize: width_safearea * 0.045918367 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ), 
                                ],
                              ),
                            )
                          )
                         )
                            // Text()
                       


                      ],
                    ),
                ),
              );
              } else {
                return Center(
                   
                  child:Container(
                    width:  width_safearea,
                    height: height_safearea,
                  color: Colors.white,
                  child:  
                 Center(
                  child:  Container(
                    width: width_safearea * 0.076530612,
                    height: height_safearea * 0.04,
                    child: CircularProgressIndicator(),
                  ),
                 )
                ));
              }
            }
            
            
            ),
      ),
    );
  }
}