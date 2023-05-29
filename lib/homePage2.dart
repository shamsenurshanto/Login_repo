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
import 'package:my_app/PendingForm.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/newDash.dart';
import 'package:my_app/testUserdetails.dart';
import 'package:my_app/userDetailsTesting.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';


import 'PendingListBottom.dart';
import 'Team_new.dart';
import 'models/team.dart';
import 'newTbb.dart';

class homepage2 extends StatefulWidget {
  const homepage2({super.key});

  @override
  State<homepage2> createState() => _homepage2State();
}

class _homepage2State extends State<homepage2> {
  @override

  ///function for bangla
  List<Team> teams = [];
  List<String> pictureofUsers = []; 
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
            'personalrec.onrender.com', 'api/transaction/usersalltransactions')
            ,
        headers: {'Cookie': 'jwt_token=$tokenString2'});
    var jsonData = jsonDecode(response.body);
    print(response.body);
    // print(jsonData['data']);
  var i=0;
    for (var eachTeam in jsonData['data']) {
      // pictureofUsers.add(eachTeam[]);
    print(eachTeam['receiver']['receiverId']['userPic']);
    pictureofUsers.add(eachTeam['sender']['senderId']['userPic'].toString());
      // if(_idLoggedIn==eachTeam['sender']['senderId'].toString())
      //  {
      //   pictureofUsers.add(eachTeam['receiver']['receiverId']['userPic'].toString());
      //     print(eachTeam['receiver']['receiverId']['userPic'].toString());
      //  }
      //  else if(_idLoggedIn==eachTeam['receiver']['receiverId'].toString())
      //  {
      //      pictureofUsers.add(eachTeam['sender']['senderId']['userPic'].toString());
      //      print(eachTeam['sender']['senderId']['userPic'].toString());
      //  }
      //  print("------------ added number "+i.toString());
      //  print(pictureofUsers[i]);
      //  i++;
       
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
              Receiver_status: eachTeam['receiverStatus'],
              //  img_link: eachTeam['userPic']
               );
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
              Receiver_status: eachTeam['receiverStatus'],
              // img_link: eachTeam['userPic']
          );
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
              Receiver_status: eachTeam['receiverStatus'],
              //  img_link: eachTeam['userPic']
               );
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
              Receiver_status: eachTeam['receiverStatus'],
              //  img_link: eachTeam['userPic']
               );
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
        backgroundColor: Colors.white10,
        body: SafeArea(
            child: SingleChildScrollView(
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
                                offset: Offset(8,
                                    8), // Specifies the position of the shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color.fromARGB(248, 9, 9, 9),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.wallet,
                                              color: Colors.white,
                                              size: 22,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      "Total wallet balance",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 200,
                                        child: Row(
                                          children: [
                                           Container(
                                            color: Colors.white,
                                            child:  Icon(
                                              Icons.keyboard_double_arrow_up_sharp,color: Colors.green,
                                              size: 26,
                                            ),
                                           ),
                                            Text(
                                          "\$7809.54",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Center(
                                          child: Container(
                                              width: 80,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.elliptical(10, 10)),
                                                color: Colors.green,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "+ \$3.566",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 0/2,
              ),

              Container(
                width: 350,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  color: Colors.white,
                ),
                child:
                    //center icon button
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Card(
                          elevation: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Column(
                                  //  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: 43,
                                        height: 43,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(40, 83, 107, 229),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.home_outlined,
                                              //#E9ECFA
                                              color: Color.fromARGB(
                                                  215, 94, 131, 233),
                                              size: 30,
                                            ),
                                          ],
                                        )),
                                    //text
                                    Text(
                                      "Home",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
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
                                        color: Color.fromARGB(45, 166, 63, 197),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                         GestureDetector(
                                          onTap: (){
                                            print("hello");
                        //                      Navigator.pushReplacement(
                        // context,
                        // MaterialPageRoute(
                        //   builder: (context) {
                        //     // return MyBottomNavigationBar();
                        //     return dash_newMyBottomNavigationBar_new();
                        //   },
                        // ),
                      
                        //                  );

                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyListView_()));
                                          },
                                          child:  Icon(
                                            Icons.dashboard,
                                            //#E9ECFA
                                            color: Color.fromARGB(
                                                255, 166, 63, 197),
                                            size: 22,
                                          ),
                                         )
                                        ],
                                      )),
                                  //text
                                  Text(
                                    "Dashboard",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  )
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
                                        color: Color.fromARGB(45, 18, 175, 183),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                        GestureDetector(
                                          onTap: (){
                                            print("hello");
                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return dash4();

                                                          // return userDetails(teams[index].mainMail);
                                                        },
                                                      ),
                                                    );
                                          },
                                          child: 
                                            Icon(
                                            Icons.pending_actions_outlined,
                                            //#E9ECFA
                                            color: Color.fromARGB(
                                                255, 17, 200, 216),
                                            size: 22,
                                          ),
                                        )
                                        ],
                                      )),
                                  //text
                                  Text(
                                    "Pending",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  )
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
                                        color: Color.fromARGB(45, 22, 196, 100),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.credit_card_outlined,
                                            //#E9ECFA
                                            color: Color.fromARGB(
                                                205, 22, 196, 164),
                                            size: 27,
                                          ),
                                        ],
                                      )),
                                  //text
                                  Text(
                                    "Credit",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  )
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
                                          color:
                                              Color.fromARGB(24, 50, 221, 237)
                                          //rgb(249, 245, 246) rgb(242, 190, 209) rgb(210, 233, 233)

                                          ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.approval_outlined,
                                            //#E9ECFA
                                            color: Color.fromARGB(
                                                255, 60, 219, 139),
                                            size: 22,
                                          ),
                                        ],
                                      )),
                                  //text
                                  Text(
                                    "Approval",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w900),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        )),
              ),

              SizedBox(
                height: 70,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 35,
                                offset: Offset(10,
                                    18), // Specifies the position of the shadow
                              ),
                            ],
                  color: Colors.white,
                ),

                
                width: 392,
                height: 420,
                child: Column(
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
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  print("done");
                                  print(teams.length);

                                  return Scaffold(
                                    body: Column(
                                      children: [
                                        //transaction type
                                        Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                    child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20, 20, 0, 10),
                                                  child: Text(
                                                    "TRANSACTIONS",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                            itemBuilder: (BuildContext context,
                                                int index) {
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
                                                          return UserDetails(
                                                              teams[index]);

                                                          // return userDetails(teams[index].mainMail);
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: Card(
                                                      elevation: 10.0,
                                                      color: Colors.grey[100],
                                                      margin:
                                                          EdgeInsets.all(10),
                                                      child: SizedBox(
                                                          height:
                                                              height_safearea *
                                                                  0.108,
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(10 /
                                                                            2),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30.0),
                                                                  child: 
                                                                  // pictureofUsers[index]?
                                                                  // Image
                                                                  //     .network(
                                                                  //       "https://personalrecordback-production.up.railway.app/amendmentDoc/"+pictureofUsers[0],
                                                                  //   width: 30,
                                                                  //   height:
                                                                  //       60 / 2,
                                                                  //   fit: BoxFit
                                                                  //       .cover,
                                                                  // ):
                                                                  Image
                                                                      .network(
                                                                         "https://personalrecordback-production.up.railway.app/amendmentDoc/"+pictureofUsers[index],
                                                                    width: 30,
                                                                    height:
                                                                        60 / 2,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )

                                                                ),
                                                              ),
                                                              teams[index].type ==
                                                                      "Loan Given"
                                                                  ?

                                                                  //up arrow

                                                                  Icon(
                                                                      Icons
                                                                          .arrow_upward_outlined,
                                                                      color: Colors
                                                                          .deepPurple,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .arrow_downward_outlined,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                              teams[index].Transaction_status ==
                                                                      "PENDING"
                                                                  ? Icon(
                                                                      Icons
                                                                          .hourglass_bottom_outlined,
                                                                      color: Colors
                                                                          .grey,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .done,
                                                                      color: Colors
                                                                          .green,
                                                                    ),
                                                              SizedBox(
                                                                width: 250 / 2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: Text(
                                                                  "\$ " +
                                                                      teams[index]
                                                                          .amount
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                              )
                                                            ],
                                                          ))),
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
                                              width:
                                                  width_safearea * 0.076530612,
                                              height: height_safearea * 0.04,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )));
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
