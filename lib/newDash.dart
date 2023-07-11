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
var jsonData = null;
var _data;
var Notification_number = 0;

  var CircularProgressIndicator_var=0;

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
     print("this is init ");

    // getTeams2();
    fetchData();
   

    // if(CircularProgressIndicator_var==0)

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
  var mydata = 0;

  var amountOfUser;
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
  Future<void> fetchData() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    var response;
    // var jsonData;
    print("this is fetch ");
    print(  CircularProgressIndicator_var);

    try {
      Dio dio = Dio(  );
      DioCacheManager _dioCacherManager;
      _dioCacherManager = DioCacheManager(CacheConfig());
      Options _cacheOption =
          buildCacheOptions(Duration(minutes: 15), forceRefresh: true);

      dio.interceptors.add(_dioCacherManager.interceptor);
      dio.options.headers["Cookie"] = 'jwt_token=$gh';
      response = await dio.get('https://$apiName/api/user/loansummary',
          options: _cacheOption);
      var jsonData2 = jsonEncode(response.data);
      jsonData = jsonDecode(jsonData2);
      print(jsonData['data']);
      setState(() {
        _data = jsonData['data'];
        print(_data.length.toString() + " ---<");
        Notification_number = _data.length;
          CircularProgressIndicator_var = 1;

        // print(jsonData['success']);
      });

    } catch (e) {
      print('Error: $e');
    }
 

    // });
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
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);
    print("print the height");
    print(height_safearea);
    print(width_safearea);

    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          title: Text(
            "Dashboard",
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
                                color: const Color.fromARGB(255, 230, 230, 238),
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
                                          height: 0.10852029 * height_safearea,
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
                                                fontWeight: FontWeight.bold,
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
                                                fontWeight: FontWeight.bold,
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      height_safearea < width_safearea
                                          ? SizedBox(
                                              width: (100 / width_safearea2) *
                                                  width_safearea,
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                ],
                              )),
                        )
                      ],
                    )
                    ),

                ///the list view starts here
                ///
                ///

                SizedBox(
                  width: width_safearea,
                  height: 0.726 * height_safearea,
                  child: 
               CircularProgressIndicator_var==0? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: (200 / width_safearea2) * width_safearea,
                          child: ListView.builder(
                            itemCount: _data.length?? 0,
                            itemBuilder: (context, index) {
                              // final item = teams[index];
                              //main container which carries rtow
                              print("---" + _data.length.toString());

                              return GestureDetector(
                                onTap: () {
                                  Team team = Team(
                                    id: _data[index]['id'].toString(),
                                    sender_email:
                                        "eachTeam['sender']['senderEmailPhone'].toString()",
                                    receiver_email:
                                        "eachTeam['receiver']['receiverEmailPhone'].toString(),",
                                    type: "Loan Given",
                                    amount: _data[index]
                                        ['total_sent'], // total_send
                                    mainMail:
                                        _data[index]['id'].toString(), //id
                                    name: _data[index]['userName']
                                        .toString(), // name
                                    Transaction_status:
                                        "eachTeam['transactionStatus']",
                                    Transaction_id: _data[index]
                                            ['total_received']
                                        .toString(), // total_received we use as t_id
                                    Sender_status: "eachTeam['senderStatus']",
                                    Receiver_status:
                                        "eachTeam['receiverStatus']",
                                    img_link: _data[index]['userPic']
                                        .toString(), //image
                                    dateOfTransactions: _data[index]
                                            ['nearest_returnDate']
                                        .toString(),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UserDetails(team);

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
                                                        255, 101, 101, 230),
                                                    width: 2.4 + 1),
                                              ),
                                              child: CircleAvatar(
                                                radius: 100,
                                                backgroundImage: NetworkImage(
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
                                                  fontWeight: FontWeight.bold,
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
                                                      style: GoogleFonts.lato(
                                                        color: Color.fromARGB(
                                                            255, 3, 113, 12),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  Text(
                                                    '\ ৳' +
                                                        _data[index]
                                                                ['total_sent']
                                                            .toString(),
                                                    style: GoogleFonts.lato(
                                                      color: Color.fromARGB(
                                                          255, 3, 113, 12),
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
                                                      style: GoogleFonts.lato(
                                                        color: Color.fromARGB(
                                                            255, 236, 8, 16),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  Text(
                                                    '\ ৳' +
                                                        _data[index][
                                                                'total_received']
                                                            .toString(),
                                                    style: GoogleFonts.lato(
                                                      color: Color.fromARGB(
                                                          255, 236, 8, 16),
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
        ));
  }
}
