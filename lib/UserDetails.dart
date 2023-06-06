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

import 'models/team.dart';

class UserDetails extends StatefulWidget {
  Team teams;
  String namee = "";

  UserDetails(this.teams);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
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

  Future getTeams() async {
    //print("get teaaaaaaaaaaaaaaaaaaaaaaaaamsssss");

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

    return Scaffold(
     
       
       
    );
  }
}
