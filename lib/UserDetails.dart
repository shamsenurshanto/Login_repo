import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'models/team.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class userDetails extends StatelessWidget {
  List<Team> teams = [];
       
           
  String id ;
      
          var jsonData ;
   String tokenString2="";

   userDetails(this.id);
   
   
  Future getTeams2()async {

    print(id);

  var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
     print("Useeeeeeeeeeeeeeer detaaaaails --------------------------------------");
     print(gh);
     print(id);
             var response = await http.get(Uri.https('https://personalrec.onrender.com', 'api/transaction/getsumofusers/${id}'), headers: {'Cookie': 'jwt_token=$gh'});
     jsonData = jsonDecode(response.body);
    print(jsonData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  
       Container(
       
        // margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
        //  color: Colors.deepPurple,
    
            decoration: BoxDecoration(
              color: Colors.deepPurple,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(0.0)),
      ),

        child: 
        
        Padding(
        
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        
      
      
              child:  GNav(
  
  // selected tab background color
  // navigation bar padding

  backgroundColor: Colors.deepPurple.withOpacity(0.88),
  color: Colors.white,
  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  activeColor: Colors.deepPurple,
  tabBackgroundColor: Colors.white,
  gap: 8,
  tabs: [
    GButton(
      icon: Icons.home,
      text: 'Home',
      onPressed: (){
        print("hello");
      },
    ),
    GButton(
      icon: Icons.baby_changing_station_outlined,
      text: 'Likes',
    ),
    GButton(
      icon: Icons.search,
      text: 'Search',
    ),
    GButton(
      icon: Icons.add,
      text: 'Profile',
    )
  ]
),
         
            
          ),
      
       )
       ,
       appBar: AppBar(title: Text("Transaction Summary",
       style: TextStyle(fontSize: 15),)),
      body: SafeArea(
        child: FutureBuilder(
            future: getTeams2(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Card(
                  child: ListView.builder(
                  itemCount: 1,
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                     
                       Container(
                          
                           margin: EdgeInsets.fromLTRB(30.0, 90.0, 30.0, 30.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 300,
                        height: 100,
                        child: 

                  Center(
                    
                      child: Container(
                        child: Text("All the Transaction",
                        
                        style: GoogleFonts.hammersmithOne(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: Colors.blueGrey),

                        ),
                        
                        
                      ),

                  )

                      ),
                    );
                  },
                )
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}