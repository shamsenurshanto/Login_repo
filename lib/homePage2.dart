import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/UserDetails.dart';
import 'package:my_app/newDash.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import 'Team_new.dart';
import 'models/team.dart';
class homepage2 extends StatefulWidget {
  const homepage2({super.key});

  @override
  State<homepage2> createState() => _homepage2State();
}

class _homepage2State extends State<homepage2> {
  @override
  ///function for bangla
   List<Team> teams = [];
  var amountOfUser;
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
  Future getTeams() async {
    teams.clear();
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var _idLoggedIn = _box2.get("User_id"); //my user id
    var email = _box2.get("User_email");

    //hive initialization and get data

    print("apii te +++++++++++++++++++++++");
    var gh = _box2.get("tokens");

    print(gh.runtimeType);

    String token = "";

    String cookie = gh;

    String str = gh, ghh, tokenString2 = "";
    // tokenString2 = cookie;
    int flag = 0;

    //making the jwt_token
    for (int rune in str.runes) {
      if (String.fromCharCode(rune) == '=') {
        flag = 1;
        continue;
      } else if (String.fromCharCode(rune) == ';') {
        tokenString2 += String.fromCharCode(rune);
        break;
      }

      if (flag > 0) {
        // print();
        tokenString2 += String.fromCharCode(rune);
      }
    }

    //ab33@gmail.com

    print("token api ---------- ::::::::::::::::::::");
    final _box = Hive.box("mybox");
    _box.put("toki", tokenString2);

    print(tokenString2);
    print(tokenString2.runtimeType);

    var response = await http.get(
        Uri.https(
            'personalrec.onrender.com', 'api/transaction/usersalltransactions'),
        headers: {'Cookie': 'jwt_token=$tokenString2'});
    var jsonData = jsonDecode(response.body);
    print(response.body);
    // print(jsonData['data']);

    for (var eachTeam in jsonData['data']) {
      // print(eachTeam['sender']['senderId']);
      String mainMail2 = "";
      String mainName = "";
      print(eachTeam['type']['en_typeName']);
      final team;
      print(
          "___________________________________________________--------------");
      if (eachTeam['type']['en_typeName'] == "LoanTaken") {
        //  mainMail2 = eachTeam['sender']['senderId']['_id'];
        //     mainName = eachTeam['sender']['senderId']['userName'];

        //here it is gone for change    TO SEE EACH OTHER
        var _idgh = _box2.get("User_id"); //my user id
        var email = _box2.get("User_email");
        if (_idgh == eachTeam['sender']['senderId']['_id'].toString()) {
          print("ole");
          print(_idgh);
          print(email);

          team = Team(
              id: eachTeam['sender']['senderId']['_id'].toString(),
              sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
              receiver_email:
                  eachTeam['receiver']['receiverEmailPhone'].toString(),
              type: "Loan Given",
              amount: eachTeam['amount'],
              mainMail: eachTeam['receiver']['receiverId']['_id'].toString(),
              name: eachTeam['receiver']['receiverId']['userName'].toString(),
              Transaction_status: eachTeam['transactionStatus'],
              Transaction_id: eachTeam['_id'].toString(),
              Sender_status: eachTeam['senderStatus'],
              Receiver_status: eachTeam['receiverStatus']);
        } else {
          print("lole");
          print(_idgh);
          print(email);

          team = Team(
              id: eachTeam['sender']['senderId']['_id'].toString(),
              sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
              receiver_email:
                  eachTeam['receiver']['receiverEmailPhone'].toString(),
              type: "Loan Taken",
              amount: eachTeam['amount'],
              mainMail: eachTeam['sender']['senderId']['_id'].toString(),
              name: eachTeam['sender']['senderId']['userName'].toString(),
              Transaction_status: eachTeam['transactionStatus'],
              Transaction_id: eachTeam['_id'].toString(),
              Sender_status: eachTeam['senderStatus'],
              Receiver_status: eachTeam['receiverStatus']);
        }

        print(mainName);
      } else if (eachTeam['type']['en_typeName'] == "LoanGiven") {
        //  mainMail2 = eachTeam['sender']['senderId']['_id'];
        //     mainName = eachTeam['sender']['senderId']['userName'];

        //here it is gone for change    TO SEE EACH OTHER
        var _idgh = _box2.get("User_id"); //my user id
        var email = _box2.get("User_email");
        if (_idgh == eachTeam['sender']['senderId']['_id'].toString()) {
          print("ole");
          print(_idgh);
          print(email);

          team = Team(
              id: eachTeam['sender']['senderId']['_id'].toString(),
              sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
              receiver_email:
                  eachTeam['receiver']['receiverEmailPhone'].toString(),
              type: "Loan Given",
              amount: eachTeam['amount'],
              mainMail: eachTeam['receiver']['receiverId']['_id'].toString(),
              name: eachTeam['receiver']['receiverId']['userName'].toString(),
              Transaction_status: eachTeam['transactionStatus'].toString(),
              Transaction_id: eachTeam['_id'].toString(),
              Sender_status: eachTeam['senderStatus'],
              Receiver_status: eachTeam['receiverStatus']);
        } else {
          print("lole");
          print(_idgh);
          print(email);

          team = Team(
              id: eachTeam['sender']['senderId']['_id'].toString(),
              sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
              receiver_email:
                  eachTeam['receiver']['receiverEmailPhone'].toString(),
              type: "Loan Taken",
              amount: eachTeam['amount'],
              mainMail: eachTeam['sender']['senderId']['_id'].toString(),
              name: eachTeam['sender']['senderId']['userName'].toString(),
              Transaction_status: eachTeam['transactionStatus'],
              Transaction_id: eachTeam['_id'].toString(),
              Sender_status: eachTeam['senderStatus'],
              Receiver_status: eachTeam['receiverStatus']);
        }
      } else {
        team = "";
      }

      // print(mainName);
      if (eachTeam['_id'] != null &&
          eachTeam['sender']['senderId'] != null &&
          eachTeam['receiver']['receiverId'] != null &&
          eachTeam['type'] != null &&
          eachTeam['amount'] != null &&
          mainMail2 != null) {
        print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        print(mainName);

        teams.add(team);

        print(teams[teams.length - 1].name);
      }
    }
    print("---------------------------------------");
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;
    int _counter = 0;

    void _incrementCounter(int amount) {
      var box = Hive.openBox("mybox");
      final _box2 = Hive.box("mybox");
      _counter += amount;
      // _idLoggedIn= _box2.get("User_id");//my user id
      //        email= _box2.get("User_email");
      //        name= _box2.get("User_name");
      _box2.put("valu_sum", _counter.toString());
    }



  
    
    return Scaffold(
      backgroundColor: Colors.white70,
         body:
         
          SafeArea(
            child: 
            SingleChildScrollView(
              child: 
              //all card
              Column(
            children: [
              SizedBox(
                height: 1,
              ),

              //icon and text(total ) upper 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        
            Container(
  width: 392.2,
  height: 300,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
    color: Colors.white,
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

     Container(
  width: 340,
  height: 180,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 35,
        offset: Offset(8, 8), // Specifies the position of the shadow
      ),
    ],
  ),
  child: Column(
    children: [
       Padding(padding: EdgeInsets.all(20),
       
       child: Row(
        children: [

                      Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
            FontAwesomeIcons.wallet,
            color: Colors.white,
            size: 22,
          ),
         
      
          
              ],
            )
          ),
          SizedBox(
            width: 50,
          ),

              Text(
            "Total wallet balance",style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
            
          )


   

        ],
      ),

      
      
      ),
        Padding(padding: EdgeInsets.all(10),
        
        child: Center(
        child: 
        Row(
        children: [
          SizedBox(
            width: 4,
          ),
         Container(
          width: 200,
          child:  Text(
            "\$7809.54",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,color: Colors.black87,
            ),
          ),
         ),
          SizedBox(
            width: 20,
          )
          ,
          Padding(padding: 
          EdgeInsets.all(8),
          child:  Center(
            child: 
            Container(
            width: 80,
            height: 30
            ,
              decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.elliptical(10, 10)
    ),
   color: Colors.green,
  ),
            
            child: Center(
              child: Text(
              "+ \$3.566",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16
              ),
            ),
            )
          ),
          )
          ,
          )
        ],
      ),
       ),)
    ],
  ),
)


    ],
  ),
),
     


        ],
      ),
      
      SizedBox(
        height: 35,
      ),

      Container(
        width: 350,
        height: 90,
                decoration: BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.elliptical(10, 10)
    ),
 color: Colors.white,
  ),
  child: 
  //center icon button 
  Padding(
    
    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
  
  child:Card(
    elevation: 14,
    child:  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
           
           Padding(padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
             child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
              Container(
            width: 43,
            height: 43,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(40, 83, 107, 229)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Icon(
          Icons.home_outlined,
            //#E9ECFA
           color: Color.fromARGB(215, 94, 131, 233),
            size: 30,
          ),

              ],
            )
          ),
           //text
          Text("Home",style: TextStyle(
           
            fontWeight: FontWeight.w900,
            
          ),)
          ],
        ),
           ),
          SizedBox(
            width: 10,
          ),

          //2 no icon 
        Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
              Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(70, 136, 54, 217)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                FaIcon(
            FontAwesomeIcons.paperPlane,
            //#E9ECFA
           color: Colors.deepPurple,
            size: 22,
          ),

              ],
            )
          ),
           //text
          Text("Send",style: TextStyle(
           
            fontWeight: FontWeight.w900
          ),)
          ],
        ),
          SizedBox(
            width: 10,
          ),

             Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
              Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(70, 136, 54, 217)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                FaIcon(
            FontAwesomeIcons.paperPlane,
            //#E9ECFA
           color: Colors.deepPurple,
            size: 22,
          ),

              ],
            )
          ),
           //text
          Text("Send",style: TextStyle(
           
            fontWeight: FontWeight.w900
          ),)
          ],
        ),
          SizedBox(
            width: 10,
          ),

        
        

           Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
              Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(74, 83, 107, 229)
              ,
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Icon(
          Icons.home_outlined,
            //#E9ECFA
           color: Color.fromARGB(205, 94, 131, 233),
            size: 27,
          ),

              ],
            )
          ),
           //text
          Text("Send",style: TextStyle(
           
            fontWeight: FontWeight.w900
          ),)
          ],
        ),
          SizedBox(
            width: 10,
          ),
             Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
              Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
             color: Color.fromARGB(24, 50, 221, 237)
             //rgb(249, 245, 246) rgb(242, 190, 209) rgb(210, 233, 233)
              
            ),
            child:        Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Icon(
           Icons.approval_outlined,
            //#E9ECFA
           color: Color.fromARGB(255, 60, 219, 139),
            size: 22,
          ),

              ],
            )
          ),
           //text
          Text("Send",style: TextStyle(
           
            fontWeight: FontWeight.w900
          ),)
          ],
        ),
          SizedBox(
            width: 10,
          ),

          

          
          
          
          
    ],
  ),
  )
  )
  ,
       
      ),

      SizedBox(
        height: 30,
      ),
      Container(
        decoration: BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(22),
      topRight: Radius.circular(22),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0),
      
    ),
     color: Colors.white,
        ),
       
        width: 392,
        height: 420,
        child: 
        Column(
          children: [
            Column(
              
              children: [
            
            // main scrollable sizebar 
               SizedBox(
                width: 360,
                height: 400,
                 child: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                print("done");
                print(teams.length);

                return Scaffold(
                  body: Column(
                    children: [
                      //transaction type
                                           Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                                child: Text(
                                  "TRANSACTIONS",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey),
                                ),
                              ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(1),
                          )
                        ],
                      ),

                      ///transaction starts
                      ///
                      ///
                      ///
                      ///,conta
                      SizedBox(
                        width: 390,
                        height: 300,
                        child: ListView.builder(
                          itemCount: teams.length,
                          itemBuilder: (BuildContext context, int index) {
                            //  _incrementCounter(teams2[index].amount);

                            return Container(
                              width: 390,
                              height: 60,
                              child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UserDetails(teams[index]);

                                  // return userDetails(teams[index].mainMail);
                                },
                              ),
                            );
                          },
                          child: Card(
                              elevation: 14.0,
                              color: Colors.grey[100],
                              margin: EdgeInsets.all(10),
                              child: SizedBox(
                                height: height_safearea * 0.108,
                                child: Row(
                                  
                                  
                                  children: [

                                 Padding(
                                  padding: EdgeInsets.all(10/2),
                                 child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Image.network(
                                                'https://t3.ftcdn.net/jpg/03/05/77/64/360_F_305776453_t7SUl48g63zLsyODxd60aj6EcWR9avVK.jpg',
                                                width: 30,
                                                height: 60/2,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                 ),
                                 teams[index].type=="Loan Given"?

                                 //up arrow 
                                     
                                    Icon(
                                      Icons.arrow_upward_outlined
                                      ,
                                      color: Colors.deepPurple,
                                    )

                                    :

                                     Icon(
                                      Icons.arrow_downward_outlined
                                      ,
                                      color: Colors.green,
                                    ),


                                    teams[index].Transaction_status=="PENDING"?
                                     Icon(
                                      Icons.hourglass_bottom_outlined
                                      ,
                                      color: Colors.grey,
                                    )
                                    :

                                     Icon(
                                      Icons.done
                                      ,
                                      color: Colors.green,
                                    ),



                                   SizedBox(
                                    width: 250/2,
                                   ),
                                     Padding(padding: EdgeInsets.all(10),
                                     child:  Text(
                                      "\$ "+teams[index].amount.toString(),style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17
                                      ),
                                    ),)
                                   
                                 




                                ],)
                              )),
                        ),
                                
                  
                    
                    
                            
                            );
                          },
                        ),
                      )

                      // Text()
                    ],
                  ),
                );
              } else {
                return Center(
                    child: Container(
                        width: width_safearea,
                        height: height_safearea,
                        color: Colors.white,
                        child: Center(
                          child: Container(
                            width: width_safearea * 0.076530612,
                            height: height_safearea * 0.04,
                            child: CircularProgressIndicator(),
                          ),
                        )));
              }
            }
            
            ),
                ),

              ],
            ),
            
          ],
        )
        ,
      )

            ],
            
          ),
          
            )


         
         )  
    );
  }
}