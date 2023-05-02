import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readmore/readmore.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  var _data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    setState(() {
      _data = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: Text("Notification",style: TextStyle(color: Colors.black),),
      elevation: 4,
      backgroundColor: Colors.white,
      
      automaticallyImplyLeading: false,
      
        
      ),
      body: _data == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _data.length,
              itemBuilder: (context, index) {
                return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        width: 600,
                       
                    
                                  child:  Padding(padding: EdgeInsets.all(0),
                                  
                                  
                                   child: Card(
                                      
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                           ),
                  elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),

                          child: 
                  // title: Text(_data[index]['title']),
                 
                  //Text(_data[index]['body']),
                           Padding(padding: EdgeInsets.all(15),
                           
                            child:    ReadMoreText(
              _data[index]['body'],
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: 'Back',
              moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
            ),
                           )
              
                        ),
                                  )
                      )
                    ],
                  );
               
              },
            ),
    );
  }
}
