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
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'newTbb.dart';

class dash_new extends StatefulWidget {
  const dash_new({Key? key}) : super(key: key);

  @override
  _dash_newState createState() => _dash_newState();
}
  List<Team> teams = [];
  List<Team> Iteams = [];
 var jsonData=null;
  var _data;
class _dash_newState extends State<dash_new> {
  String _displayText = "";

  List<String> pictureofUsers = [];
  var Lang_val;
  var bannerChangeValue = 39.0;
  var totalOwnbyme = 0.0;
  var totalOwnFromMebyOthers = 0.0;
  Timer? timer;
  var CircularProgressIndicator_var = 0;

  var arr = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
  @override
  Future<void> callFunctionAfterDelay() async {
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      CircularProgressIndicator_var = 1;
    });
  }

  void initState() {
    super.initState();
   
  
    // getTeams2();
    fetchData();
   
    // callFunctionAfterDelay();
    var box = Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");

    Lang_val = _box2.get("Lang_val");
    //  Lang_val
  }

  String passFromTheclassmail = "";
  String passFromTheclassid = "";
  Map<String, int> hasUsedYet = {};
  Map<String, int> total_send = {};
  Map<String, int> total_received = {};
  var mydata=0;


  var amountOfUser;
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
     Future<void> fetchData() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    var response;
    // var jsonData;
     
try {
    Dio dio = Dio();
       DioCacheManager _dioCacherManager;
     _dioCacherManager = DioCacheManager(CacheConfig());
      Options _cacheOption =
          buildCacheOptions(Duration(minutes: 15), forceRefresh: true);
  
      dio.interceptors.add(_dioCacherManager.interceptor);
  dio.options.headers["Cookie"] = 'jwt_token=$gh';
   response = await dio.get(
    'https://$apiName/api/user/loansummary',
    options:_cacheOption
    
    
  );
  var jsonData2 = jsonEncode(response.data);
  jsonData=jsonDecode(jsonData2);
  print(jsonData['data']);
  setState(() {
    _data=jsonData['data'];
    print(_data.length.toString()+" ---<");
    // print(jsonData['success']);
  });
// jsonData = jsonEncode(response.data);
//     print("here is json");
//      jsonData2 = jsonDecode(jsonData);
//     print(jsonData2['data'].length);
//       print(jsonData2['data'][0]);
//     print(jsonData2['data'][0]['userName']);//notification pages data
} catch (e) {
  print('Error: $e');
}
    // setState(() {
    //  jsonData = jsonData2;
    //  print("json print hocce");
    //  print(jsonData['data'][0]['notifications']);
    //  _data=jsonData;
    
    // });
  
  }

  getTeams2() async {
   teams.clear;
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
   response = await dio.get(
    'https://$apiName/api/user/loansummary',
    options:_cacheOption
    
    
  );

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
      // String dateString =
      //     eachTeam['sender']['senderId']['createdAt'].toString();
      // dateString = "2023-02-06T10:36:26.420Z";
      // DateTime dateTime = DateTime.parse(dateString);
      // String month = DateFormat('MMM').format(dateTime); // e.g., "May"
      // String date = DateFormat('dd').format(dateTime); // e.g., "06"

      // print("dateTime  ---------- ::::::::::::::::::::");
      // print(date + " " + month);
      // print(eachTeam['receiver']['receiverId']['userPic']);

      // print(eachTeam['sender']['senderId']);

      // pictureofUsers.add(eachTeam['sender']['senderId']['userPic'].toString());
      // String mainMail2 = "";
      // String mainName = "";
      // print(eachTeam['type']['en_typeName']);
      final team;
      print(
          "___________________________________________________--------------");
      team = Team(
        id: eachTeam['id'].toString(),
        sender_email: "eachTeam['sender']['senderEmailPhone'].toString()",
        receiver_email:
            "eachTeam['receiver']['receiverEmailPhone'].toString(),",
        type: "Loan Given",
        amount: eachTeam['total_sent'], // total_send
        mainMail: eachTeam['id'].toString(), //id
        name: eachTeam['userName'].toString(), // name
        Transaction_status: "eachTeam['transactionStatus']",
        Transaction_id: eachTeam['total_received']
            .toString(), // total_received we use as t_id
        Sender_status: "eachTeam['senderStatus']",
        Receiver_status: "eachTeam['receiverStatus']",
        img_link: eachTeam['userPic'].toString(), //image
        dateOfTransactions: eachTeam['nearest_returnDate'].toString(),
      );

      setState(() {
        print(team.img_link.toString()+" -pic- "+team.mainMail);
        totalOwnbyme += team.amount;
        totalOwnFromMebyOthers += int.parse(team.Transaction_id);
      });

      // print(mainName);
      
      teams.add(team);

      print(teams[teams.length - 1].name);
      print(total_send[team.mainMail.toString()] = team.amount);
    }
    print("---------------------------------------");
    print(teams.length);
    setState(() {
      Iteams = teams;

      CircularProgressIndicator_var = 0;
    });
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
    var width_safearea2 = 352;
    var height_safearea2 = 750;

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    print("print the height");
    print(height_safearea);
    print(width_safearea);

    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          // systemOverlayStyle: SystemUiOverlayStyle(
          //   statusBarColor: Colors.white, // <-- SEE HERE
          //   statusBarIconBrightness:
          //       Brightness.dark, //<-- For Android SEE HERE (dark icons)
          //   statusBarBrightness:
          //       Brightness.light,
          //        //<-- For iOS SEE HERE (dark icons)
          // ),
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
        body: 
            
            //for potraitr mode pMode
            SafeArea(
                child: SingleChildScrollView(
                    child: Container(
                  height: height_safearea + 250,
                  child: Column(
                    children: [
                      //banner post where there is dart profile + row
                      Padding(
                          padding: EdgeInsets.all(8),
                          child: Stack(
                            children: [
                              Center(
                                child: SizedBox(
                                  height: .200071599 * height_safearea,
                                  width: .940071599 * width_safearea,
                                  child: SvgPicture.asset(
                                    'assets/images/geometricbg.svg',
                                    fit: BoxFit.fill,
                                    // Specify the width
                                    // Specify the height
                                  ),
                                ),
                              ),
                              Center(
                                // total balance container
                                child: Container(
                                    height: 0.150071599 * height_safearea,
                                    width: .940071599 * width_safearea,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color.fromARGB(
                                          255, 230, 230, 238),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            //image
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  (15 / width_safearea2) *
                                                      width_safearea,
                                                  0.008353222 * height_safearea,
                                                  0,
                                                  0),
                                              child: Container(
                                                width: (90 / width_safearea2) *
                                                    width_safearea,
                                                height: 0.10852029 *
                                                    height_safearea,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 101, 101, 230),
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

                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0,
                                                  0.022673031 * height_safearea,
                                                  0,
                                                  0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total Balance:",
                                                    style: GoogleFonts.lato(
                                                      color: Color.fromARGB(
                                                          255, 43, 54, 80),
                                                      fontSize: 0.019286396 *
                                                          height_safearea,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.0090000000 *
                                                        height_safearea,
                                                  ),
                                                  Text(
                                                    "You Owe : \ ৳" +
                                                        totalOwnbyme.toString(),
                                                    style: GoogleFonts.lato(
                                                      color: Color.fromARGB(
                                                          255, 217, 104, 23),
                                                      fontSize: 0.020286396 *
                                                          height_safearea,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 0.0070000000 *
                                                        height_safearea,
                                                  ),
                                                  Text(
                                                    "You are Owed : \ ৳" +
                                                        totalOwnFromMebyOthers
                                                            .toString(),
                                                    style: GoogleFonts.lato(
                                                      color: Color.fromARGB(
                                                          255,
                                                          65,
                                                          201,
                                                          185), //rgb(172, 213, 20owes 8)
                                                      fontSize: 0.020286396 *
                                                          height_safearea,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            height_safearea < width_safearea
                                                ? SizedBox(
                                                    width: (100 /
                                                            width_safearea2) *
                                                        width_safearea,
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                      ],
                                    )),
                              )
                            ],
                          )),

                      ///the list view starts here
                      ///
                      ///

                      SizedBox(
                        width: width_safearea,
                        height: 0.726 * height_safearea,
                        child:
                       _data.length==0?
                        Center(
                          child: CircularProgressIndicator(

                          ),
                        ):
                         SizedBox(
                          width: (200 / width_safearea2) * width_safearea,
                          child: ListView.builder(
                            itemCount:    _data.length,
                            itemBuilder: (context, index) {
                              // final item = teams[index];
                              //main container which carries rtow
                              print("---" + _data.length.toString());

                              return 
                              
                             GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return UserDetails(_data[index]['id']);

                                              // return userDetails(teams[index].mainMail);
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: height_safearea,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: const Color.fromARGB(
                                                  255, 240, 226, 226),
                                              width: 0.7,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 2, 0, 9),
                                                  child: Container(
                                                    width: 140 / 4 + 12,
                                                    height: 140 / 4 + 12,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Color.fromARGB(
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
                                                           _data[index]['userPic'],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                     _data[index]['userName'],
                                                      style: GoogleFonts.lato(
                                                        color: Color.fromARGB(
                                                            255, 43, 54, 80),
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        Text("you owe",
                                                            style: GoogleFonts
                                                                .lato(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      3,
                                                                      113,
                                                                      12),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        Text(
                                                          '\ ৳' +
                                                            _data[index]['total_sent']
                                                                  .toString(),
                                                          style:
                                                              GoogleFonts.lato(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    3,
                                                                    113,
                                                                    12),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                      children: [
                                                        Text("owes you",
                                                            style: GoogleFonts
                                                                .lato(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      236,
                                                                      8,
                                                                      16),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                        Text(
                                                          '\ ৳' +
                                                           _data[index]['total_received']
                                                                  .toString(),
                                                          style:
                                                              GoogleFonts.lato(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    236,
                                                                    8,
                                                                    16),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                )
                                              ],
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
              )
           
              
              );
              
 
  }
}
