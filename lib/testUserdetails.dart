import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:my_app/UserDetails.dart';
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

class MyListView_ extends StatefulWidget {
  @override
  _MyListView_State createState() => _MyListView_State();
}

class _MyListView_State extends State<MyListView_> {
  String valAmount = "";
  var loanStaus = "";
  var amoutUser = 0;
  var loanTopay = 0;
  var lonTest = "0";
  var statusName="debit";
  List<Team> teams2 = [];
  var lan_status = "English";

  Future<List> fetchData() async {
    // Make API request
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    print(response.body);
    print("seccuess");
    // Decode JSON response
    List data = json.decode(response.body);
    getTeams();

    // Return data
    return teams2;
  }

  List<dynamic> items = [];

  var Lang_val = "English";
  var amountOfUser = "";

  var box = Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
  // _box2.put("valu_sum", 0);
  // amountOfUser = _box2.get("valu_sum").to;
  // _idLoggedIn= _box2.get("User_id");//my user id
  //        email= _box2.get("User_email");
  //        name= _box2.get("User_name");

  var arr = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
  //kkk ollo
  printAndReturnString(String inputString) {
    for (var i = 0; i < inputString.length; i++) {
      setState(() {
        lan_status = "Bangla";
        //  //print("hhhhhhhhhhhhhhhhhhhhhhllllllllllllllllll");
        //  //print(inputString);
        valAmount += arr[int.parse(inputString[i])];
        // widget.teams.type.toString()=="Loan Taken"?loanStaus="ধার নিয়েছি":loanStaus="ধার দিয়েছি";
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
  // var lan_status = "English";
  var loan_status = "";
  var arrayForLoanEng = [
    "Sender: ",
    "Receiver : ",
  ];
  var arrayForLoanBangla = [
    "প্রেরক :",
    "প্রাপক : ",
  ];
  var jsonData2;

  void initState() {
    super.initState();

    var box = Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    getTeams();

    lan_status = _box2.get("Lang_val");

    //        Lang_val
    print(lan_status);
    print("giiiiiiiiiiiiiiiiga");

    lan_status = _box2.get("Lang_val");
  }

  // List<Team> teams2 = [];
  //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams

  int trackerLoancount = 0;
  void apicall(int x, int length) {
    // print("apiii");
    if (trackerLoancount < length)
      setState(() {
        loanTopay += x;

        trackerLoancount++;
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
          mainMail: eachTeam['id'].toString(),
          name: eachTeam['userName'].toString(),
          id: "",
          sender_email: "",
          receiver_email: "",
          type: "pending",
          Transaction_status: "eachTeam['transactionStatus']",
          Transaction_id: " eachTeam['_id'].toString()",
          Sender_status: "eachTeam['senderStatus']",
          Receiver_status: "eachTeam['receiverStatus']",
          // img_link: " eachTeam['receiverStatus']"
          );
      print("this is for id");
      print(team.id);
      apicall((eachTeam['total_received'] - eachTeam['total_sent']).abs(),
          jsonData['data'].length);

      teams2.add(team);
    }
    //print("---------------------------------------");
    //print(teams.length);
  }
  void creditCountFunction(){
    int lontestInt=0;
   
      for(var product in teams2  )
      {
        print(product.amount);
        lontestInt+=product.amount-100;

      }
      setState(() {
        lonTest = lontestInt.toString();
        statusName=" Credit";
      });
  }
  void debitCountFunction()
  {
     int lontestInt=0;
   
      for(var product in teams2  )
      {
        print(product.amount);
        lontestInt+=product.amount;

      }
      setState(() {
        lonTest = lontestInt.toString();
        statusName=" Debit";
      });
 
  }

  @override
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<List>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            
            return Column(
              children: [
                Column(
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
                                  height:
                                      300 / height_safearea * height_safearea,
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
                                        Text("Total"+statusName,
                                            style: GoogleFonts.mina(
                                                color: Color.fromARGB(
                                                    255, 33, 25, 77),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15)),
                                        Text("\$$lonTest",
                                            style: GoogleFonts.mina(
                                                color: Color.fromARGB(
                                                    255, 33, 25, 77),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 50.0,
                                              width: 90.0,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Color.fromARGB(
                                                      255,
                                                      203,
                                                      202,
                                                      253), // Change the background color
                                                  onPrimary: Colors
                                                      .white, // Change the text color
                                                ),
                                                onPressed: () {
                                                      print("hello");
                                                       creditCountFunction();

                                                },
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
                                                  primary: Color.fromARGB(
                                                      255,
                                                      203,
                                                      202,
                                                      253), // Change the background color
                                                  onPrimary: Colors
                                                      .white, // Change the text color
                                                ),
                                                onPressed: () {
                                                  print("hello");
                                                   debitCountFunction();
                                                },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    /// change it here for responsiveness
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          // color: const Color.fromARGB(255, 116, 68, 199),
                                          color:
                                              Color.fromARGB(140, 40, 40, 205),
                                        ),
                                        Text(
                                          "Add",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  140, 40, 40, 205),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.send,
                                          // color: const Color.fromARGB(255, 116, 68, 199),
                                          color:
                                              Color.fromARGB(140, 40, 40, 205),
                                        ),
                                        Text(
                                          "Send",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  140, 40, 40, 205),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(60)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade300
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 17,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.wallet,
                                          // color: const Color.fromARGB(255, 116, 68, 199),
                                          color:
                                              Color.fromARGB(140, 40, 40, 205),
                                        ),
                                        Text(
                                          "Wallet",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  140, 40, 40, 205),
                                              fontWeight: FontWeight.w800),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        //here en,d
                        Positioned(
                            top: 50 / height_safearea * height_safearea,
                            right: 20 / width_safearea * width_safearea,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60.0),
                                image: DecorationImage(
                                    image: AssetImage('assets/images/cat.jpg'),
                                    fit: BoxFit.cover),
                                color: Color.fromARGB(255, 202, 212, 253),
                              ),
                              width: 40.0,
                              height: 40.0,
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
                //conta
                GestureDetector(
                  onTap: () {
                    print("hello");
                  },
                  child: Container(
                    margin: EdgeInsets.all(1),
                    width: 350,
                    height: 250,
                    child: ListView.builder(
                      itemCount: teams2.length,
                      itemBuilder: (BuildContext context, int index) {
                        //  _incrementCounter(teams2[index].amount);

                        print(teams2[index].amount);
                        //calling function for adding the debot amount
                       

                        return Container(
                            width: 200,
                            height: 70,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return UserDetails(teams2[index]);

                                      // return userDetails(teams[index].mainMail);
                                    },
                                  ),
                                );
                              },
                              child: Padding(padding: EdgeInsets.all(0),
                              child: Card(

                                  ///rkjs2
                                  ///
                                  elevation: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Image.network(
                                                'https://t3.ftcdn.net/jpg/03/05/77/64/360_F_305776453_t7SUl48g63zLsyODxd60aj6EcWR9avVK.jpg',
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 35,
                                              right: 5,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.green,
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.white,
                                                    size: 17,
                                                  )))
                                        ],
                                      ),
                                      SizedBox(
                                        width: 30,
                                      )
                                      ,
                                      Column(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                       mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                         
                                          Text(
                                            teams2[index].name
                                          ),
                                          SizedBox(
                                            height: 1,
                                          ),
                                           Text(
                                            teams2[index].type,style: TextStyle(fontWeight: FontWeight.w200,fontSize: 10),
                                          ),

                                          

                                        ],
                                      ),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      Text(
                                        "\$"+teams2[index].amount.toString()
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  )
                              )
                                  
                                  ),
                            ));
                      },
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
