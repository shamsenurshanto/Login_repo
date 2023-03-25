import 'package:http/http.dart' as http;
import 'package:my_app/models/post_model.dart';


var base = "https://dummyjson.com/products";


getPost()async {
  Uri url = Uri.parse(base);
  Uri url2 = Uri.parse("https://smoggy-toad-fedora.cyclic.app/api/transaction/usersalltransactions");

  var res = await http.get(url);
  var res2 = await http.get(url2);

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
