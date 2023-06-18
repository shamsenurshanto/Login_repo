import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/newDash.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'models/team.dart';
class userdeatils_last extends StatefulWidget {
  // const userdeatils_last({super.key});
   late Team teams;
  String namee = "";

  userdeatils_last(this.teams);

  @override
  State<userdeatils_last> createState() => _userdeatils_lastState();
}

class _userdeatils_lastState extends State<userdeatils_last> {
  @override
  
  ///function for bangla
  String valAmount = "";
  var loanStaus = "";
  List<dynamic> items = [];

  var Lang_val = "English";
  var amountOfUser = "";

  var arr = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
  //kkk ollo
  printAndReturnString(String inputString) {
    for (var i = 0; i < inputString.length; i++) {
      setState(() {
        lan_status = "Bangla";
        //  //print("hhhhhhhhhhhhhhhhhhhhhhllllllllllllllllll");
        //  //print(inputString);
        valAmount += arr[int.parse(inputString[i])];
        widget.teams.type.toString() == "Loan Taken"
            ? loanStaus = "ধার নিয়েছি"
            : loanStaus = "ধার দিয়েছি";
      });
      print("vaaaaaaaaaaaaaalaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(valAmount);
    }
  }

  var jsonData;
  String id = "";
  String id1 = "";
  String id2 = "";
  String tokenString2 = "";
  var lan_status = "English";
  var loan_status = "";
  var arrayForLoanEng = [
    "Received",
    "Sent",
  ];
  var arrayForLoanBangla = [
    "ধার নিয়েছি",
    "ধার দিয়েছি",
  ];
  var selfEmail;

  void initState() {
  super.initState();
 
      print("helllllllllllllllllllllllllllllllllllllllllo");
           getTeams2();

     
    var box = Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");

    // _idLoggedIn= _box2.get("User_id");//my user id
    selfEmail = _box2.get("User_email");
    lan_status = _box2.get("Lang_val");

    //        Lang_val

   

    lan_status = _box2.get("Lang_val");
    if (lan_status == "Bangla") {
      //print(lan_status);
      printAndReturnString(widget.teams.amount.toString());
    } else {
      print(lan_status);
    }
  }
  void getGame()
  {
    print("heeellllollllllllllllllo");
        getTeams2();
  }
 

  List<Team> teams2 = [];
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams

  String getString(String number) {
    amountOfUser = "";
    for (var i = 0; i < number.length; i++) {
      //  //print("hhhhhhhhhhhhhhhhhhhhhhllllllllllllllllll");
      //  //print(inputString);
      amountOfUser += arr[int.parse(number[i])];

      print("vaaaaaaaaaaaaaalaaaaaaaaaaaaaaaaaaaaaaaaaa");
      // print(valAmount);
    }
    return amountOfUser;
  }

   getTeams2() async {
    print("get teaaaaaaaaaaaaaaaaaaaaaaaaamsssss");
        
    teams2.clear();
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
        Uri.https(
            'personalrec.onrender.com', 'api/transaction/usersalltransactions'),
        headers: {'Cookie': 'jwt_token=$tokenString2'});
    var jsonData = jsonDecode(response.body);
    //print(response.body);
    // //print(jsonData['data']);

    for (var eachTeam in jsonData['data']) {
      // print(eachTeam['sender']['senderId']);
      /// time 
        print(eachTeam['receiver']['receiverId']['userPic']);
         
        
    // pictureofUsers.add(eachTeam['sender']['senderId']['userPic'].toString());
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
             // loan given + mainmail 
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
              img_link: eachTeam['receiver']['receiverId']['userPic'].toString(),
              dateOfTransactions:  eachTeam['receiver']['receiverId']['createdAt'].toString(),            
           
              );
        } else {
          print("lole");
          print(_idgh);
          print(email);

          team = Team(
              id: eachTeam['sender']['senderId']['_id'].toString(),
              sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
              receiver_email:eachTeam['receiver']['receiverEmailPhone'].toString(),
              type: "Loan Taken",
              amount: eachTeam['amount'],
              mainMail: eachTeam['sender']['senderId']['_id'].toString(),
              name: eachTeam['sender']['senderId']['userName'].toString(),
              Transaction_status: eachTeam['transactionStatus'],
              Transaction_id: eachTeam['_id'].toString(),
              Sender_status: eachTeam['senderStatus'],
              Receiver_status: eachTeam['receiverStatus'],
              img_link: eachTeam['sender']['senderId']['userPic'].toString(),
              dateOfTransactions: eachTeam['sender']['senderId']['createdAt'].toString(),   
          
          //  img_link: eachTeam['userPic']
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
                     img_link: eachTeam['receiver']['receiverId']['userPic'].toString(),
              dateOfTransactions:  eachTeam['receiver']['receiverId']['createdAt'].toString(),   
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
                img_link: eachTeam['sender']['senderId']['userPic'].toString(),
              dateOfTransactions: eachTeam['sender']['senderId']['createdAt'].toString(),
              );
        }
      } else {
        team = "";
      }

      // //print(mainName);
      // if (eachTeam['_id'] != null &&
      //     eachTeam['sender']['senderId'] != null &&
      //     eachTeam['receiver']['receiverId'] != null &&
      //     eachTeam['type'] != null &&
      //     eachTeam['amount'] != null &&
      //     mainMail2 != null) {


             print("mmmmmmmmmmmm00000000000000mmmmmmmmmmmmmmmmmm2222222");
            print(widget.teams.mainMail.toString());
            print(team.mainMail.toString());
        if (widget.teams.mainMail == team.mainMail) {
          print("mmmmmmmmmmmm00000000000000mmmmmmmmmmmmmmmmmm--------------------------------------------------------bep");
          print(team.mainMail);
          //selfEmail
          teams2.add(team);
             print("-----------Test");
        print(widget.teams.mainMail);
        print(team.mainMail);
        }
       
          print("iteam count -------------0000000000000000000000000000000000   "+ teams2.length.toString());
        // teams2.add(team);

        //print(teams[teams.length-1].name);
      
     
    }
    //print("---------------------------------------");
    //print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;
   
    

    alertFunction() {
      //print("alert");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Change Status'),
            content: Text(
                'If You Acknowledge or Denied User will get a short notification'),
            actions: [
              TextButton(
                onPressed: () {
                  // teamsgator.of(context).pop();
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
    ///scafa 
    ///
    ///take string return month 
     String Return_month(String input) {
  // Perform some modifications to the input string
  String modifiedString = input.toUpperCase() + " (Modified)";
  final dateString = input;
  
  final dateTime = DateTime.parse(dateString);
  final month = DateFormat('MMMM').format(dateTime);
  
  print('Month: $month');
  
  return month;
}

   String Return_Year(String input) {
  // Perform some modifications to the input string
  String modifiedString = input.toUpperCase() + " (Modified)";
  
    final dateString = input;
  
  final dateTime = DateTime.parse(dateString);
  final year = DateFormat('MMMM').format(dateTime);
  
  print('year: $year');
  
  return year;
}

   String Return_day(String input) {
  // Perform some modifications to the input string
  final dateString = input;
  
  final dateTime = DateTime.parse(dateString);
  final day = DateFormat('MMMM').format(dateTime);
  
  print('day: $day');
  
  return day;
}


    
    return Scaffold(
      
      body:   SafeArea(
        child: Column(
        children: [
          Container(
            width: 390,
            height: height_safearea-430,
            child: Container(
              child: Stack(
                
             
                children: [
               
               Positioned(
                 top: 0,
                 
                child: 
               
                   Container(
                    width:392,
                    height: 150,
                    child: Image.asset(
                                        "assets/images/fl-npreview.jpg",  fit: BoxFit.cover)
                    ),
                ),

                Positioned(
                  top: 150-57,
                  left: 40,
                  child: Container(
                              width: 140 / 2 + 40,
                              height: 140 / 2 + 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    width: 6),
                              ),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(
                                   "https://personalrecordback-production.up.railway.app/amendmentDoc/" +
                                        widget.teams.img_link,
                                ),
                              ),
                            ),
                           
                
                )   ,
                Positioned(
                  
                  top: 230,
                  left: 60,
                  child:  Container(
          child:  Column(
            mainAxisAlignment:MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Text(
          widget.teams.name.toUpperCase(),
          style: GoogleFonts.mina(
            fontSize: 23.0,
            color: const Color.fromARGB(255, 48, 40, 40),
            fontWeight: FontWeight.w500
          ),
        ),
          
        
             
           RichText(
        text: TextSpan(
          text:  widget.teams.name.toUpperCase()+" owes You ",
          style: GoogleFonts.mina(
            fontSize: 13.0,
              color: const Color.fromARGB(255, 48, 40, 40),
            fontWeight: FontWeight.w500
          ),
          children: <TextSpan>[
            TextSpan(text: ' \$7999', style: GoogleFonts.mina(
            fontSize: 18.0,
            color:Color.fromARGB(189, 219, 18, 62),
            fontWeight: FontWeight.w700
          )
          
          ),
          ],
        ),
      ),
        RichText(
        text: TextSpan(
          text:  "You owes "+widget.teams.name.toUpperCase(),
          style: GoogleFonts.mina(
            fontSize: 13.0,
              color: const Color.fromARGB(255, 48, 40, 40),
            fontWeight: FontWeight.w500
          ),
          children: <TextSpan>[
            TextSpan(text: ' \$7999', style: GoogleFonts.mina(
            fontSize: 18.0,
            color:Color.fromARGB(255, 81, 224, 179),
            fontWeight: FontWeight.w700
          )
          
          ),
          ],
        ),
      )


         
            ],
          )
         )
         ),

     
     
                  
                ],
              ),
            ),

            
          ),

         


         SizedBox(
              width: width_safearea,
              height: 500 - 90,
              child: SizedBox(
                width: 200,
                child: ListView.builder(
                  itemCount: teams2.length,
                  itemBuilder: (context, index) {
                    // final item = teams2[index];
                    //main container which carries rtow 
                   
                    return  GestureDetector(
                      onTap: () {
                      Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return userdeatils_last(teams2[index]);
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
                      },
                      child: SizedBox(
              width: width_safearea,
              height: 500 - 90,
              child: SizedBox(
                width: 200,
                child: ListView.builder(
                  itemCount: teams2.length,
                  itemBuilder: (context, index) {
                    final item = teams2[index];
                    //main container which carries rtow 
                   
                    return  Container(
                      width: 350,
                     decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                   color: const Color.fromARGB(255, 240, 226, 226),
                  width: 0.7,
                ),
              ),
            ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 9),
                              child: Container(
                                width: 140 / 4 + 12,
                                height: 140 / 4 + 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromARGB(255, 101, 101, 230),
                                      width: 2.4+1),
                                ),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(
                                    "https://personalrecordback-production.up.railway.app/amendmentDoc/" +
                                        item.img_link,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              item.name.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 43, 54, 80),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(padding: 
                        EdgeInsets.fromLTRB(0,2,25,0),
                        
                        
                         child: Column(
                          children: [
                            item.Transaction_status == "LoanTaken"
                                ? Text("owes you")
                                : Text(" you owe"),
                            Text(
                              '\$' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.amber,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        )
                      ],
                    ),

                    );
                  },
                ),
              ),
            )
                    );
                  },
                ),
              ),
            )

        
        ],
      ),)
    );
  }
}