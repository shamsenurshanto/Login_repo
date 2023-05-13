import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:my_app/models/team.dart';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/newDash.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import 'Team_new.dart';
import 'models/team.dart';

class userdetails_new_with_sidebar extends StatefulWidget {
  const userdetails_new_with_sidebar({super.key});

  @override
  _userdetails_new_with_sidebarState createState() =>
      _userdetails_new_with_sidebarState();
}

class _userdetails_new_with_sidebarState
    extends State<userdetails_new_with_sidebar> {
  var height_safearea;
  var width_safearea;

  @override
  Widget build(BuildContext context) {
    String valAmount = "";
    var loanStaus = "";
    var amoutUser = 0;
    var loanTopay = 0;
    List<Team> teams2 = [];
    height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    width_safearea = MediaQuery.of(context).size.width;

    //// function starts

    int trackerLoancount = 0;
    void apicall(int x, int length) {
      // print("apiii");
      if (trackerLoancount < length)
        setState(() {
          loanTopay += x;

          trackerLoancount++;
        });
    }

    Future getTeams() async {
      //print("get teaaaaaaaaaaaaaaaaaaaaaaaaamsssss");

      var box = await Hive.openBox("mybox");
      final _box2 = Hive.box("mybox");
      var _idLoggedIn = _box2.get("User_id"); //my user id
      var email = _box2.get("User_email");

      //hive initialization and get data

      //print("apii te +++++++++++++++++++++++");
      var gh = _box2.get("tokens");

      //print(gh.runtimeType);

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
          // //print();
          tokenString2 += String.fromCharCode(rune);
        }
      }

      //ab33@gmail.com

      //print("token api ---------- ::::::::::::::::::::");
      final _box = Hive.box("mybox");
      _box.put("toki", tokenString2);

//print(tokenString2);
      //print(tokenString2.runtimeType);

      var response = await http.get(
          Uri.https('personalrec.onrender.com', 'api/user/loansummary'),
          headers: {'Cookie': 'jwt_token=$tokenString2'});
      var jsonData = jsonDecode(response.body);
      print("response body ---------- ::::::::::::::::::::");
      print(response.body);

      print(jsonData['data'][0]['total_sent']);
      teams2.clear();
      for (var eachTeam in jsonData['data']) {
        // loooooppppo lol
        // //print(eachTeam['sender']['senderId']);
        String mainMail2 = "";
        String mainName = "";
        print("------------ edhaaaaaa");
        print(jsonData['data'].length);

        print(eachTeam['total_received']);

        //  //print(eachTeam['type']['en_typeName']);
        final team;

        team = Team(
            amount: (eachTeam['total_sent'] - eachTeam['total_received']).abs(),
            name: eachTeam['userName'].toString(),
            id: "",
            sender_email: "",
            receiver_email: "",
            type: "Loan Taken",
            mainMail: "eachTeam['sender']['senderId']['_id'].toString()",
            Transaction_status: "eachTeam['transactionStatus']",
            Transaction_id: " eachTeam['_id'].toString()",
            Sender_status: "eachTeam['senderStatus']",
            Receiver_status: "eachTeam['receiverStatus']");
        print("this is for id");
        print(team.id);
        apicall((eachTeam['total_received'] - eachTeam['total_sent']).abs(),
            jsonData['data'].length);

        teams2.add(team);
      }
      //print("---------------------------------------");
      //print(teams.length);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              //color's container
              Container(
                width: 500,
                height: 410,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 202, 212, 253),
                      Color.fromARGB(255, 248, 243, 253),
                      Color.fromARGB(255, 202, 212, 253),
                      Color.fromARGB(255, 248, 243, 253)
                    ], //#D3DCFE  #ECEEFE
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(43),
                    bottomRight: Radius.circular(43),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Gradient Container',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              //money container
              Positioned(
                  top: height_safearea / 7,
                  right: width_safearea / 18,
                  left: 21 / width_safearea * width_safearea,
                  child: Column(
                    children: [
                      Container(
                        /// change it here for responsiveness
                        width: 450 / width_safearea * width_safearea,
                        height: 300 / height_safearea * height_safearea,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 202, 212, 253),
                              Color.fromARGB(255, 248, 243, 253),
                              Color.fromARGB(255, 202, 212, 253),
                              Color.fromARGB(255, 248, 243, 253)
                            ], //#D3DCFE  #ECEEFE
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          // shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height_safearea / 8,
                              ),
                              Text("Total Debt",
                                  style: GoogleFonts.mina(
                                      color: Color.fromARGB(255, 33, 25, 77),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                              Text("\$13300",
                                  style: GoogleFonts.mina(
                                      color: Color.fromARGB(255, 33, 25, 77),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                    width: 90.0,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 203, 202,
                                            253), // Change the background color
                                        onPrimary: Colors
                                            .white, // Change the text color
                                      ),
                                      onPressed: () {},
                                      child: Text('Dredit'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    /// change it here for responsiveness
                                    height: 50.0,
                                    width: 90.0,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color.fromARGB(255, 203, 202,
                                            253), // Change the background color
                                        onPrimary: Colors
                                            .white, // Change the text color
                                      ),
                                      onPressed: () {},
                                      child: Text('Credit'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),

              //icon

              //here start

              Positioned(

                  /// change it here for responsiveness
                  top: 370,
                  right: 40,
                  left: 50,
                  child: Container(
                    /// change it here for responsiveness
                    width: 300,
                    //for the icons
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          /// change it here for responsiveness
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                // color: const Color.fromARGB(255, 116, 68, 199),
                                color: Color.fromARGB(140, 40, 40, 205),
                              ),
                              Text(
                                "Add",
                                style: TextStyle(
                                    color: Color.fromARGB(140, 40, 40, 205),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                        Container(
                          /// change it here for responsiveness
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.send,
                                // color: const Color.fromARGB(255, 116, 68, 199),
                                color: Color.fromARGB(140, 40, 40, 205),
                              ),
                              Text(
                                "Send",
                                style: TextStyle(
                                    color: Color.fromARGB(140, 40, 40, 205),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                        Container(
                          /// change it here for responsiveness
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 17,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.wallet,
                                // color: const Color.fromARGB(255, 116, 68, 199),
                                color: Color.fromARGB(140, 40, 40, 205),
                              ),
                              Text(
                                "Wallet",
                                style: TextStyle(
                                    color: Color.fromARGB(140, 40, 40, 205),
                                    fontWeight: FontWeight.w800),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              //here end
              Positioned(
                  top: 50 / height_safearea * height_safearea,
                  right: 20 / width_safearea * width_safearea,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      image: DecorationImage(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.cover),
                      color: Color.fromARGB(255, 202, 212, 253),
                    ),
                    width: 40.0,
                    height: 40.0,
                  )),
            ],
          ),
          //here are the lists 
          
        ],
      ),
    );
  }
}
