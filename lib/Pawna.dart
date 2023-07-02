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

class UserDetails_New_pawna extends StatefulWidget {
  //  Team teams;
  //  String namee="";
  

  UserDetails_New_pawna();

  @override
  _UserDetails_New_pawnaState createState() => _UserDetails_New_pawnaState();
}

class _UserDetails_New_pawnaState extends State<UserDetails_New_pawna> {

 ///function for bangla 
   String valAmount = "";
    var loanStaus = "";
    var amoutUser=0;
    var loanTopay =0;
     List<dynamic> items = [];

     var Lang_val ="English";
     var amountOfUser="";

    var box =  Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
  // _box2.put("valu_sum", 0);
  // amountOfUser = _box2.get("valu_sum").to;
    // _idLoggedIn= _box2.get("User_id");//my user id 
    //        email= _box2.get("User_email");
    //        name= _box2.get("User_name");







  var arr =["০","১","২","৩","৪","৫","৬","৭","৮","৯"];
  //kkk ollo 
   printAndReturnString(String inputString) {

  for (var i = 0; i < inputString.length; i++) {
 
  
   setState(() {
     lan_status="Bangla";
    //  //print("hhhhhhhhhhhhhhhhhhhhhhllllllllllllllllll");
    //  //print(inputString);
    valAmount+=arr[int.parse(inputString[i])];
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
  var lan_status ="English" ;
  var loan_status = "";
    var arrayForLoanEng =["Sender: ","Receiver : ",];
  var arrayForLoanBangla =["প্রেরক :","প্রাপক : ",];
 var jsonData2 ;

 late final Future myFuture;

   void initState()  {

   
    super.initState();

   myFuture = getTeams();

                 
     var box =  Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
              


             
    
     


    // _idLoggedIn= _box2.get("User_id");//my user id 

    // _idLoggedIn= _box2.get("User_id");//my user id 
    //        email= _box2.get("User_email");
           lan_status= _box2.get("Lang_val");
        
    //        Lang_val
    print(lan_status);
    print("giiiiiiiiiiiiiiiiga");

   
     

           lan_status= _box2.get("Lang_val");
          
  }

  

   List<Team> teams2 = [];
   //https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions
  // get teams

   int trackerLoancount=0;
    void apicall(int x,int length)
    {
      // print("apiii");
      if(trackerLoancount<length)
      setState(() {
        loanTopay += x;
      
        trackerLoancount++;
      });
    }


    String getString(String number){
      amountOfUser="";
         for (var i = 0; i < number.length; i++) {
 
  
  
    //  //print("hhhhhhhhhhhhhhhhhhhhhhllllllllllllllllll");
    //  //print(inputString);
     amountOfUser+=arr[int.parse(number[i])];
     

        

   
    print("vaaaaaaaaaaaaaalaaaaaaaaaaaaaaaaaaaaaaaaaa");
    // print(valAmount);

  }
    return amountOfUser;
   }

  Future getTeams() async {
      
      //print("get teaaaaaaaaaaaaaaaaaaaaaaaaamsssss");

     
  var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
   var _idLoggedIn= _box2.get("User_id");//my user id 
          var email= _box2.get("User_email");
  

               //hive initialization and get data
              
         
         //print("apii te +++++++++++++++++++++++");
         var gh = _box2.get("tokens");
   
    //print(gh.runtimeType);

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
    // //print();
     tokenString2+=String.fromCharCode(rune);
       
    }
  }
  
  
    var apiName = "personalrec.onrender.com";

    //ab33@gmail.com

  //print("token api ---------- ::::::::::::::::::::");
  final _box = Hive.box("mybox");
  _box.put("toki", tokenString2);

     


//print(tokenString2);
   //print(tokenString2.runtimeType);

    var response = await http.get(Uri.https(apiName, 'api/user/loansummary'),
     headers: {'Cookie': 'jwt_token=$tokenString2'}
     
     );
    var jsonData = jsonDecode(response.body);
     print("response body ---------- ::::::::::::::::::::");
    print(response.body);

  
    print(jsonData['data'][0]['total_sent']);
  teams2.clear();
    for (var eachTeam in jsonData['data'])
     {

      // loooooppppo lol 
      // //print(eachTeam['sender']['senderId']);
      String mainMail2="";
       String mainName="";
       print("------------ edhaaaaaa");
       print(jsonData['data'].length);

       print(eachTeam['total_received']);
     
     
        //  //print(eachTeam['type']['en_typeName']);
         final team;


      team = Team(

      
       amount: (eachTeam['total_sent']-eachTeam['total_received']).abs(),
         name: eachTeam['userName'].toString(),


           id: "",
        sender_email: "",
        receiver_email: "",
        type: "Loan Taken",

         mainMail:"eachTeam['sender']['senderId']['_id'].toString()",
     
       
         Transaction_status: "eachTeam['transactionStatus']",
         Transaction_id: " eachTeam['_id'].toString()",
          Sender_status:  "eachTeam['senderStatus']",  
                  Receiver_status:  "eachTeam['receiverStatus']",
                   img_link: eachTeam['receiver']['receiverId']['userPic'].toString(),
              dateOfTransactions:  eachTeam['receiver']['receiverId']['createdAt'].toString(),          
                  
          //  img_link: eachTeam['userPic']
        
        
      );
      print("this is for id");
      print(team.id);
       apicall((eachTeam['total_received']-eachTeam['total_sent']).abs(),jsonData['data'].length);
       
   


     teams2.add(team);
      
    
    }
     //print("---------------------------------------");
    //print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    var height_safearea = MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top;
              var width_safearea = MediaQuery.of(context).size.
              width ;
                int _counter = 0;

  void _incrementCounter(int amount) {
    
       var box =  Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
  _counter+=amount;
    // _idLoggedIn= _box2.get("User_id");//my user id 
    //        email= _box2.get("User_email");
    //        name= _box2.get("User_name");
     _box2.put("valu_sum", _counter.toString());
   
  }
            
      
     String getString(String number){
      amountOfUser="";
         for (var i = 0; i < number.length; i++) {
 
  
  
    //  //print("hhhhhhhhhhhhhhhhhhhhhhllllllllllllllllll");
    //  //print(inputString);
     amountOfUser+=arr[int.parse(number[i])];
     

        

   
    print("vaaaaaaaaaaaaaalaaaaaaaaaaaaaaaaaaaaaaaaaa");
    // print(valAmount);

  }
    return amountOfUser;
   }
      

    return Scaffold(
      
      appBar: AppBar(
        
        
        title: Text("Received",style: TextStyle(color: Colors.black),
        
        ),
      elevation: 4,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
    color: Colors.black,
      ),
      ),
      // backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: FutureBuilder(
          future: myFuture,
          builder: (context, snapshot) {

                     
            if (snapshot.connectionState == ConnectionState.done) {
              //print("done");
              
              return Scaffold(
                body: Column(
                      children: [
                        //transaction type
                         SizedBox(
                          height: height_safearea*0.23,
                          child:  Card(
                            shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                            color: Colors.grey.shade200,
                          margin: EdgeInsets.all(15),
                            elevation: 22,
                            
                            child: Row(
                              children: [
                                //colum1 icon
                                Column(
                                  children: [
                                      GestureDetector(
                                        
      onTap: () {
        // Handle onTap event
        //print("hello settings");
      },
      onLongPress: () {
        // Handle onLongPress event
      },
      child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
           child: 
      Icon(FontAwesomeIcons.gear,color: Colors.green.shade500 ,),)
    )
                                  ],
                                ),

                                SizedBox(
                                  width: width_safearea * 0.205,
                                )

                                //sizebox width

                                //column2 
                                //text1 
                                //text2
                                //text3
                          ,
                                Container(
                                  
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                      lan_status=="English"?Padding(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                        child:  Text(
                                  "Total Received Amounts",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                     
                                    ),
                                  ),

                                      ):Padding(
                                        padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                                        child:  Text(
                                  "মোট গ্রহণ করা হয়েছে",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                     
                                    ),
                                  ),

                                      ),




                                      Padding(
                                        padding:EdgeInsets.fromLTRB(0, 1, 0, 1),
                                        child: lan_status=="English"? Text(
                                    '\$'+loanTopay.toString(),
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(8, 139, 4, 1)
                                      // fontStyle: FontStyle.italic,
                                     
                                    ),
                                  ):Text(
                                     '\৳'+getString(loanTopay.toString()),
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(8, 139, 4, 1)
                                      // fontStyle: FontStyle.italic,
                                     
                                    ),
                                  ),

                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 2, 0, 1),
                                        child: Text(
                                    "shams",
                                    style: TextStyle(
                                       fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                     
                                    ),
                                  ),

    ),
  ],
                                ),
                                )

                                //colum3 extra
                              ],
                            )
                          ),
                          
                         )

                         ,
                          Column(
                            children: [
                               Row(
                            
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          SizedBox(
                            
                        
                        child: Padding(padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                        child: Text(
                          "TRANSACTIONS",style:  TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey),
                        ),)
                       )
                      ],
                     ),
                       Padding(
                        padding: 
                       EdgeInsets.all(1),
                           
                       
                       )
                            ],
                          ),
                       ///transaction starts 
                       ///
                       ///
                       ///
                       ///,conta
                     Container(
                      width: 350,
                      height: 380,
                      child: ListView.builder(
                      itemCount: teams2.length,
                      itemBuilder: (BuildContext context, int index) {
                      
                          //  _incrementCounter(teams2[index].amount);
                     
   

  
            //expanded 
                      return Container(
                              width: 200,
                                child: Card(
                              ///rkjs2
                              ///
                              elevation: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ///colum1 icon
                                  SizedBox(
                                    //width: 20,
                                    child: IconButton(
                                      icon: Icon(
                                        FontAwesomeIcons.circleMinus,
                                        color: Colors.grey.shade300,
                                      ),
                                      onPressed: () {
                                        // Do something when the icon is pressed
                                        print("hello add");
                                      },
                                    ),
                                  )

                                  ///sizebox width
                                  ///
                                  //    ,
                                  // SizedBox(
                                  //   width: 70,
                                  // )
                                  ,

                                  ///colum2
                                  //////Loan status
                                  ///amount
                                  ///
                                  ///rkjs2
                                  SizedBox(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      lan_status == "English"
                                          ? Text(
                                              teams2[index].name.toString(),

                                              style: GoogleFonts.mina(
                                                fontSize:
                                                    width_safearea * 0.03820408,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      offset:
                                                          const Offset(7, 7),
                                                      blurRadius: 15),
                                                ],
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,

                                              //
                                            )
                                          :

                                          //bng start
                                          Text(
                                              teams2[index].name.toString(),
                                              style: GoogleFonts.mina(
                                                fontSize:
                                                    width_safearea * 0.03820408,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black
                                                          .withOpacity(0.3),
                                                      offset:
                                                          const Offset(7, 7),
                                                      blurRadius: 15),
                                                ],
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,

                                              //
                                            ),
                                    ],
                                  )),

                                  SizedBox(
                                    width: 60,
                                    child: lan_status == "English"
                                        ? Text("\$" +
                                            teams2[index].amount.toString())
                                        : Text("৳" +
                                            getString(teams2[index]
                                                .amount
                                                .toString())),
                                  )

                                  ///
                                  ///
                                  ///
                                  ///colum3
                                  ///date
                                ],
                              ),
                            )
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
                   
                  child:Container(
                    width:  width_safearea,
                    height: height_safearea,
                  color: Colors.white,
                  child:  
                 Center(
                  child:  Container(
                    width: width_safearea * 0.076530612,
                    height: height_safearea * 0.04,
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