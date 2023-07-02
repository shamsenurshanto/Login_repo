import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/PendingForm.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/newDash.dart';
import 'package:my_app/testUserdetails.dart';
import 'package:my_app/userDetailsTesting.dart';
import 'package:my_app/userDetails_last.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:workmanager/workmanager.dart';
import 'dart:io';

import 'PendingListBottom.dart';
import 'Team_new.dart';
import 'local_notifications.dart';
import 'models/team.dart';
import 'newTbb.dart';

class homepage2 extends StatefulWidget {
  const homepage2({super.key});

  @override
  State<homepage2> createState() => _homepage2State();
}
  var apiName = "personalrec.onrender.com";

class _homepage2State extends State<homepage2> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    fetchData();
    // fetchData();

    // Workmanager().registerOneOffTask(
    //   "taskTwo",
    //   "backUp",
    //     initialDelay: Duration(seconds: 5),
    // );
  }

  ///function for bangla
  List<Team> teams = [];
  List<Team> iteam_team = [];
  var Notification_number = 0;
  List<String> pictureofUsers = [];
  var amountOfUser;
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
  void callbackDispatcher() {
    Workmanager().executeTask((taskName, inputData) {
      print("Task executing :" + taskName);
      return Future.value(true);
    });
  }
  // add mob ad banner

  // late BannerAd bannerAd;
  bool isAdloaded = false;
  // initBannerAd(){
  //   bannerAd = BannerAd(
  //     size: AdSize.banner,
  //     adUnitId: '',
  //     listener: BannerAdListener(
  //       onAdLoaded: (ad){
  //         setState(() {
  //           isAdloaded=true;

  //         });
  //       }
  //       ,
  //       onAdFailedToLoad: (ad,error ){
  //         ad.dispose();
  //         print(error);

  //       }
  //     ),
  //     request: const AdRequest(),

  //     );
  //     bannerAd.load();
  // }

  Future<void> fetchData() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    var response = await http.get(
      Uri.https(apiName, 'api/user/loansummary'),
      headers: {'Cookie': 'jwt_token=$gh'},
    );
    // print(response.body);
    var jsonData = jsonDecode(response.body);

    print(jsonData['data']);

    var _data = json.decode(response.body);
    print("----------------------pop");
    print(
      _data['data'].length,
    );
    setState(() {
      Notification_number = _data['data'].length;
    });

    // print(jsonData['data'][0]['notifications'][0]);
    // print(jsonData['data'][0]['notifications'][0]['body']);//notification pages data
  }

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
            apiName, 'api/transaction/usersalltransactions'),
        headers: {'Cookie': 'jwt_token=$tokenString2'});
    var jsonData = jsonDecode(response.body);
    print(response.body);
    // print(jsonData['data']);
    var i = 0;
    for (var eachTeam in jsonData['data']) {
      // print(eachTeam['sender']['senderId']);
      print(eachTeam['receiver']['receiverId']['userPic']);
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
    iteam_team = teams;
  }

  @override
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;

    var temp = 0.0;
   
    var width_safearea2 = 392;
    var height_safearea2 = 750;

      if (MediaQuery.of(context).orientation ==
                                        Orientation.portrait) {
                                          print("hello potra");
                                      // is portrait
                                    } else {
                                      print("helo landa");
                                       setState(() {
                                      height_safearea = MediaQuery.of(context)
                                              .size
                                              .height -
                                          MediaQuery.of(context).padding.top;
                                      width_safearea =
                                          MediaQuery.of(context).size.width;

                                      var temp = 0.0;
                                      // if (height_safearea < width_safearea) {
                                      //   temp = height_safearea;
                                      //   height_safearea = width_safearea;
                                      //   width_safearea = temp;
                                      // }
                                      print(height_safearea);
                                      print(width_safearea);
                                    }
                                    )
                                    ;
// is landscape
                                    }

    int _counter = 0;
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack,
    //     overlays: [SystemUiOverlay.bottom]);

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
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return Container(
                height: 50,
                child: Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu_outlined,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                    Notification_number != 0
                        ? Positioned(
                            top: 10,
                            left: 25,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  Notification_number.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                              ),
                            ))
                        : SizedBox(
                            width: 0,
                            height: 0,
                          )
                  ],
                ),
              );
            },
          ),
          backgroundColor: Colors.white,
          // textDirection: TextDirection.rtl, // Set text direction to right-to-left
          elevation: 0.0,

          iconTheme:
              IconThemeData(color: const Color.fromARGB(255, 130, 83, 211)),
        ),
        drawer: SafeArea(
            child: Stack(
          children: [
            Positioned(
              child: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Text(
                        'দেনা পাওনা',
                        style: TextStyle(color: Colors.white, fontSize: 0),
                      ),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 38, 7, 91),
                          image: DecorationImage(
                              fit: BoxFit.scaleDown,
                              image: AssetImage(
                                'assets/icons/icon.png',
                              ))),
                    ),
                    ListTile(
                      leading: Icon(Icons.home),
                      title: Text(
                        'Home',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 38, 7, 91),
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(Icons.approval),
                      title: Text('Acknowledgement Pending',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 38, 7, 91),
                              fontWeight: FontWeight.bold)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.arrow_circle_up_rounded,
                        color: const Color.fromARGB(255, 38, 7, 91),
                      ),
                      title: Text('My Debits',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 38, 7, 91),
                              fontWeight: FontWeight.bold)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.arrow_circle_down,
                        color: const Color.fromARGB(255, 38, 7, 91),
                      ),
                      title: Text('My Credits',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 38, 7, 91),
                              fontWeight: FontWeight.bold)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.send,
                        color: const Color.fromARGB(255, 38, 7, 91),
                      ),
                      title: Text('Request a Debt (Pro)',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 38, 7, 91),
                              fontWeight: FontWeight.bold)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.receipt,
                        color: const Color.fromARGB(255, 38, 7, 91),
                      ),
                      title: Text('Request a Payment (Pro)',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 38, 7, 91),
                              fontWeight: FontWeight.bold)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timelapse,
                            color: const Color.fromARGB(255, 38, 7, 91),
                          ),
                        ],
                      ),
                      title: Text('Recent Dates',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 38, 7, 91),
                              fontWeight: FontWeight.bold)),
                      trailing: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 20,
                              height: 15 + 5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Center(
                                child: Text(
                                  Notification_number.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => tabBarForRecentDates()))
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Logout',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 38, 7, 91),
                              fontWeight: FontWeight.bold)),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
        body: SafeArea(
            child: SingleChildScrollView(
          child:
              //all card
              Column(
            children: [
              SizedBox(
                height: 0,
              ),

              //icon and text(total ) upper
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: width_safearea,
                    height: 0.36 * height_safearea,
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
                          width: 0.867346939 * width_safearea,
                          height: 0.24 * height_safearea,
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(
                                    (12 / height_safearea2) * height_safearea2),
                                child: Row(
                                  // total1 wallet balance
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: (40 / width_safearea2) *
                                            width_safearea,
                                        height: (40 / height_safearea2) *
                                            height_safearea,
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
                                              size: (22 / height_safearea2) *
                                                  height_safearea,
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      width: (38 / width_safearea2) *
                                          width_safearea2,
                                    ),
                                    Text(
                                      "Total wallet balance",
                                      style: TextStyle(
                                          fontSize: (20 / width_safearea2) *
                                              width_safearea2,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(
                                  (10 / width_safearea2) * width_safearea2,
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: (4 / width_safearea2) *
                                            width_safearea,
                                      ),
                                      Container(
                                        width: (200 / width_safearea2) *
                                            width_safearea,
                                        child: Row(
                                          children: [
                                            Container(
                                              color: Colors.white,
                                              child: Icon(
                                                Icons
                                                    .keyboard_double_arrow_up_sharp,
                                                color: Colors.green,
                                                size: (26 / width_safearea2) *
                                                    width_safearea2,
                                              ),
                                            ),
                                            Text(
                                              "৳7809.54",
                                              style: TextStyle(
                                                fontSize:
                                                    (30 / width_safearea2) *
                                                        width_safearea2,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: (20 / width_safearea2) *
                                            width_safearea,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                          (8 / width_safearea2) *
                                              width_safearea2,
                                        ),
                                        child: Center(
                                          child: Container(
                                              width: (80 / width_safearea2) *
                                                  width_safearea,
                                              height: (30 / height_safearea2) *
                                                  height_safearea,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.elliptical(10, 10)),
                                                color: Colors.green,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "+ ৳3.566",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: (16 /
                                                              width_safearea2) *
                                                          width_safearea2),
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
                height: 10 / 2,
              ),

              Container(
                width: (350 / width_safearea2) * width_safearea,
                height: (110 / height_safearea2) * height_safearea2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
                  color: Colors.white,
                ),
                child:
                    /**
                 * 
                   color: Color.fromARGB(
                                                  215, 94, 131, 233),
                                              size: 22,
                 * 
                 */
                    //center icon button iCenter
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Card(
                          elevation: (22 / height_safearea2) * height_safearea,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    (10 / width_safearea2) * width_safearea,
                                    0,
                                    0,
                                    0),
                                child: Column(
                                  //  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: (40 / width_safearea2) *
                                            width_safearea,
                                        height: (40 / height_safearea2) *
                                            height_safearea,
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
                                              size: (23 / height_safearea2) *
                                                  height_safearea,
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
                                width: (10 / width_safearea2) * width_safearea,
                              ),

                              //2 no icon
                              Column(
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: (40 / width_safearea2) *
                                          width_safearea,
                                      height: (40 / height_safearea2) *
                                          height_safearea,
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
                                            onTap: () {
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

                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          dash_new()));
                                            },
                                            child: Icon(
                                              Icons.dashboard,
                                              //#E9ECFA
                                              color: Color.fromARGB(
                                                  255, 166, 63, 197),
                                              size: (22 / height_safearea2) *
                                                  height_safearea,
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
                                width: (10 / width_safearea2) * width_safearea,
                              ),

                              Column(
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: (40 / width_safearea2) *
                                          width_safearea,
                                      height: (40 / height_safearea2) *
                                          height_safearea,
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
                                            onTap: () {
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
                                            child: Icon(
                                              Icons.pending_actions_outlined,
                                              //#E9ECFA
                                              color: Color.fromARGB(
                                                  255, 17, 200, 216),
                                              size: (22 / height_safearea2) *
                                                  height_safearea,
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
                                width: (10 / width_safearea2) * width_safearea,
                              ),

                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return tabBarForRecentDates();

                                        // return userDetails(teams[index].mainMail);
                                      },
                                    ),
                                  );
                                },
                                child: Column(
                                  //  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: (40 / width_safearea2) *
                                            width_safearea,
                                        height: (40 / height_safearea2) *
                                            height_safearea,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Color.fromARGB(45, 22, 196, 100),
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
                                              size: (22 / height_safearea2) *
                                                  height_safearea,
                                            ),
                                          ],
                                        )),
                                    //text
                                    Text(
                                      "Credit",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: (10 / width_safearea2) * width_safearea,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print("hello");

                                  try {
                                   
                                    //                  Workmanager().registerOneOffTask(
                                    //   "taskOne",
                                    //   "backUp",
                                    //   initialDelay: Duration(seconds: 1),
                                    // );
                                    Workmanager().registerPeriodicTask(
                                      "taskTwo",
                                      Notification_number.toString(),
                                      frequency: Duration(minutes: 15),
                                    );
                                  
                                  } catch (e) {
                                    print(e);
                                  }

                                  // NotificationService().showNotification(
                                  //     title: 'Sample title',
                                  //     body: 'Itddddddddddddddddddddddds!');
                                },
                                child: Column(
                                  //  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        width: (40 / width_safearea2) *
                                            width_safearea,
                                        height: (40 / height_safearea2) *
                                            height_safearea,
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
                                              size: (22 / height_safearea2) *
                                                  height_safearea,
                                            ),
                                          ],
                                        )),
                                    //text
                                    Text(
                                      "Approval",
                                      style: 
                                      TextStyle(
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        )),
              ),

              SizedBox(
                height: (70 / height_safearea2) * height_safearea,
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
                      offset: Offset(
                          10, 18), // Specifies the position of the shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                width: (392 / width_safearea2) * width_safearea,
                height: (420 / height_safearea2) * height_safearea,
                child: Column(
                  children: [
                    Column(
                      children: [
                        // main scrollable sizebar
                        SizedBox(
                          width: (360 / width_safearea2) * width_safearea,
                          height: (400 / height_safearea2) * height_safearea,
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
                                          width: (390 / width_safearea2) *
                                              width_safearea,
                                          height: (300 / height_safearea2) *
                                              height_safearea,
                                          child: ListView.builder(
                                            itemCount: teams.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              //  _incrementCounter(teams2[index].amount);

                                              return Container(
                                                width: (390 / width_safearea2) *
                                                    width_safearea,
                                                height:
                                                    (60 / height_safearea2) *
                                                        height_safearea,
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                // Row for the icons
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(7),
                                                                    child: ClipRRect(
                                                                        borderRadius: BorderRadius.circular(30.0),
                                                                        child:
                                                                            // pictureofUsers[index]?
                                                                            // Image
                                                                            //     .network(
                                                                            //       "https://personalrecordback-production.up.railway.app/amendmentDoc/"+pictureofUsers[0],
                                                                            //   width: 30,
                                                                            //   height:
                                                                            //       60 / 2,
                                                                            //   fit: BoxFit1
                                                                            //       .cover,
                                                                            // ):
                                                                            teams[index].img_link != ""
                                                                                ? Image.network(
                                                                                    "https://personalrecordback-production.up.railway.app/amendmentDoc/" + teams[index].img_link,
                                                                                    width: (30 / width_safearea2) * width_safearea,
                                                                                    height: (30 / height_safearea2) * height_safearea,
                                                                                    fit: BoxFit.cover,
                                                                                  )
                                                                                : Image.asset(
                                                                                    'assets/images/bluebackg.jpg',
                                                                                    width: (30 / width_safearea2) * width_safearea,
                                                                                    height: (30 / height_safearea2) * height_safearea,
                                                                                    fit: BoxFit.cover,
                                                                                  )),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 30,
                                                                  ),
                                                                  teams[index].type ==
                                                                          "Loan Given"
                                                                      ?

                                                                      //up arrow

                                                                      Icon(
                                                                          Icons
                                                                              .arrow_upward_outlined,
                                                                          color:
                                                                              Colors.deepPurple,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .arrow_downward_outlined,
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                  teams[index].Transaction_status ==
                                                                          "PENDING"
                                                                      ? Icon(
                                                                          Icons
                                                                              .hourglass_bottom_outlined,
                                                                          color:
                                                                              Colors.grey,
                                                                        )
                                                                      : Icon(
                                                                          Icons
                                                                              .done,
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  width: (125 /
                                                                          width_safearea2) *
                                                                      width_safearea),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                child: Text(
                                                                  "৳ " +
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
                                                width: width_safearea * 0.3,
                                                height: height_safearea * 0.04,
                                                child: Container(
                                                  width: width_safearea,
                                                  height: height_safearea,
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: const Color
                                                              .fromARGB(255,
                                                              221, 212, 212),
                                                        ),
                                                      ),
                                                      Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 3.0,
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.white),
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )),
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
