import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/PostLoanModelApi.dart';
import 'package:my_app/Tokener.dart';
import 'package:my_app/models/post_model.dart';


var base = "https://dummyjson.com/products";

// final _box2 = Hive.box("mybox");
getPost()async {

  final _box2 = Hive.box("mybox");

  Uri url = Uri.parse(base);
  Uri url2 = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions");

  // var res = await http.get(url);
  // var res2 = await http.get(url2);
    
         
         print("apii te ?????????????????????????????????//////////////////////////////////////// ");
         var gh = _box2.get("tokens");
  //  gh = json.decode(gh);
    print(gh.runtimeType);

  String token = "";

   String cookie = gh;
 
 
  String str = gh,ghh,tokenString2="";
  int flag=0;
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
  
  print(tokenString2);
   print(tokenString2.runtimeType);


    //ab33@gmail.com
     _box2.put("tokenString2", tokenString2);

  print("token api ----------");

  String tokenString = gh.toString();
    final protectedResponse = await http.get(
    Uri.parse('https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions'),
    headers: {'Cookie': 'jwt_token=$tokenString2'},
  );
 
    // print('Token : ${gh.jwt_token}');
     String data = protectedResponse.body;
    print(json.decode(data));

  //    List<dynamic> transactions = json.decode(protectedResponse.body);
  //   // print(jsonDecode(protectedResponse.body));
  // for (var transaction in transactions) {
  //   int amount = transaction['amount'];
  //   print(amount);
  // }

  try{
 if(protectedResponse.statusCode==200)
  {
    var data = postLoanApiFromJson(protectedResponse.body);
    // var data2 = protectedResponse.body;
   print("api services --------------------");
    print(data.data);
  //  return data.products;
          
    
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
