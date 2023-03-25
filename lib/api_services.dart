import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/Tokener.dart';
import 'package:my_app/models/post_model.dart';


var base = "https://dummyjson.com/products";


getPost()async {
  Uri url = Uri.parse(base);
  Uri url2 = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions");

  var res = await http.get(url);
  var res2 = await http.get(url2);
    final _box2 = Hive.box("mybox");
         
         print("apii te +++++++++++++++++++++++");
         var gh = _box2.get("tokens");
  //      Map<String, dynamic> cookieMap = await json.decode(gh.split('=')[1]);
  // String jwtToken = cookieMap['jwt_token'];
  // print(jwtToken);
    print(gh);

  String token = "";

   String cookie = gh;
  
  List<String> cookies = cookie.split(','); // split the cookie string by comma
  String jwtToken=""; // initialize the jwtToken variable
 
 
  String str = gh,ghh;
  
  for (int rune in str.runes) {
    if(String.fromCharCode(rune)=='=')
    {
       
    }
    print(String.fromCharCode(rune));
  }
  
  print(jwtToken);




  print("token api ----------");

  String tokenString = gh.toString();
    final protectedResponse = await http.get(
    Uri.parse('https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions'),
    headers: {'Cookie': 'jwt_token=${gh}'},
  );
 
    print('Token : ${gh.jwt_token}');
    print(protectedResponse);

  try{
 if(res.statusCode==200)
  {
    var data = postModelFromJson(res.body);
    var data2 = res2.body;
    print(data2);
   return data.products;
          
    
  }

  else
  {
    print("errpor hoise");
  }

  }
  catch(e)
  {
      print(e.toString());
  }

 

}
