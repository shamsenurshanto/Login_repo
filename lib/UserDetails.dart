import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'models/team.dart';
class userDetails extends StatelessWidget {
  List<Team> teams = [];
       
           
  String id ;
      
          var jsonData ;
   String tokenString2="";

   userDetails(this.id);
   
  Future getTeams2()async {

  var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
     print("Useeeeeeeeeeeeeeer detaaaaails");
     print(gh);
     print(id);
             var response = await http.get(Uri.https('smoggy-toad-fedora.cyclic.app', 'api/transaction/getsumofusers/${id}'), headers: {'Cookie': 'jwt_token=$gh'});
     jsonData = jsonDecode(response.body);
    print(jsonData);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          onTap: () {
                            print("hello  on page off user details");
          
              
                          },
                          title: Text(""),
                          subtitle: Text(""),
                          trailing: Text("\$${jsonData['data']['userBSent'].toString()}",
                          
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
            }),
      ),
    );
  }
}