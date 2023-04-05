import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/team.dart';

class UserDetails extends StatefulWidget {
   Team teams;
   String namee="";
  

  UserDetails(this.teams);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  var jsonData;
  String id = "";
  String id1 = "";
  String id2 = "";
  String tokenString2 = "";

  Future<void> getTeams2() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    print("Useeeeeeeeeeeeeeer detaaaaails --------------------------------------");
    print(id);
    print(widget.teams.name);
    print(widget.teams.id);
    print(widget.teams.amount);
    print(widget.teams.mainMail);
    String Bname = "";
    String Bmail = "";
    String Bamount = "";

    id = widget.teams.id;
    var response = await http.get(
      Uri.https('personalrec.onrender.com', 'api/transaction/getsumofusers/$id'),
      headers: {'Cookie': 'jwt_token=$gh'},
    );
    print(response.body);
    jsonData = jsonDecode(response.body);
    print(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          "Transaction Summary",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: FutureBuilder(
          future: getTeams2(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("done");
              return Card(
                child: ListView.builder(
                  itemCount: 1,
                  padding: EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 30.0),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 500,
                            height: 80,
                            child: Center(
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 19,
                                      ),
                                      child: Text(
                                        "All the Transaction",
                                        style: GoogleFonts.hammersmithOne(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 400,
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              
                              padding: const EdgeInsets.symmetric(
                                vertical: 0,
                              ),
                              child: Column(
                                
                                children: [
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                  ),
                                  Text(
                                    "User name : ${widget.teams.name}",
                                    style: GoogleFonts.hammersmithOne(
                                      fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),

                        ),
                         Text(
                                    "Loan Type : ${widget.teams.type}",
                                    style: GoogleFonts.hammersmithOne(
                                      fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),

                        ),
                         Text(
                                    "Amount : ${widget.teams.amount}",
                                    style: GoogleFonts.hammersmithOne(
                                      fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),

                        ),
                        Text(
                                    (widget.teams.type=="LoanTaken")?"Email : ${widget.teams.sender_email}":"Email : ${widget.teams.receiver_email}",
                                    style: GoogleFonts.hammersmithOne(
                                      fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),

                        ),


                ],
              )
                        
                        ),
                                 )
                        ],
                       )
                    );
                  },
                )
                );
              } else {
                return Center(
                   
                  child:Container(
                    width: 800,
                    height: 800,
                  color: Colors.white,
                  child:  
                 Center(
                  child:  Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(),
                  ),
                 )
                ));
              }
            }
            
            
            ),
      ),
    );
  }
}