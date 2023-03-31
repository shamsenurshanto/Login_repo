import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/AddTransactions.dart';
import 'package:my_app/UserDetails.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/dashBoard2.dart';
import 'models/team.dart';
import 'package:flutter/material.dart';

class addTrans extends StatefulWidget {
  const addTrans({super.key});

  @override
  State<addTrans> createState() => _addTransState();
}
final _textController_For_EmailSearch = TextEditingController();
final _textController_For_amount = TextEditingController();
String userEmail="";
String _amount ="";
String _dropDowntype=" ";
String amountOfReal ="0";



class _addTransState extends State<addTrans> {

    bool _isLoading=false;
    String selectedOption = 'Loan Type';
    String _dropDownValue="Select The Loan Type";
    String recv_id =" ";
    String  send_id = " ";
    String TextFormEmail = " ";
    String Sender_mail=" ";
    String receiver_mail = "";
    
  getUser() async {
   
     var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
  
   print("https://smoggy-toad-fedora.cyclic.app/api/user/searchuser/${_textController_For_EmailSearch.text}");
    

     var response = await http.post(Uri.https('smoggy-toad-fedora.cyclic.app', 'api/user/getuser'), body: {
      'userEmailPhone': _textController_For_EmailSearch.text,
      'userPass': '12345678'
      
      }, );
    //  jsonData = jsonDecode(response.body);
    // print(jsonData);
    var resp = json.decode(response.body);
    TextFormEmail = resp["data"]["_id"];
    print(resp["data"]["_id"]);
    if (response.statusCode != 200) {
      // data = "Oye !! Thare pass Internet naahi hn !!";
    }
    print(response.body);
    setState(() {
      // data = resp['slip']['advice'];
      _isLoading = false;
    });
  }

     postTrans() async{
 
          // amountOfReal = double.parse(_textController_For_amount.text);
          print(amountOfReal.runtimeType);
     var box = await Hive.openBox("mybox");
     final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
     var _idgh = _box2.get("User_id");
          var email= _box2.get("User_email");//here it gets user id ;
              //  var _idgh = _box2.get("User_id");
      String LoanVal =" ";
      print("--------------------");
      print(gh);

   print("https://smoggy-toad-fedora.cyclic.app/api/transaction/createtransaction");
    
         if(_dropDownValue=="Loan Given")
         {

              LoanVal = "63efbef607ca4144957e03ef";
                send_id=_idgh;
                recv_id =TextFormEmail;
                Sender_mail = email;
                receiver_mail = _textController_For_EmailSearch.text;
              //(resp["data"]["_id"]
                  // String recv_id =" ";
    // String  send_id = " ";
    

    print(send_id);
    print(recv_id);
    print(email);
    print(_textController_For_EmailSearch.text);


         }
         else if(_dropDownValue=="Loan Taken")
         {

                  LoanVal = "63efbf6207ca4144957e03f1";
                    send_id=TextFormEmail;
                recv_id =_idgh;
                Sender_mail = _textController_For_EmailSearch.text;
                receiver_mail = email;
                print(send_id);
    print(recv_id);
    print(email);
    print(_textController_For_EmailSearch.text);


          }
    var map = new Map<String, dynamic>();
map['type'] = '63efbef607ca4144957e03ef';
map['amount'] = 650;
map['sender'] =  {
                    "senderEmailPhone":"ab66@gmail.com",
                    "senderId":""
                };
map['senderStatus'] = "SENT";
map['receiver'] =  {
                    "receiverEmailPhone":"",
                    "receiverId":"63fc3d77847d6e54d113a686"
                };
map['receiverStatus'] = 'ACKNOWLEDGED';

    
      final response = await http.post(
    Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/transaction/createtransaction"),
    headers: {
      
       'Content-Type': 'application/json; charset=UTF-8',
      
      'Cookie': 'jwt_token=$gh'},
    body:         
      jsonEncode(


          { 
                "type":LoanVal,
                "amount":double.parse(_amount),
                "sender":
                {
                    "senderEmailPhone":Sender_mail,
                    "senderId":send_id
                },
                "senderStatus":"SENT",
                "receiver":
                {
                    "receiverEmailPhone":receiver_mail,
                    "receiverId":recv_id
                },
                "receiverStatus":"ACKNOWLEDGED"
                
                }
      )


              
    

    
    
    
    ,
  );

       print(response.body);



          


     }



  @override
  void initState() {
    _isLoading = false;
    getUser();
      setState(() {
       
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
     List<String> _items = <String>["Loan Taken","Loan Given"];

    return Scaffold(
      
       
       appBar: AppBar(title: Text("Add a Transaction"),centerTitle: true,),
       
       body: 
       
       Container(

         padding: EdgeInsets.all(30.0),
         
         child: ListView(


             children: [
              SizedBox(
             height: 100,
              ),
              TextField(
                controller: _textController_For_EmailSearch,
                decoration: InputDecoration(
                  
                  labelText: "Find The Valid User ",
                  prefixIcon: Icon(Icons.verified_user_outlined),
                  border: OutlineInputBorder(

                  )
                ),
              ),
              SizedBox(
             height: 10,
              ),
              Container(
                 
                 margin: const EdgeInsets.only(top: 20.0),
                child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size.fromHeight(55),
                  
                  
                ),
           
            child:  _isLoading
                              ? const CircularProgressIndicator(color: Colors.white,)
                             
                              : Text(
                                 "Search User",
                                  textAlign: TextAlign.center,
                                ),



              onPressed: () {
                          setState(() {
                            _isLoading = true;
                          
                          });
                          print(_textController_For_EmailSearch.text.runtimeType);
                          if(_textController_For_EmailSearch.text!=null)
                          getUser();
                          else
                          return;
                        },
                   
          ),
          

              ),
                 
                Container(
                  
                   margin: const EdgeInsets.all(20.0),
                  child: DropdownButton(
      hint: _dropDownValue == null
          ? Text('Dropdown')
          : Text(
              _dropDownValue,
              style: TextStyle(color: Colors.blue),
            ),
      isExpanded: true,
      iconSize: 30.0,
      style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight:FontWeight.bold),
      items: ['Select The Loan Type', 'Loan Given', 'Loan Taken'].map(
        (val) {
          return DropdownMenuItem<String>(
            value: val,
            child: Text(val),
          );
        },
      ).toList(),
      onChanged: (val) {
        setState(
          () {
            _dropDownValue = val!;
            print(_dropDownValue);
          },
        );
      },
    ),
    
    
    ),
     SizedBox(
             height: 3,
              ),
       TextField(
        controller: _textController_For_amount,
                decoration: InputDecoration(
                  labelText: "Enter the Amount",
                  prefixIcon: Icon(Icons.money),
                  border: OutlineInputBorder(

                  )
                ),
              ),
                  SizedBox(
             height: 20,
              ),
                 ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  minimumSize: Size.fromHeight(55),
                  
                  
                ),
           
            child: Text("Add Transaction"),



              onPressed: () {

                _amount = _textController_For_amount.text;
                         print(_amount);
                            userEmail = _textController_For_EmailSearch.text;
                         print(userEmail);
                         print(_dropDownValue);

                         postTrans();


                             

                           Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return dash2();
                    // return userDetails("email");
                  },
                ),
              );


                      
                        },
                   
          ),

          ElevatedButton(  onPressed: () => showTopSnackBar(context), child: Text("click "))
                 
             ],
         ),
       ),




    );
  }
  }


 void showTopSnackBar(BuildContext context) =>
  Container(
    child:  Center(
    child: 
    
      Flushbar(
      
          icon: Icon(Icons.error, size: 32, color: Colors.white),
          shouldIconPulse: false,
          title: 'Transaction has been added',
          message: 'Transaction has been added to the list ',
           
          onTap: (_) {
            print('Clicked bar');
          },
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.BOTTOM,
          margin: EdgeInsets.fromLTRB(8, kToolbarHeight + 10, 18, 0),
          borderRadius: 16,
        )..show(context)
    ,
   ),
  );
