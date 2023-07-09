import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readmore/readmore.dart';

import 'constant.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}
  var _data = null;
   var jsonData;

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState() {
    super.initState();
    fetchData();

  }
   var apiName = "api.lenden.cloud";

  Future<void> fetchData() async {
    var box = await Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    var gh = _box2.get("toki");
    var response;
    // var jsonData;
     var jsonData2 ;
try {
    Dio dio = Dio();
       DioCacheManager _dioCacherManager;
     _dioCacherManager = DioCacheManager(CacheConfig());
      Options _cacheOption =
          buildCacheOptions(Duration(minutes: 15), forceRefresh: true);
  
      dio.interceptors.add(_dioCacherManager.interceptor);
  dio.options.headers["Cookie"] = 'jwt_token=$gh';
   response = await dio.get(
    'https://$apiName/api/user/notifications',
    options:_cacheOption
    
    
  );

  print(response.data.runtimeType);
jsonData = jsonEncode(response.data);
    print("here is json");
     jsonData2 = jsonDecode(jsonData);
    print(jsonData2['data'][0].length);
      print(jsonData2['data'][0]['notifications'][0]);
    print(jsonData2['data'][0]['notifications'][0]['body']);//notification pages data
} catch (e) {
  print('Error: $e');
}
    setState(() {
     jsonData = jsonData2;
     print("json print hocce");
     print(jsonData['data'][0]['notifications']);
     _data=jsonData;
    
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
      body: _data==null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _data['data'][0]['notifications'].length,
              itemBuilder: (context, index) {
                                  String myText =  _data['data'][0]['notifications'][index]['body']; // changing the string text style 
                  TextStyle myStyle = TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  );

                return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 600,
                       
                    
                                  child:  Padding(padding: EdgeInsets.all(0),
                                  
                                  
                                   child: Card(
                                      
                                      shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                           ),
                  elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 1),

                          child: 
                  // title: Text(_data[index]['title']),
                 /**ExpansionTile(
   leading: Icon(Icons.add_circle_outline)
  children: <Widget>[
    Text('Child 1'),
    Text('Child 2'),
  ],
)
 */
                  //Text(_data[index]['body']),
                           Padding(padding: EdgeInsets.all(15),
                           
                            child:    ReadMoreText(myText+"     "
           ,
              trimLines: 2,
              colorClickableText: Colors.pink,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: "show less",
              moreStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue),
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
