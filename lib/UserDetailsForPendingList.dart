import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/team.dart';

class UserDetails2 extends StatefulWidget {
   Team teams;
   String namee="";
  

  UserDetails2(this.teams);

  @override
  _UserDetails2State createState() => _UserDetails2State();
}

class _UserDetails2State extends State<UserDetails2> {
  var jsonData;
  String id = "";
  String id1 = "";
  String id2 = "";
  String tokenString2 = "";

  Future<void> getTeams2() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    int indexx=0;
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

    ReceiverAck() async {
   
     var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
     print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
 
    
 var response = await http.post(Uri.https('personalrec.onrender.com', 'api/transaction/changestatus'),
     
    headers: {
      
      //  'Content-Type': 'application/json; charset=UTF-8',
      
      'Cookie': 'jwt_token=$gh'
      },

 
  body: {
    "id":widget.teams.Transaction_id,
     "receiverStatus":"RECEIVED"
    
},
      
       );
       print(widget.teams.Transaction_id);
     jsonData = jsonDecode(response.body);
    print(jsonData);
    print("received");
 
  }



    SenderAck() async {
   
     var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
    
 
    
 var response = await http.post(Uri.https('personalrec.onrender.com', 'api/transaction/usersalltransactions'),
     
    headers: {
      
      //  'Content-Type': 'application/json; charset=UTF-8',
      
      'Cookie': 'jwt_token=$gh'
      },

 
  body: {
    "id":widget.teams.Transaction_id,
   "senderStatus":"SENT"
},
      
       );
       print(widget.teams.Transaction_id);
     jsonData = jsonDecode(response.body);
    print(jsonData);
     print("sent");
 
  }

       alertFunction (){
        print("alert");
        showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Change Status'),
          content: Text('If You Acknowledge or Denied User will get a short notification.Once You change status can not change it later'),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                // print()
                widget.teams.type=="Loan Taken"?
               ReceiverAck():SenderAck();
               Navigator.of(context).pop();

              },
              child: Text('ACKNOWLEDGED',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
            ),
             TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print("deni koresen");

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
        
        
        title: Text("Pending Details",style: TextStyle(color: Colors.black),
        
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
                            elevation: 10,
                            
                            child:  Container(
                              
                              width: 360,
                              // height: 900,
                              child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                               Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Trasaction Type : "+ widget.teams.type.toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),


                             //sender/receiver name

                                                    Padding(
                              padding: EdgeInsets.all(8.0),
                           child:    widget.teams.type=="Loan Taken"?
                                                                Text(
                              "Sender Email : "+ widget.teams.sender_email.toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ):

                               Text(
                              "Receiver Email : "+ widget.teams.receiver_email.toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            ),
                                      


                        // Amount

                          Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Amount: "+ widget.teams.amount.toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),
                        // //
                          
                          //Transaction email

                                      Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Name: "+ widget.teams.name.toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),


                          //Transaction status
                           

                                Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "Transaction Status: "+ widget.teams.Transaction_status.toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ),
                        //   button for changing status

                                   
                          //  user B Sent
                           
                           
                              Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "This User Total Sent : "+ jsonData['data']['userBSent'].toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ), 

                           //user B received 

                             Padding(padding: EdgeInsets.all(10),
                               
                                child:     Text(
                              "This User Total Received : "+ jsonData['data']['userBReceived'].toString(),style: TextStyle(fontSize: 18 ,fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                               ), 



                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                                                      ),
                                                                      
                                                        TextButton(
                                onPressed: () {
                                  // Do something when the button is pressed
                                  print("status");
                                alertFunction();
                                },
                                child:  Padding(padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                
                                child: Text(
                                  'Change Transaction Status',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                                ),
                              )



                   ],
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
                    width: 800,
                    height: 800,
                  color: Colors.white,
                  child:  
                 Center(
                  child:  Container(
                    width: 30,
                    height: 30,
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