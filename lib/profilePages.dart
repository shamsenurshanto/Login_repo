import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Screens/Login/login_screen.dart';
import 'package:my_app/homegrid2.dart';
import 'package:my_app/newTbb.dart';
import 'package:my_app/tbb.dart';
import 'package:http/http.dart' as http;

import 'dart:io';


import 'homeGrid.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var picLink ='https://i.ytimg.com/vi/x77Ijv0kCJc/maxresdefault.jpg';
  var _idLoggedIn;
  var email;
  var name;
  var apiName = 'personalrec.onrender.com';
  String _selectedLanguage = 'English';
  var name_;
   Future<void> setProfilePic() async
  {

        var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
     var email_Logged_user =_box2.get("User_email");
     var response = await http.post(Uri.https(apiName, 'api/user/getuser'),
 
    headers: {      
      //  'Content-Type': 'application/json; charset=UTF-8',      
      'Cookie': 'jwt_token=$gh'
      }, 
  body: {
      'userEmailPhone': email_Logged_user  
      },      
       );
   var  jsonData = jsonDecode(response.body);
   print("iiiiiiiiidddddddddddddddddddddddd");
    print(jsonData['data']['userPic']);
    setState(() {
         picLink=apiName+"/amendmentDoc/"+jsonData['data']['userPic'].toString();
       });

     print(response.body);
  }
  void initState() {
    super.initState();
    var box = Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    _idLoggedIn = _box2.get("User_id"); //my user id
    email = _box2.get("User_email");
    name = _box2.get("User_name");
    setProfilePic();

    //put
    //  _box2.put("User_id",jh['data']['_id'] );
    // _box2.put("User_email",username );
    //     _box2.put("User_id",jh['data']['_id'] );
    // _box2.put("User_name2",jh['data']['userName'] );
    _box2.put("Lang_val", _selectedLanguage);
          /**
           * added the profic 
           */
    print("gofun");
    print(name);
    //name
    name_ = _box2.get("User_name2");
    print("ooooooooooooooooooooooooooooooooooo");
    print(name_);
    
    
  }

 Future<void> GoFunction() async {
  final picker = ImagePicker();
  PickedFile? pickedImage;

  try {
    pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // Convert PickedFile to File
      File imageFile = File(pickedImage.path);

      // Use the imageFile for further processing or upload
      // ...
      if (imageFile != null) {
          var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
     var gh = _box2.get("toki");
     var email_Logged_user =_box2.get("User_email"); //User_email
  var request = http.MultipartRequest('POST', 
  Uri.parse(apiName.toString()+'/api/user/profile',
  
  ));
    request.headers['Content-Type'] = 'multipart/form-data';
    request.headers['Cookie']='jwt_token=$gh';

  request.files.add(http.MultipartFile(
    'image',
    imageFile!.readAsBytes().asStream(),
    imageFile!.lengthSync(),
    filename: imageFile!.path.split('/').last,
  ));
  
  var response = await request.send();
  print(request);
if (response.statusCode == 200) {
  print(imageFile.path.toString());
  // Image uploaded successfully
  print('Image uploaded');
       setProfilePic();
//  var response = await http.post(Uri.https('personalrec.onrender.com', 'api/user/getuser'),
 
//     headers: {      
//       //  'Content-Type': 'application/json; charset=UTF-8',      
//       'Cookie': 'jwt_token=$gh'
//       }, 
//   body: {
//       'userEmailPhone': email_Logged_user  
//       },      
//        );
//    var  jsonData = jsonDecode(response.body);
//     print(jsonData['data']['userPic']);
//        setState(() {
//          picLink="https://personalrecordback-production.up.railway.app/amendmentDoc/"+jsonData['data']['userPic'].toString();
//        });
      //  print(response.body);
} else {
  // Error occurred while uploading image
  print('Image upload failed');
}

  

      }
      

      
    } else {
      // No image selected
      // Handle accordingly
    }
  } catch (e) {
    // Handle any exceptions that occur during image selection
    print('Error selecting image: $e');
  }
}
  
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;
    // GoFunction();
    return Scaffold(
      backgroundColor: Color.fromARGB(70, 190, 238, 238), // Set background color to deep purple
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),

        backgroundColor:  Color.fromARGB(25, 190, 238, 238), 
        // textDirection: TextDirection.rtl, // Set text direction to right-to-left
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            // Navigate back when the back button is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return homeGrid2();
                  // return userDetails("email");
                },
              ),
            );
          },
        ),
      ),
      body: Column(
   
        mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
         CircleAvatar(
  radius: 50,
  backgroundImage: NetworkImage(picLink),
),

          SizedBox(height: 8),
               
               GestureDetector(
                onTap: () {
                  print("hello");
              GoFunction();
                },
                child:SizedBox(
                  width: 140,
                  height: 35,
                  child:  ElevatedButton(
                  
                  onPressed: 
                (){
                  GoFunction();

                }, child: 
                
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Upload Pic"
                        ),
                        Icon(
                          Icons.camera
                        )
                      ],
                     )
                ),
                )
               ),
               
          SizedBox(height: 8),
          Text(
            email.toString(), // Set profile title here
            style: TextStyle(
              fontSize: width_safearea * 0.045918367,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height_safearea * 0.032),

          Container(
              width: width_safearea * 0.997,
              child: Padding(
                padding: EdgeInsets.all(20),
                   child: Column(
                    children: [
                        Container(
                         
                          width: 330,
                          child: Card(
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              color: const Color.fromARGB(84, 33, 149, 243),
                              child:
                                 Icon(
                                Icons.settings,
                                color: Colors.blue,
                                size: 34,
                              ),
                             
                            ),
                             Row(
                                children: [
                                
                             
                               Text("Settings",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            
                            ),),
                                ],
                              ),
                           

                         
                            Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                          ],
                        ),
                       ),
                        ),

                        Container(
                         
                          width: 330,
                          child: Card(
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              color:const Color.fromARGB(85, 33, 37, 243),
                              child:
                                 Icon(
                                Icons.info_outline,
                                color: const Color.fromARGB(255, 33, 37, 243),
                                size: 34,
                              ),
                             
                            ),
                             Row(
                                children: [
                                
                             
                               Text("Information",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            
                            ),),
                                ],
                              ),
                           

                         
                            Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                          ],
                        ),
                       ),
                        ),

                       
                      
                        Container(
                         
                         width: 330,
                          child: Card(
                        
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              width: 45,
                              color: Color.fromARGB(55, 33, 243, 208),
                              child:
                                 Icon(
                                Icons.translate_outlined,
                                color: Color.fromARGB(255, 33, 243, 208),
                                size: 34,
                              ),
                             
                            ),
                             Row(
                                children: [
                                
                             
                               Text("Language",style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            
                            ),),
                                ],
                              ),
                           

                         
                            Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                color: Colors.black,
                                size: 30,
                              ),
                          ],
                        ),
                       ),
                        )
                    ],
                   )
              )
              
              ),
          // Add any other profile details here, such as email, phone number, etc.

          // Logout button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width_safearea * 0.565306122,
                child: ButtonTheme(
                  minWidth: width_safearea *
                      0.510204082, // Adjust the minWidth here to resize the button
                  child: ElevatedButton(
                    onPressed: () {
                      // Add logout functionality here
                      // You can use a Navigator to navigate to the login page or call a logout API
                      print('Logout button pressed');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            // return MyBottomNavigationBar();
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: width_safearea * 0.045918367,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors
                          .black, // Set button color to deep purple accent
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
