import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_app/Screens/Login/login_screen.dart';
import 'package:my_app/tbb.dart';

class ProfilePage extends StatelessWidget {
  
  @override
 var _idLoggedIn;
           var email;
           var name;
    GoFunction() async{
       var box = await Hive.openBox("mybox");
  final _box2 = Hive.box("mybox");
    _idLoggedIn= _box2.get("User_id");//my user id 
           email= _box2.get("User_email");
           name= _box2.get("User_name");
           print(name);
  }
  Widget build(BuildContext context) {
    var height_safearea = MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top;
              var width_safearea = MediaQuery.of(context).size.
              width ;
    GoFunction();
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to deep purple
     appBar: AppBar(title: Text("Profile",style: TextStyle(color: Colors.black),),
  
      backgroundColor: Colors.white,
  // textDirection: TextDirection.rtl, // Set text direction to right-to-left
  leading: IconButton(
    icon: Icon(Icons.arrow_back,color: Colors.black,),
    onPressed: () {
      // Navigate back when the back button is pressed
                 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MyBottomNavigationBar();
                    // return userDetails("email");
                  },
                ),
              );

    },
  ),
 
),
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.deepPurple.shade100,
            // Set profile picture here
            // You can use Image.asset or NetworkImage to load an image
            backgroundImage: AssetImage('assets/images/cat.jpg'),
          ),
         
          SizedBox(height: 8),
          Text(
            'Software Developer', // Set profile title here
            style: TextStyle(
              fontSize: width_safearea * 0.045918367,
               fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 8),
          Text(
            email.toString(), // Set profile title here
            style: TextStyle(
              fontSize: width_safearea * 0.045918367,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: height_safearea * 0.032),
          // Add any other profile details here, such as email, phone number, etc.

          // Logout button
         Row(
          children: [
            SizedBox(
              width: width_safearea * 0.135204082,
            ),
             Container(
            width: width_safearea * 0.765306122,
            child: Align(
              alignment: Alignment.topLeft,
              child: ButtonTheme(
                minWidth: width_safearea * 0.510204082, // Adjust the minWidth here to resize the button
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
                    style: TextStyle(fontSize: width_safearea * 0.045918367),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurpleAccent, // Set button color to deep purple accent
                  ),
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
