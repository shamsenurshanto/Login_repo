import 'dart:convert';
// import 'dart:html';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/AddTransactions.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/homePage2.dart';
import 'package:my_app/tbb.dart';
import 'package:shimmer/shimmer.dart';
import 'models/team.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/team.dart';
import 'newTbb.dart';

class dash4 extends StatefulWidget {
  const dash4({Key? key}) : super(key: key);

  @override
  _dash4State createState() => _dash4State();
}
var Iteams ;
var CircularProgressIndicator_var=0;
 
class _dash4State extends State<dash4> {
  String _displayText = "";
  List<Team> teamsP = [];
  var Lang_val;
  var _idLoggedIn;
  var arr = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
  var dialog_box_eng =
      'If You Acknowledge or Denied User will get a short notification.Once You change status can not change it later';
  var dialog_box_bangla =
      'যদি আপনি স্বীকার করেন বা অস্বীকার করেন তবে ব্যবহারকারী একটি সংক্ষিপ্ত বিজ্ঞপ্তি পাবেন৷ একবার আপনি স্থিতি পরিবর্তন করলে পরে এটি পরিবর্তন করতে পারবেন না।';

  @override
  void initState() {
    super.initState();
    var box = Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");

    Lang_val = _box2.get("Lang_val");
     teamsP.clear;
    getTeams2();

    //  Lang_val
  }
  

  String passFromTheclassmail = "";
  String passFromTheclassid = "";
  var apiName = "personalrec.onrender.com";
 
  var amountOfUser;
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
  getTeams2() async {
    teamsP.clear;
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var _idLoggedIn = _box2.get("User_id"); //my user id
    var email = _box2.get("User_email");
    var apiName = "api.lenden.cloud";

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

    // var response = await http.get(Uri.https(apiName, 'api/user/loansummary'),
    //     headers: {'Cookie': 'jwt_token=$tokenString2'});

    var response;
    var jsonData;

    try {
      Dio dio = Dio();
      DioCacheManager _dioCacherManager;
      _dioCacherManager = DioCacheManager(CacheConfig());
      Options _cacheOption =
          buildCacheOptions(Duration(minutes: 5), forceRefresh: true);

      dio.interceptors.add(_dioCacherManager.interceptor);
      dio.options.headers["Cookie"] = 'jwt_token=$tokenString2';
      response = await dio.get('https://$apiName/api/transaction/usersalltransactions',
          options: _cacheOption);

      print(response.data.runtimeType);
      jsonData = jsonEncode(response.data);
      print("here is json");
      print(jsonDecode(jsonData));
    } catch (e) {
      print('Error: $e');
    }

    // start ----------------------------------------------->

    // print(jsonData['data']);
    var jsonData2 = jsonDecode(jsonData);

     for (var eachTeam in jsonData2['data']) {
      String dateString =
          eachTeam['sender']['senderId']['createdAt'].toString();
      dateString = "2023-02-06T10:36:26.420Z";
      DateTime dateTime = DateTime.parse(dateString);
      // String month = DateFormat('MMM').format(dateTime); // e.g., "May"
      // String date = DateFormat('dd').format(dateTime); // e.g., "06"

      // print("dateTime  ---------- ::::::::::::::::::::");
      // print(date + " " + month);
      // print(eachTeam['receiver']['receiverId']['userPic']);

      // print(eachTeam['sender']['senderId']);

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
    
      teamsP.add(team);

      // print(mainName);
      // if (eachTeam['_id'] != null &&
      //     eachTeam['sender']['senderId'] != null &&
      //     eachTeam['receiver']['receiverId'] != null &&
      //     eachTeam['type'] != null &&
      //     eachTeam['amount'] != null &&
      //     mainMail2 != null) {
       

      //   print(teams[teams.length - 1].name);
      // }
    }
    print("---------------------------------------");
    print(teamsP.length);
    setState(() {
      Iteams=teamsP;
       
      CircularProgressIndicator_var=1;
  
 

    });
   
  }
    // print("---------------------------------------");
    // print(teamsP.length);
  
  
  
  
  // method somuho

  ReceiverAck(int index) async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    setState(() {
      CircularProgressIndicator_var=1;
    });
    print("hereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");

    var response = await http.post(
      Uri.https(apiName, 'api/transaction/changestatus'),
      headers: {
        //  'Content-Type': 'application/json; charset=UTF-8',

        'Cookie': 'jwt_token=$gh'
      },
      body: {"id": teamsP[index].Transaction_id, "receiverStatus": "RECEIVED"},
    );
    //    print(widget.teams.Transaction_id);
    //  jsonData = jsonDecode(response.body);
    // print(jsonData);
    print("received");
  }

  SenderAck(int index) async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
     setState(() {
      CircularProgressIndicator_var=1;
    });

    var response = await http.post(
      Uri.https(apiName, 'api/transaction/changestatus'),
      headers: {
        //  'Content-Type': 'application/json; charset=UTF-8',

        'Cookie': 'jwt_token=$gh'
      },
      body: {"id": teamsP[index].Transaction_id, "senderStatus": "SENT"},
    );
    print(teamsP[0].Transaction_id);
    //  jsonData = jsonDecode(response.body);
    // print(jsonData);
    //  print("sent");
  }

  Denied(int index) async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    var response;
    teamsP[index].type == "Loan Taken"
        ? response = await http.post(
            Uri.https(apiName, 'api/transaction/changestatus'),
            headers: {
              //  'Content-Type': 'application/json; charset=UTF-8',

              'Cookie': 'jwt_token=$gh'
            },
            body: {
              "id": teamsP[index].Transaction_id,
              "receiverStatus": "Denied"
            },
          )
        : response = await http.post(
            Uri.https(apiName, 'api/transaction/changestatus'),
            headers: {
              //  'Content-Type': 'application/json; charset=UTF-8',

              'Cookie': 'jwt_token=$gh'
            },
            body: {"id": teamsP[index].Transaction_id, "senderStatus": "Denied"},
          );
    print(teamsP[0].Transaction_id);
    //  jsonData = jsonDecode(response.body);
    // print(jsonData);
    //  print("sent");
  }

  alertFunction(int index) {
    print("alert");
   
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print("dialog");
        return CupertinoAlertDialog(
          //dialog_box_bangla
          title: Lang_val == "English"
              ? Text('Change Status')
              : Text("অপেক্ষামান তালিকা পরিবর্তন"),
          content: Lang_val == "English"
              ? Text(dialog_box_eng)
              : Text(dialog_box_bangla),
          actions: [
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                // print()
                teamsP[index].type == "Loan Taken"
                    ? ReceiverAck(index)
                    : SenderAck(index);
                Navigator.of(context).pop();
              },
              child: Lang_val == "English"
                  ? Text(
                      'ACKNOWLEDGED',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'স্বীকার করলাম',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
            ),
            TextButton(
                onPressed: () {
                  Denied(index);
                  Navigator.of(context).pop();
                  print("deni koresen");
                },
                child: Lang_val == "English"
                    ? Text(
                        'Denied',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      )
                    : Text(
                        'অস্বীকার করলাম',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      )),
          ],
        );
      },
    );
  }

  alertFunction2(int index) {
    print("alert");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        print("dialog");
        return CupertinoAlertDialog(
          title: Lang_val == "English"
              ? Text('Pending Status')
              : Text('অপেক্ষামান তালিকা'),
          content: Lang_val == "English"
              ? Column(
                  children: [
                    Text("Sender Mail : " +
                        teamsP[index].sender_email.toString()),
                    Text("Receiver Mail : " +
                        teamsP[index].receiver_email.toString())
                  ],
                )
              : Column(
                  children: [
                    Text("প্রেরক : " + teamsP[index].sender_email.toString()),
                    Text("প্রাপক : " + teamsP[index].receiver_email.toString())
                  ],
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                print("deni koresen");
              },
              child: Lang_val == "English" ? Text('Done') : Text('সম্পন্ন'),
            ),
          ],
        );
      },
    );
  }

  //method end

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
      appBar: AppBar(
        title: Text(
          "Approvals",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 4,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.of(context).pop();
          },
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(180, 20, 71, 214),
        onPressed: () {
          print("hello");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return dash_newMyBottomNavigationBar_new();

                // return userDetails(teams[index].mainMail);
                //added
              },
            ),
          );
        },
        child: const Icon(
          Icons.home_outlined,
          color: Color.fromARGB(200, 255, 255, 255),
          size: 40,
        ),
      ),
      body: SafeArea(
        child: 
       CircularProgressIndicator_var==0  ?

         Shimmer.fromColors(
                    child: Center(
                      child: Container(
                          child: ListView.builder(
                        itemCount: 10,
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: width_safearea * 0.903061224,
                                height: height_safearea * 0.133,
                                margin: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          );
                        },
                      )),
                    ),
                    baseColor: Colors.grey.withOpacity(0.1),
                    highlightColor: Colors.grey.shade300)

                    :
        Container(
          child:

           
                 Card(


                    color: Colors.white,
                    child: 
                    RefreshIndicator(
                       onRefresh: ()async
                       {
                              initState();
                       },
                       child: ListView.builder(
                      itemCount: Iteams.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UserDetails(Iteams[index]);

                                  // return userDetails(teams[index].mainMail);
                                },
                              ),
                            );
                          },
                          child: 
                         Iteams[index].Transaction_status ==
                                                        "PENDING"?
                            Card(
                              elevation: 14.0,
                              color: Colors.grey[100],
                              margin: EdgeInsets.all(10),
                              child: 
                              SizedBox(
                                height: height_safearea * 0.163,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: width_safearea * 0.051020408,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 2nd row for the
                                        //loan given -> dhar dewa
                                        Lang_val == "English"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 8, 6, 8),
                                                child: Text(
                                                  Iteams[index].type,
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Colors.black),
                                                ),
                                              )
                                            : Iteams[index].type == "Loan Given"
                                                ? Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(12, 8, 6, 8),
                                                    child: Text(
                                                      "ধার দিয়েছি",
                                                      style: GoogleFonts.mina(
                                                        fontSize:
                                                            width_safearea *
                                                                0.05020408,
                                                        shadows: [
                                                          Shadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              offset:
                                                                  const Offset(
                                                                      7, 7),
                                                              blurRadius: 15),
                                                        ],
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,

                                                      //
                                                    ))
                                                : Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(12, 8, 6, 8),
                                                    child: Text(
                                                      "ধার নিয়েছি",
                                                      style: GoogleFonts.mina(
                                                        fontSize:
                                                            width_safearea *
                                                                0.05020408,
                                                        shadows: [
                                                          Shadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.3),
                                                              offset:
                                                                  const Offset(
                                                                      7, 7),
                                                              blurRadius: 15),
                                                        ],
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.black,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,

                                                      //
                                                    ))
                                        //  //loan given -> dhar dewa

                                        ,

                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 4, 16, 8),
                                            child: // if pending
                                                Iteams[index].Transaction_status ==
                                                        "PENDING"
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          print("hello");
                                                          alertFunction2(index);
                                                          // do something when icon is clicked
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .hourglass_bottom_rounded, // set the icon to the heart icon
                                                          size:
                                                              30.0, // set the size of the icon to 32.0 pixels
                                                          color: Colors.blue
                                                              .shade300, // set the color of the icon to red
                                                        ),
                                                      )

                                                    ///else complete
                                                    ///:Widget
                                                    : GestureDetector(
                                                        onTap: () {
                                                          print("hello");
                                                          // do something when icon is clicked
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .done_sharp, // set the icon to the heart icon
                                                          size:
                                                              30.0, // set the size of the icon to 32.0 pixels
                                                          color: Colors.green
                                                              .shade700, // set the color of the icon to red
                                                        ),
                                                      )
                                                      
                                                      
                                                      )
                                      ],
                                    ),
                                    SizedBox(
                                      width: width_safearea * 0.051020408,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 1, 6, 8),
                                          child: Text(
                                            Iteams[index].name.toUpperCase(),
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width_safearea * 0.051020408,
                                    ),
                                    //   Good Row

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // money -> taka

                                        Lang_val == "English"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 8, 6, 4),
                                                child: Text(
                                                  "\$" +
                                                      Iteams[index]
                                                          .amount
                                                          .toString(),
                                                  style: TextStyle(
                                                      fontSize: width_safearea *
                                                          0.06020408,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black),
                                                ),
                                              )
                                            :

                                            //banglka
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        12, 8, 6, 4),
                                                child: Text(
                                                  "৳" +
                                                      getString(Iteams[index]
                                                          .amount
                                                          .toString()),
                                                  style: TextStyle(
                                                      fontSize: width_safearea *
                                                          0.06020408,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black),
                                                )),

                                        TextButton(
                                          onPressed: () {
                                            // add your onPressed logic here
                                            alertFunction(index);
                                          },
                                          child: Icon(
                                            Icons
                                                .approval_rounded, // set the icon to the heart icon
                                            size:
                                                30.0, // set the size of the icon to 32.0 pixels
                                            color: Colors
                                                .green, // set the color of the icon to red
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                              
                              )

                          :
                          SizedBox()
                        
                        
                        );
                      },
                    
                    )
                      )
                   


              
              
                // return Center(child: CircularProgressIndicator());

              
                
                // Shimmer.fromColors(
                //     child: Center(
                //       child: Container(
                //           child: ListView.builder(
                //         itemCount: 10,
                //         padding: EdgeInsets.all(8),
                //         itemBuilder: (context, index) {
                //           return Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Container(
                //                 width: width_safearea * 0.903061224,
                //                 height: height_safearea * 0.133,
                //                 margin: const EdgeInsets.only(
                //                     top: 8.0, bottom: 8.0),
                //                 decoration: BoxDecoration(
                //                   color: Colors.white,
                //                   borderRadius: BorderRadius.circular(8),
                //                 ),
                //               ),
                //             ],
                //           );
                //         },
                //       )),
                //     ),
                //     baseColor: Colors.grey.withOpacity(0.1),
                //     highlightColor: Colors.grey.shade300);
                
              
            
           
          ),
        )
               
               
                
      
      ),
    );
  }
}
