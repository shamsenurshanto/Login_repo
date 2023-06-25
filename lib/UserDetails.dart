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
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // date
  var month = "";
  var year = "";
  var day = "";

  void initState() {
    super.initState();
   

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

  void getGame() {
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
            dateOfTransactions: eachTeam['createdAt'].toString(),
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
            dateOfTransactions: eachTeam['createdAt'].toString(),

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
            dateOfTransactions: eachTeam['createdAt'].toString(),
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
            dateOfTransactions: eachTeam['createdAt'].toString(),
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
        print(
            "mmmmmmmmmmmm00000000000000mmmmmmmmmmmmmmmmmm--------------------------------------------------------bep");
        print(team.mainMail);
        //selfEmail
        teams2.add(team);
        print("-----------Test");
        print(widget.teams.mainMail);
        print(team.mainMail);
      }

      print("iteam count -------------0000000000000000000000000000000000   " +
          teams2.length.toString());
      // teams2.add(team);

      //print(teams[teams.length-1].name);
    }
    //print("---------------------------------------");
    //print(teams.length);
    setState(() {
      items = teams2;
    });
  }

  @override
  Widget build(BuildContext context) {
 var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;
    
    var temp =0.0;
    if(height_safearea<width_safearea)
    {
      temp = height_safearea;
      height_safearea = width_safearea;
      width_safearea = temp;
    }
    var width_safearea2 = 392;
    var  height_safearea2 = 750;
//  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]);
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//  ));
    //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.);
    // FlutterStatusbarcolor.setStatusBarColor(Colors.green);

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.,

    //  overlays: []
    // );

    ///scafa
    ///
    ///take string return month
    String Return_month(String input) {
      // Perform some modifications to the input string
      String modifiedString = input.toUpperCase() + " (Modified)";
      final dateString = input;

      final dateTime = DateTime.parse(dateString);
      final month = DateFormat('MMM').format(dateTime);

      print('Month: $month');

      return month;
    }

    String Return_Year(String input) {
      // Perform some modifications to the input string
      String modifiedString = input.toUpperCase() + " (Modified)";

      final dateString = input;

      final dateTime = DateTime.parse(dateString);
      final year = DateFormat('y').format(dateTime);

      print('year: $year');

      return year;
    }

    String Return_day(String input) {
      // Perform some modifications to the input string
      final dateString = input;

      final dateTime = DateTime.parse(dateString);
      final day = DateFormat('d').format(dateTime);

      print('day: $day');

      return day;
    }

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child:  Column(
            children: [
              Container(
                width: width_safearea,
                height: (370/height_safearea2) * height_safearea,
                child: Container(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: Container(
                            width: width_safearea,
                            height: (180/height_safearea2) * height_safearea,
                            child: Image.asset("assets/images/fl-npreview.jpg",
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        top: ((200-95)/height_safearea2) * height_safearea,
                        left: (40/width_safearea2) * width_safearea,
                        child: Container(
                          width:  (110/width_safearea2) * width_safearea,
                          height:  (120/height_safearea2) * height_safearea,
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
                      ),
                      Positioned(
                          top:  (250/height_safearea2) * height_safearea,
                          left: (70/width_safearea2) * width_safearea,
                          child: Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.teams.name.toUpperCase(),
                                style: GoogleFonts.mina(
                                    fontSize:  (23/width_safearea2) * width_safearea,
                                    color:
                                        const Color.fromARGB(255, 48, 40, 40),
                                    fontWeight: FontWeight.w500),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: widget.teams.name.toUpperCase() +
                                      " owes You ",
                                  style: GoogleFonts.mina(
                                          fontSize:  (13/width_safearea2) * width_safearea,
                                      color:
                                          const Color.fromARGB(255, 48, 40, 40),
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' ৳7999',
                                        style: GoogleFonts.mina(
                                              fontSize:  (13/width_safearea2) * width_safearea,
                                            color: Color.fromARGB(
                                                189, 219, 18, 62),
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "You owes " +
                                      widget.teams.name.toUpperCase(),
                                  style: GoogleFonts.mina(
                                          fontSize:  (13/width_safearea2) * width_safearea,
                                      color:
                                          const Color.fromARGB(255, 48, 40, 40),
                                      fontWeight: FontWeight.w500),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' ৳7999',
                                        style: GoogleFonts.mina(
                                              fontSize:  (13/width_safearea2) * width_safearea,
                                            color: Color.fromARGB(
                                                255, 81, 224, 179),
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                              )
                            ],
                          ))),
                    ],
                  ),
                ),
              ),

              /// the user dtls
              items.length == 0
                  ? Container(
                      width: width_safearea,
                      height: (300/height_safearea2) * height_safearea,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ))
                  : SizedBox(
                      width: width_safearea,
                      height: (411/750) * height_safearea,
                      child: SizedBox(
                        width:      (203/width_safearea2) * width_safearea,
                        child: ListView.builder(
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];

                            var month2 = Return_month(item.dateOfTransactions);
                            var year2 = Return_Year(item.dateOfTransactions);
                            var day2 = Return_day(item.dateOfTransactions);
                            print(month2.toString() +
                                " " +
                                year.toString() +
                                " " +
                                day2.toString());

                            //main container which carries rtow

                            return GestureDetector(
                              onTap: () {
                                //       Navigator.push(context,MaterialPageRoute(
                                //     builder: (context) {
                                //       return UserDetails(items[index]);

                                //       // return userDetails(teams[index].mainMail);
                                //     }

                                //     ,
                                //   )

                                //   ,
                                // );
                              },
                              child: Container(
                                width: (350/width_safearea2) * width_safearea,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 240, 226, 226),
                                      width: (0.7/width_safearea2) * width_safearea,
                                    ),
                                  ),
                                ),
                                child: index == 0
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all((20/width_safearea2) * width_safearea,),
                                            child: Text(
                                              month2 + " " + year2,
                                              style: TextStyle(
                                                  fontSize: (20/width_safearea2) * width_safearea,
                                                  fontWeight: FontWeight.w200,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            3, 5, 3, 3),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: Text(
                                                              month2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                  // color: Color.fromARGB(255, 25, 80, 189),
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: Text(
                                                              day2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 23),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 2, 0, 9),
                                                    child: Container(
                                                      width: 140 / 4 + 12,
                                                      height: 140 / 4 + 12,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    101,
                                                                    101,
                                                                    230),
                                                            width: 2.4 + 1),
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 100,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "https://personalrecordback-production.up.railway.app/amendmentDoc/" +
                                                              item.img_link,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                              item.name.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 43, 54, 80),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Padding(padding: EdgeInsets.all(2),
                          
                          
                          child: item.Transaction_status=="PENDING"?
                            Text(
                              item.Transaction_status.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ):
                              Text(
                              item.Transaction_status.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              ],
                            )
                                                ],
                                              ),
                                              Padding(padding: 
                        EdgeInsets.fromLTRB(0,2,25,0),
                        
                        
                         child: Column(
                          children: [
                            item.type == "Loan Taken"
                                ? Text("owes you",style: GoogleFonts.lato(
                               color: Color.fromARGB(255, 236, 8, 16),
                               
                                fontWeight: FontWeight.bold,
                              ))
                                : Text(" you owe",style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                                ),),
                         item.type == "Loan Taken"
                                ?     Text(
                              '\ ৳' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 236, 8, 16),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ):
                              Text(
                              '\ ৳' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 3, 113, 12),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        )
                                            ],
                                          ),
                                        ],
                                      )
                                    : 
                                    
                                    //if index is not 0 
                                      Return_month(teams2[index - 1]
                                                      .dateOfTransactions) !=
                                                  month2
                                              ?  Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(20),
                                            child: Text(
                                              month2 + " " + year2,
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w200,
                                                  color: Colors.black),
                                            ),
                                          ),
                                           Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                 mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            3, 5, 3, 3),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: Text(
                                                              month2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                  // color: Color.fromARGB(255, 25, 80, 189),
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: Text(
                                                              day2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 23),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 2, 0, 9),
                                                    child: Container(
                                                      width: 140 / 4 + 12,
                                                      height: 140 / 4 + 12,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    101,
                                                                    101,
                                                                    230),
                                                            width: 2.4 + 1),
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 100,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "https://personalrecordback-production.up.railway.app/amendmentDoc/" +
                                                              item.img_link,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                 Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                              item.name.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 43, 54, 80),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Padding(padding: EdgeInsets.all(2),
                          
                          
                          child: item.Transaction_status=="PENDING"?
                            Text(
                              item.Transaction_status.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ):
                              Text(
                              item.Transaction_status.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              ],
                            )
                                                ],
                                              ),
                                              Padding(padding: 
                        EdgeInsets.fromLTRB(0,2,25,0),
                        
                        
                         child: Column(
                          children: [
                            item.type == "Loan Taken"
                                ? Text("owes you",style: GoogleFonts.lato(
                               color: Color.fromARGB(255, 236, 8, 16),
                               
                                fontWeight: FontWeight.bold,
                              ))
                                : Text(" you owe",style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                                ),),
                         item.type == "Loan Taken"
                                ?     Text(
                              '\ ৳' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 236, 8, 16),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ):
                              Text(
                              '\ ৳' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 3, 113, 12),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        )
                                            ],
                                          ),
                                        ],
                                      ):

                                   Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                 mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            3, 5, 3, 3),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: Text(
                                                              month2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w200,
                                                                  // color: Color.fromARGB(255, 25, 80, 189),
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2),
                                                            child: Text(
                                                              day2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w100,
                                                                  fontSize: 23),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 2, 0, 9),
                                                    child: Container(
                                                      width: 140 / 4 + 12,
                                                      height: 140 / 4 + 12,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    101,
                                                                    101,
                                                                    230),
                                                            width: 2.4 + 1),
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 100,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "https://personalrecordback-production.up.railway.app/amendmentDoc/" +
                                                              item.img_link,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                 Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                              item.name.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 43, 54, 80),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          Padding(padding: EdgeInsets.all(2),
                          
                          
                          child: item.Transaction_status=="PENDING"?
                            Text(
                              item.Transaction_status.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ):
                              Text(
                              item.Transaction_status.toString(),
                              style: GoogleFonts.lato(
                                color: Colors.green,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              ],
                            )
                                                ],
                                              ),
                                              Padding(padding: 
                        EdgeInsets.fromLTRB(0,2,25,0),
                        
                        
                         child: Column(
                          children: [
                            item.type == "Loan Taken"
                                ? Text("owes you",style: GoogleFonts.lato(
                               color: Color.fromARGB(255, 236, 8, 16),
                               
                                fontWeight: FontWeight.bold,
                              ))
                                : Text(" you owe",style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                                ),),
                         item.type == "Loan Taken"
                                ?     Text(
                              '\ ৳' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 236, 8, 16),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ):
                              Text(
                              '\ ৳' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 3, 113, 12),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        )
                                            ],
                                          ),
                                      
                                      
                                      
                              ),
                            );
                          },
                        ),
                      ),
                    )

              //push 1
            ],
          ),
       
          )
       
        )
        
        );
  }
}
