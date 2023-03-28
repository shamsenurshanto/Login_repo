import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/AddTransactions.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/addTransaction2.dart';
import 'models/team.dart';
import 'package:flutter/material.dart';


class dash2 extends StatelessWidget {
  List<Team> teams = [];
   //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
  Future getTeams() async {


  var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
  

               //hive initialization and get data
              
         
         print("apii te +++++++++++++++++++++++");
         var gh = _box2.get("tokens");
   
    print(gh.runtimeType);

  String token = "";

   String cookie = gh;
        
 
  String str = gh,ghh,tokenString2="";
  // tokenString2 = cookie;
  int flag=0;

  //making the jwt_token
  for (int rune in str.runes) {
    if(String.fromCharCode(rune)=='=' )
    {
       flag =1;
       continue;
    }
    else if(String.fromCharCode(rune)==';')
    {
      tokenString2+=String.fromCharCode(rune);
      break;
    }

    if(flag>0)
    {
    // print();
     tokenString2+=String.fromCharCode(rune);
       
    }
  }
  
  


    //ab33@gmail.com

  print("token api ---------- ::::::::::::::::::::");
  final _box = Hive.box("mybox");
  _box.put("toki", tokenString2);

print(tokenString2);
   print(tokenString2.runtimeType);

    var response = await http.get(Uri.https('smoggy-toad-fedora.cyclic.app', 'api/transaction/usersalltransactions'), headers: {'Cookie': 'jwt_token=$tokenString2'});
    var jsonData = jsonDecode(response.body);
    // print(response.body);
    // print(jsonData['data']);

    for (var eachTeam in jsonData['data']) {
      print(eachTeam['sender']['senderId']);
      String mainMail2="";
      if(eachTeam['type']=="63efbef607ca4144957e03ef")
      {
            mainMail2 = eachTeam['sender']['senderId'];
      }
      else
      {
         mainMail2 = eachTeam['receiver']['receiverId'];
      }
      final team = Team(
        id: eachTeam['_id'],
        sender_email: eachTeam['sender']['senderId'],
        receiver_email: eachTeam['receiver']['receiverId'],
        type: eachTeam['type'],
        amount: eachTeam['amount'],
        mainMail: mainMail2
        
        
      );
      
      teams.add(team);
    }

    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")
      
        
      ),
        floatingActionButton: FloatingActionButton(
        
        onPressed: () {
                           
                            
                              print("hello");
                               Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return addTrans();
                     
                      // return userDetails(teams[index].mainMail);
                    },
                  ),
                );
                            },
        child: const Icon(Icons.add,color: Colors.white,)
        ,
      )
      ,
      
      body: SafeArea(
        
       child: 
       
       Container(
        child: 
        
        
         FutureBuilder(
          
            
              future: getTeams(),
              builder:
              
                
               (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Card(
                    child: ListView.builder(
                    itemCount: teams.length,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            onTap: () {
                             print(teams[index].type);
                            
                              print("hello");
                               Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      // return dash2();
                     
                      return userDetails(teams[index].mainMail);
                    },
                  ),
                );
                            },
                            title: Text(teams[index].amount.toString()),
                            subtitle: Text(teams[index].sender_email),
                            trailing: Text("\$${teams[index].amount.toString()}",
                            
                             textScaleFactor: 1.5,
                             style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold
                             ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                  );
                      
                  
                  
                } else {
                  return Center(child: CircularProgressIndicator());
                }
                
              },
              
              
              
              ),
       ),
            
      ),
      
    );
  }
}
