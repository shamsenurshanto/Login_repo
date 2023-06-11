import 'dart:async';
import 'dart:convert';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:my_app/AddTransactions.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/UserDetailsForPendingList.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/homePage2.dart';
import 'package:my_app/tbb.dart';
import 'package:my_app/userDetails_last.dart';
import 'package:shimmer/shimmer.dart';
import 'models/team.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'newTbb.dart';

class dash_new extends StatefulWidget {
  const dash_new({Key? key}) : super(key: key);

  @override
  _dash_newState createState() => _dash_newState();
}

class _dash_newState extends State<dash_new> {
  String _displayText = "";

  List<String> pictureofUsers = [];
  var Lang_val;
  var bannerChangeValue = 39.0;
  var totalOwnbyme = 0.0;
  var totalOwnFromMebyOthers = 0.0;
   Timer? timer;

  var arr = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
  @override
  void initState() {
    super.initState();
  
    getTeams();
    var box = Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");

    Lang_val = _box2.get("Lang_val");
    //  Lang_val
  }

  String passFromTheclassmail = "";
  String passFromTheclassid = "";

  List<Team> teams = [];
  var amountOfUser;
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
   getTeams() async {
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
      String dateString =
          eachTeam['sender']['senderId']['createdAt'].toString();
      dateString = "2023-02-06T10:36:26.420Z";
      DateTime dateTime = DateTime.parse(dateString);
      String month = DateFormat('MMM').format(dateTime); // e.g., "May"
      String date = DateFormat('dd').format(dateTime); // e.g., "06"

      print("dateTime  ---------- ::::::::::::::::::::");
      print(date + " " + month);
      print(eachTeam['receiver']['receiverId']['userPic']);

      // print(eachTeam['sender']['senderId']);

      pictureofUsers.add(eachTeam['sender']['senderId']['userPic'].toString());
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
            dateOfTransactions:
                eachTeam['receiver']['receiverId']['createdAt'].toString(),
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
            dateOfTransactions:
                eachTeam['sender']['senderId']['createdAt'].toString(),

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
            dateOfTransactions:
                eachTeam['receiver']['receiverId']['createdAt'].toString(),
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
            dateOfTransactions:
                eachTeam['sender']['senderId']['createdAt'].toString(),
          );
        }
      } else {
        team = "";
      }
      if (team.type == "Loan Taken") {
        print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");

        print(totalOwnFromMebyOthers);
        setState(() {
          totalOwnFromMebyOthers += team.amount;
        });
      } else {
        print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        setState(() {
          totalOwnbyme += team.amount;
        });

        print(totalOwnbyme);
      }

      // print(mainName);
      if (eachTeam['_id'] != null &&
          eachTeam['sender']['senderId'] != null &&
          eachTeam['receiver']['receiverId'] != null &&
          eachTeam['type'] != null &&
          eachTeam['amount'] != null &&
          mainMail2 != null) {
        teams.add(team);

        print(teams[teams.length - 1].name);
      }
    }
    print("---------------------------------------");
    print(teams.length);
  }

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

  @override
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, // <-- SEE HERE
          statusBarIconBrightness:
              Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness:
              Brightness.light,
               //<-- For iOS SEE HERE (dark icons)
        ),
        foregroundColor: Colors.white,
        elevation: 0,

        // leading: Text(
        //   "Transaction",
        //   style: TextStyle(  color: Color.fromARGB(255, 155, 155, 176),),
        // ),
        // title: Text(
        //   "Transaction",
        //   style: TextStyle(  color: Color.fromARGB(255, 155, 155, 176),),
        // ),

        backgroundColor: Color.fromARGB(184, 255, 255, 255),
        // textDirection: TextDirection.rtl, // Set text direction to right-to-left
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("hello");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return addTrans();

                // return userDetails(teams[index].mainMail);
              },
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          child: Container(
            height: height_safearea,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Transaction",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
            ),

            //banner post where there is dart profile + row
            Padding(
                padding: EdgeInsets.all(8),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/geometricbg.svg',
                      width: 160, // Specify the width
                      height: 150, // Specify the height
                    ),
                    Container(
                      height: 120-11,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 230, 230, 238),
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //image
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 7, 0, 0),
                            child: Container(
                              width: 140 / 2 + 12,
                              height: 140 / 2 + 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color.fromARGB(255, 101, 101, 230),
                                    width: 4),
                              ),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundImage: NetworkImage(
                                  'https://media.istockphoto.com/id/1439271299/tr/vekt%C3%B6r/cute-koala-is-reading-book-vector-illustration-on-purple-background.jpg?s=170667a&w=0&k=20&c=bKzwjm8Pf8sS_UHnKQZ8VMoi3HlM8O24ZooOBY_WSjc=',
                                ),
                              ),
                            ),
                          ),

                          // column
                          SizedBox(
                            width: 20,
                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 19, 0, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Balance:",
                                  style: GoogleFonts.lato(
                                    color: Color.fromARGB(255, 43, 54, 80),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "You Owe : \$" + totalOwnbyme.toString(),
                                  style: GoogleFonts.lato(
                                    color: Color.fromARGB(255, 217, 104, 23),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "You are Owed : \$" +
                                      totalOwnFromMebyOthers.toString(),
                                  style: GoogleFonts.lato(
                                    color: Color.fromARGB(
                                        255, 65, 201, 185), //rgb(172, 213, 208)
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),

            ///the list view starts here
            ///
            ///

            SizedBox(
              width: width_safearea,
              height: 500-50,
              child: SizedBox(
                width: 200,
                child: ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (context, index) {
                    final item = teams[index];
                    //main container which carries rtow 
                   
                    return  GestureDetector(
                      onTap: () {
                      Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return UserDetails(teams[index]);
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
                      },
                      child: Container(
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
                              '\$' + item.amount.toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 236, 8, 16),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ):
                              Text(
                              '\$' + item.amount.toString(),
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
          ],
        ),
      )),
    );
  }
}
