import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'models/team.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class userDetails extends StatelessWidget {
  Team teams ;
       
           
  String id=" " ;//for ids

  String id1=" " ; // for name 
  String id2 ="";
      
          var jsonData ;
   String tokenString2="";

   userDetails(this.teams);
   
   
   
  Future getTeams2()async {

    

  var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
     print("Useeeeeeeeeeeeeeer detaaaaails --------------------------------------");
     print(id);
    print(teams.name);
     print(teams.id);
     print(teams.amount);
     print(teams.mainMail);
     String Bname="";
     String Bmail="";
     String Bamount="";
     
         
          id=teams.id;
             var response = await http.get(Uri.https('personalrec.onrender.com', 'api/transaction//getsumofusers/${id}'),
     headers: {'Cookie': 'jwt_token=$gh'}
     
     );
             print(response.body);
     jsonData = jsonDecode(response.body);
    print(jsonData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
       appBar: AppBar(title: Text("Transaction Summary",
       style: TextStyle(fontSize: 20),),
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
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                     
                       Column(


                        children: [
                          Container(
                          
                           margin: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 30.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 500,
                        height: 80,
                        child: 

                  Center(
                    
                      child: Container(
                        child:Column(
                          children: [
                          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,),
              child:  Text("All the Transaction",
                        
                        style: GoogleFonts.hammersmithOne(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.white),

                        ),
                        
                        )
                           
                          ],
                        )
                        
                        
                      ),

                  )

                      ),

                                 Container(
                                  width: 400,
                                  height: 100,
                                 decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          
                          borderRadius: BorderRadius.circular(8),
                        ),
                                  child:  Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,),
              child:  Row(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                  )
                  ,
                  Text("User name : ${teams.name}",
                        
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