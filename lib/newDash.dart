import 'dart:convert';
// import 'dart:html';
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

class dash_new extends StatefulWidget {
  const dash_new({Key? key}) : super(key: key);

  @override
  _dash_newState createState() => _dash_newState();
}

class _dash_newState extends State<dash_new> {
  String _displayText = "";
  var Lang_val;

  var arr = ["০", "১", "২", "৩", "৪", "৫", "৬", "৭", "৮", "৯"];
  @override
  void initState() {
    super.initState();
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
            'personalrec.onrender.com', 'api/transaction/usersalltransactions'),
        headers: {'Cookie': 'jwt_token=$tokenString2'});
    var jsonData = jsonDecode(response.body);
    print(response.body);
    // print(jsonData['data']);

    for (var eachTeam in jsonData['data']) {
      // print(eachTeam['sender']['senderId']);
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
              Receiver_status: eachTeam['receiverStatus']);
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
              Receiver_status: eachTeam['receiverStatus']);
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
              Receiver_status: eachTeam['receiverStatus']);
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
              Receiver_status: eachTeam['receiverStatus']);
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
    appBar: AppBar(
      foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return homepage2();
                  },
                ),
              ); // Go back to the previous page
          },
        ),
        title: Text(
          "Transaction",
          style: TextStyle(color: Colors.black),
        ),

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
          
          child: FutureBuilder(
            future: getTeams(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Card(
                    color: Colors.white,
                    child: ListView.builder(
                      itemCount: teams.length,
                      padding: EdgeInsets.all(10),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return UserDetails(teams[index]);

                                  // return userDetails(teams[index].mainMail);
                                },
                              ),
                            );
                          },
                          child: Card(
                              elevation: 14.0,
                              color: Colors.grey[100],
                              margin: EdgeInsets.all(10),
                              child: SizedBox(
                                height: height_safearea * 0.108,
                                child: Row(
                                  
                                  
                                  children: [

                                 Padding(
                                  padding: EdgeInsets.all(10),
                                 child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              child: Image.network(
                                                'https://t3.ftcdn.net/jpg/03/05/77/64/360_F_305776453_t7SUl48g63zLsyODxd60aj6EcWR9avVK.jpg',
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                 ),
                                 teams[index].type=="Loan Given"?

                                 //up arrow 
                                     
                                    Icon(
                                      Icons.arrow_upward_outlined
                                      ,
                                      color: Colors.deepPurple,
                                    )

                                    :

                                     Icon(
                                      Icons.arrow_downward_outlined
                                      ,
                                      color: Colors.green,
                                    ),


                                    teams[index].Transaction_status=="PENDING"?
                                     Icon(
                                      Icons.hourglass_bottom_outlined
                                      ,
                                      color: Colors.grey,
                                    )
                                    :

                                     Icon(
                                      Icons.done
                                      ,
                                      color: Colors.green,
                                    ),



                                   SizedBox(
                                    width: 130,
                                   ),
                                     Padding(padding: EdgeInsets.all(10),
                                     child:  Text(
                                      "\$ "+teams[index].amount.toString(),style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17
                                      ),
                                    ),)
                                   
                                 




                                ],)
                              )),
                        );
                      },
                    )
                    
                    );
              } else {
                // return Center(child: CircularProgressIndicator());

                return Shimmer.fromColors(
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
                                height: height_safearea * 0.1033,
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
                    highlightColor: Colors.grey.shade300);
              }
            },
          ),
        ),
      ),
    );
  }
}
