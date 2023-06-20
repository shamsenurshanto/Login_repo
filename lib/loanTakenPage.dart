import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readmore/readmore.dart';

class LoanTakenPages extends StatefulWidget {
  const LoanTakenPages({super.key});

  @override
  State<LoanTakenPages> createState() => _LoanTakenPagesState();
}

class _LoanTakenPagesState extends State<LoanTakenPages> {
  @override
  var _data;
   var jsonData;
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  String convertDateFormat(String date) {
  DateTime parsedDate = DateTime.parse(date);
  print(parsedDate);
  String formattedDate = "${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}";
  if(date=="null"){
    formattedDate="23-03-2023";
  }
  return formattedDate;
}

  Future<void> fetchData() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
   var response = await http.get(
      Uri.https('personalrec.onrender.com', 'api/user/loansummary'),
      headers: {'Cookie': 'jwt_token=$gh'},
    );
    // print(response.body);
    jsonData = jsonDecode(response.body);
   
    print(jsonData['data']);
    setState(() {
      _data = json.decode(response.body);
       print("----------------------");
      print(_data['data'][0]['id']);
    });
    // print(jsonData['data'][0]['notifications'][0]);
    // print(jsonData['data'][0]['notifications'][0]['body']);//notification pages data
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       appBar: AppBar(title: Text("Loan Payments Dates",style: TextStyle(color: Colors.black),),
      elevation: 2,
      backgroundColor: Colors.white,
      
      automaticallyImplyLeading: false,
      
        
      ),
      body: _data == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _data['data'].length,
              itemBuilder: (context, index) {
                var datein=_data['data'][index]['nearest_returnDate'].toString();
                
              
                

               var dates2 = "";
                                 // String myText =  jsonData['data'][0]['notifications'][index]['body']; // changing the string text style 
                  TextStyle myStyle = TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  );
                  datein=="null"?dates2="Not mentioned": dates2 =convertDateFormat( datein );

                return   
               Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding(
                      padding: 
                  EdgeInsets.all(12),
                  child:  Text(
                      dates2,style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w300
                      ),
                      
                       
                      ),
                  ),
                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                            
                
                      Container(
                        width: 330,
                        child: 
                         Card(
                          child:   Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            
                          children: [
                              Padding(
                              padding: EdgeInsets.fromLTRB(10, 2, 0, 9),
                              child: Container(
                                width: 140 / 4 + 12,
                                height: 140 / 4 + 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color.fromARGB(255, 101, 101, 230),
                                      width: 2.4+1),
                                ),
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(
                                    "https://personalrecordback-production.up.railway.app/amendmentDoc/" +
                                         _data['data'][index]['userPic'],
                                  ),
                                ),
                              ),
                            ),

                               Container(
                              width: 70,
                              child: 
                                 Text(
                             _data['data'][index]['userName'],
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 43, 54, 80),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ),
                             

                             Container(
                              width: 100,
                              child: 
                                  Column(
                                    children: [
                                           Text(
                            "Total Received ",
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 38, 206, 22),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                                       Text(
                             _data['data'][index]['total_received'].toString(),
                              style: GoogleFonts.lato(
                                color: Color.fromARGB(255, 43, 54, 80),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                                    ],
                                  )
                            )
                          ],
                        ),
                         )
                        ,
                      )
                      
                    

                    ],
                  )
                ],
               )
                
                ;
               
              },
            ),
    );
  }
}