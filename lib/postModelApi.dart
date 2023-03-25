import 'package:http/http.dart' as http;
import 'package:my_app/models/post_model.dart';


var base = "https://dummyjson.com/products";


getPost2()async {
  Uri url = Uri.parse(base);

  var res = await http.get(url);

  try{
 if(res.statusCode==200)
  {
    var data = res.body;
   print(data);
          
    
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
