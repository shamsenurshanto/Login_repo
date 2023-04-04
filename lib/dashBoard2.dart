import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/AddTransactions.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/tbb.dart';
import 'package:shimmer/shimmer.dart';
import 'models/team.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class dash2 extends StatelessWidget {
      String passFromTheclassmail = "";
    String passFromTheclassid = "";
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

    var response = await http.get(Uri.https('personalrec.onrender.com', 'api/transaction/usersalltransactions'),
     headers: {'Cookie': 'jwt_token=$tokenString2'}
     
     );
    var jsonData = jsonDecode(response.body);
    print(response.body);
    // print(jsonData['data']);

    for (var eachTeam in jsonData['data']) {
      print(eachTeam['sender']['senderId']);
      String mainMail2="";
       String mainName="";
         print(eachTeam['type']['en_typeName']);
         final team;
         print("___________________________________________________--------------");
      if(eachTeam['type']['en_typeName']=="LoanTaken")
      {
        //  mainMail2 = eachTeam['sender']['senderId']['_id'];
        //     mainName = eachTeam['sender']['senderId']['userName'];
            
          print(mainName);
            team = Team(

        id: eachTeam['sender']['senderId']['_id'].toString(),
        sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
        receiver_email: eachTeam['receiver']['receiverEmailPhone'].toString(),
        type: eachTeam['type']['en_typeName'].toString(),
        amount: eachTeam['amount'],
         mainMail:eachTeam['sender']['senderId']['_id'].toString(),
     
        name: eachTeam['sender']['senderId']['userName'].toString(),
        
        
        
      );
           
      }
      else
      {
          

            //  mainMail2 = eachTeam['receiver']['receiverId']['_id'];
            // mainName = eachTeam['receiver']['receiverId']['userName'];
              print(mainName);
                 team = Team(

        id: eachTeam['sender']['senderId']['_id'].toString(),
        sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
        receiver_email: eachTeam['receiver']['receiverEmailPhone'].toString(),
        type: eachTeam['type']['en_typeName'].toString(),
        amount: eachTeam['amount'],
          mainMail: eachTeam['sender']['senderId']['_id'].toString(),
        name: eachTeam['receiver']['receiverId']['userName'].toString()
        
        
        
      );
      }
 
      // print(mainName);
      if(eachTeam['_id']!=null && eachTeam['sender']['senderId']!=null &&  eachTeam['receiver']['receiverId'] !=null && eachTeam['type']  !=null && eachTeam['amount']!=null && mainMail2!=null)
     {
           print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
      print(mainName);
      
      teams.add(team);
      
      print(teams[teams.length-1].name);
     }
      
      
    }
     print("---------------------------------------");
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
    



      appBar: AppBar(title: Text("Dashboard"),
      backgroundColor: Colors.deepPurple,
      
      automaticallyImplyLeading: false,
      
        
      ),
        floatingActionButton: FloatingActionButton(
        
        onPressed: () {
                           
                            
                              print("hello");
            Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return addTrans();
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
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
                             print(teams[index].name);
                                 
                              print("hello");
                               Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      // return dash2();
                         print(")))))))))))))))))))))))))))))))");
                         print(index);
                     print(teams[index].name);
                      return UserDetails(teams[index]);
                    },
                  ),
                );
                            },
                            title: teams[index].type=="63efbef607ca4144957e03ef"?Text(teams[index].receiver_email):Text(teams[index].sender_email),
                            
                            subtitle: Text((teams[index].type).toString()),
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
                      
                  
                  
                }
                 else {
                  // return Center(child: CircularProgressIndicator());

                  return Shimmer.fromColors(
                    
                    child: 
                 Center(
                  child: 
                   Container(
                    child: 
                    ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          
                      
           
                                Container(
                          width: 354,
                                  height: 70,
                                margin: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          
                        ),

                       
                    

                        
                      
                        ],
                      );
                    },
                  )
                    
                  ),
                 )
                  
                  
                  , baseColor:Colors.grey.withOpacity(0.1), highlightColor: Colors.grey.shade300);


                }
                
              },
              
              
              
              ),
       ),
            
      ),
      
    );
  }
}