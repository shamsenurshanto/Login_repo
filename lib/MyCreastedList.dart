import 'dart:convert';
// import 'dart:html';
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


class dash3 extends StatelessWidget {
      String passFromTheclassmail = "";
    String passFromTheclassid = "";
  List<Team> teams = [];
   //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams
  Future getTeams() async {


     teams.clear();
  var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
   var _idLoggedIn= _box2.get("User_id");//my user id 
          var email= _box2.get("User_email");
  

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

    var response = await http.get(Uri.https('personalrec.onrender.com', 'api/transaction/createdtransactions/1'),
     headers: {'Cookie': 'jwt_token=$tokenString2'}
     
     );
    var jsonData = jsonDecode(response.body);
    print(response.body);
    // print(jsonData['data']);

    for (var eachTeam in jsonData['data']) {
      // print(eachTeam['sender']['senderId']);
      String mainMail2="";
       String mainName="";
         print(eachTeam['type']['en_typeName']);
         final team;
         print("___________________________________________________--------------");
      if(eachTeam['type']['en_typeName']=="LoanTaken")
      {
        //  mainMail2 = eachTeam['sender']['senderId']['_id'];
        //     mainName = eachTeam['sender']['senderId']['userName'];

        //here it is gone for change    TO SEE EACH OTHER
         var _idgh = _box2.get("User_id");//my user id 
          var email= _box2.get("User_email");
          if(_idgh==eachTeam['sender']['senderId']['_id'].toString())
          {
            print("ole");
            print(_idgh);
            print(email);
             



                 team = Team(

        id: eachTeam['sender']['senderId']['_id'].toString(),
        sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
        receiver_email: eachTeam['receiver']['receiverEmailPhone'].toString(),
        type: "Loan Given",
        amount: eachTeam['amount'],
         mainMail:eachTeam['receiver']['receiverId']['_id'].toString(),
     
        name: eachTeam['receiver']['receiverId']['userName'].toString(),
         Transaction_status: eachTeam['transactionStatus'],
         Transaction_id:  eachTeam['_id'].toString()
        
        
        
      );






          }
          else{
            print("lole");
             print(_idgh);
              print(email);


               team = Team(

        id: eachTeam['sender']['senderId']['_id'].toString(),
        sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
        receiver_email: eachTeam['receiver']['receiverEmailPhone'].toString(),
        type: "Loan Taken",
        amount: eachTeam['amount'],
         mainMail:eachTeam['sender']['senderId']['_id'].toString(),
     
        name: eachTeam['sender']['senderId']['userName'].toString(),
        
         Transaction_status: eachTeam['transactionStatus'],
         Transaction_id:  eachTeam['_id'].toString()
        
      );



          }
            
          print(mainName);
         
           
           
      }
      else if(eachTeam['type']['en_typeName']=="LoanGiven")
      {
        //  mainMail2 = eachTeam['sender']['senderId']['_id'];
        //     mainName = eachTeam['sender']['senderId']['userName'];

        //here it is gone for change    TO SEE EACH OTHER
         var _idgh = _box2.get("User_id");//my user id 
          var email= _box2.get("User_email");
          if(_idgh==eachTeam['sender']['senderId']['_id'].toString())
          {
            print("ole");
            print(_idgh);
            print(email);
             



                 team = Team(

        id: eachTeam['sender']['senderId']['_id'].toString(),
        sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
        receiver_email: eachTeam['receiver']['receiverEmailPhone'].toString(),
        type: "Loan Given",
        amount: eachTeam['amount'],
        mainMail:eachTeam['receiver']['receiverId']['_id'].toString(),
     
        name: eachTeam['receiver']['receiverId']['userName'].toString(),
        
         Transaction_status: eachTeam['transactionStatus'].toString(),
         Transaction_id:  eachTeam['_id'].toString()
        
      );






          }
          else{
            print("lole");
             print(_idgh);
              print(email);


               team = Team(

        id: eachTeam['sender']['senderId']['_id'].toString(),
        sender_email: eachTeam['sender']['senderEmailPhone'].toString(),
        receiver_email: eachTeam['receiver']['receiverEmailPhone'].toString(),
        type: "Loan Taken",
        amount: eachTeam['amount'],
        

         mainMail:eachTeam['sender']['senderId']['_id'].toString(),
     
        name: eachTeam['sender']['senderId']['userName'].toString(),
         Transaction_status: eachTeam['transactionStatus'],
         Transaction_id:  eachTeam['_id'].toString()
        
        
      );



          }
            
          
         
           
           
      }
      else{
        team="";
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
     
    



      appBar: AppBar(title: Text("My Created Transaction",style: TextStyle(color: Colors.black),),
      elevation: 4,
      backgroundColor: Colors.white,
      leading: IconButton(
    icon: Icon(Icons.arrow_back,color: Colors.black,),
    onPressed: () {
      // Navigate back when the back button is pressed
      Navigator.of(context).pop();
    },
  ),
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
                    color: Colors.white,
                    child:
                    
                     ListView.builder(
                    itemCount: teams.length,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                           Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return UserDetails(teams[index]);
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
                        },
                        child: Card(
                          elevation: 14.0,
                          color: Colors.grey[100],
                  margin: EdgeInsets.all(10),
                   child:  SizedBox(
                    height: 130,
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       
                       SizedBox(
                        width: 20,
                       ),
                          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Padding(
                         padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
                            child:     Text(
                              teams[index].type,style: TextStyle(fontSize: 25 ,fontStyle: FontStyle.normal,fontWeight: FontWeight.w300,color: Colors.black),
                            ),
                            
                      ),
                      // 2nd row for the 
                        Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                           Icon(
                    Icons.circle_rounded, // set the icon to the heart icon
                    size: 12.0, // set the size of the icon to 32.0 pixels
                    color: Colors.blue, // set the color of the icon to red
                  ),

                              TextButton(
                  onPressed: () {
                    // add your onPressed logic here
                    print("hello");
                  },
                  child: Text(
                    teams[index].Transaction_status,
                    style: TextStyle(fontSize: 18.0),
                                      ),
                    ),
                          ],
                        )
                        ],
                      )
                      ,
                       SizedBox(
                        width: 20,
                       ),
                      
                        Padding(
                        padding: const EdgeInsets.fromLTRB(12, 1, 6, 8),
                            child:     Text(teams[index].name.toUpperCase(),style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400),
                            ),
                      ),
                       SizedBox(
                        width: 20,
                       ),
                        
                        Row(
                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                             Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 6, 8),
                            child:     Text(
                              "\$"+teams[index].amount.toString(),style: TextStyle(fontSize: 20,fontWeight:FontWeight.w700 ),
                            ),
                      ),
                                                  TextButton(
                              onPressed: () {
                                // add your onPressed logic here
                                 Navigator.push(context,MaterialPageRoute(
                    builder: (context) {
                      return UserDetails(teams[index]);
                     
                      // return userDetails(teams[index].mainMail);
                    }
                    
                    
                    ,
                  )
                  
                  
                  
                  ,
                );
                              },
                              child: Text(
                                'View More',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue, // set the color of the text to blue
                                  decoration: TextDecoration.underline, // underline the text
                                ),
                              ),
                            )

                           
                          ],
                        )
                    ],
                   ),
                   )
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
                                  height: 120,
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
// final List<String> items = [
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 6',
//     'Item 7',
//     'Item 8',
//     'Item 9',
//     'Item 10',
//     'Item 11',
//     'Item 12',
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 6',
//     'Item 7',
//     'Item 8',
//     'Item 9',
//     'Item 10',
//     'Item 11',
//     'Item 12',
//     'Item 1',
//     'Item 2',
//     'Item 3',
//     'Item 4',
//     'Item 5',
//     'Item 6',
//     'Item 7',
//     'Item 8',
//     'Item 9',
//     'Item 10',
//     'Item 11',
//     'Item 12'
//   ];
//     return Scaffold(
//       backgroundColor: Colors.blue.shade100,
//         appBar: AppBar(title: Text("Home"),
//           backgroundColor: Color.fromARGB(96, 115, 108, 108),
      
//       automaticallyImplyLeading: false,
      
        
//       ),
      
    
//          body: Container(
//           color:  Color.fromARGB(96, 115, 108, 108),
//           child: Column(
            
//             children: [
//               //logo
//               Center(
//                 child: Text("Dene pawna",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w900),),
//               ),
//                  SizedBox(
//                     height: 30,
//                   ),
//               //introduction text
//                Align(
//                 alignment: Alignment.topLeft,
//                  // Align however you like (i.e .centerRight, centerLeft)
//                 child: Text("   Hi Shams, Here is your Loan Status .",textAlign: TextAlign.end,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
//               ),
//               //sizebox
            
//                   SizedBox(
//                     height: 10,
//                   ),
//               //intro senrtences
//               Align(
//                 alignment: Alignment.topLeft, // Align however you like (i.e .centerRight, centerLeft)
//                 child: Text("   ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w900)),
//               ),

//               //lists

//           SizedBox(
//             height: 500, // set the height of the ListView
//             child: ListView.builder(
//               itemCount: items.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return  GestureDetector(
//                   onTap: () {
//                     print("gester");
//                   },
//                   child: Card(
//                    color: Colors.white,
//                   margin: EdgeInsets.all(10),
//                    child:  SizedBox(
//                     height: 130,
//                     child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
                       
//                        SizedBox(
//                         width: 20,
//                        ),
                          
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                            Padding(
//                          padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
//                             child:     Text(
//                               "Loan Given",style: TextStyle(fontSize: 25 ,color: Colors.blue),
//                             ),
                            
//                       ),
//                       // 2nd row for the 
//                         Row(
//                           mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                           children: [
//                            Icon(
//                     Icons.circle_rounded, // set the icon to the heart icon
//                     size: 12.0, // set the size of the icon to 32.0 pixels
//                     color: Colors.blue, // set the color of the icon to red
//                   ),

//                               TextButton(
//                   onPressed: () {
//                     // add your onPressed logic here
//                     print("hello from dash");
//                   },
//                   child: Text(
//                     'Pending',
//                     style: TextStyle(fontSize: 18.0),
//                                       ),
//                     ),
//                           ],
//                         )
//                         ],
//                       )
//                       ,
//                        SizedBox(
//                         width: 20,
//                        ),
                      
//                         Padding(
//                         padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
//                             child:     Text(
//                               "ab33@gmail.com",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400),
//                             ),
//                       ),
//                        SizedBox(
//                         width: 20,
//                        ),
                        
//                         Row(
//                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                           children: [
//                              Padding(
//                       padding: const EdgeInsets.fromLTRB(12, 8, 0, 8),
//                             child:     Text(
//                               "\$500",style: TextStyle(fontSize: 20),
//                             ),
//                       ),
//                                                   TextButton(
//                               onPressed: () {
//                                 // add your onPressed logic here
//                               },
//                               child: Text(
//                                 'View More',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.blue, // set the color of the text to blue
//                                   decoration: TextDecoration.underline, // underline the text
//                                 ),
//                               ),
//                             )

                           
//                           ],
//                         )
//                     ],
//                    ),
//                    )
//                 ),
//                 );
//               },
//             ),
//           ),
        
      
          
    

//             ],
//           ),
//          ),
//     );
  }
}