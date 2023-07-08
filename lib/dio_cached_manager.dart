import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';

class dio_cached_manager extends StatefulWidget {
  const dio_cached_manager({super.key});

  @override
  State<dio_cached_manager> createState() => _dio_cached_managerState();
}

var mydata = "";
var isLoading=0;

class _dio_cached_managerState extends State<dio_cached_manager> {
  @override
  Widget build(BuildContext context) {
    DioCacheManager _dioCacherManager;
    Future<void> funcApi() async {
      _dioCacherManager = DioCacheManager(CacheConfig());
      Options _cacheOption =
          buildCacheOptions(Duration(minutes: 1), forceRefresh: true);
      Dio dio = Dio();
      dio.interceptors.add(_dioCacherManager.interceptor);
      Response response = await dio.get(
          "https://jsonplaceholder.typicode.com/posts",
          options: _cacheOption);

      setState(() {
        mydata = response.data.toString();
      });
      // print(mydata);

      ;
    }

    funcApi();
    return Scaffold(
        body: SafeArea(
      child:  Column(
        children: [
          Center(
        child: Container(
        width: 300,
          child: Row(
        children: [
          
         
         SizedBox(
          width: 100,
          child:  ElevatedButton(onPressed: () {

            setState(() {
              isLoading=1;
            });
          }, child: Text("On")),
         ),
         SizedBox(
         
          width: 130,
          child:  ElevatedButton(onPressed: () {
            setState(() {
              isLoading=0;
            });
          }, child: Text("Off")),
         )
          
          ],
      )
      ),
      ),
      isLoading==1?
         SizedBox(
           height: 300,
          child: Text(mydata),
         ):
         SizedBox()
        ],
      )
    ));
  }
}
