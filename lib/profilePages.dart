import 'package:flutter/material.dart';
import 'package:my_app/Screens/Login/login_screen.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to deep purple
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.deepPurple, // Set app bar color to deep purple
      ),
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.deepPurple.shade100,
            // Set profile picture here
            // You can use Image.asset or NetworkImage to load an image
            backgroundImage: AssetImage('assets/profile_picture.jpg'),
          ),
          SizedBox(height: 16),
          Text(
            'John Doe', // Set profile name here
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Software Developer', // Set profile title here
            style: TextStyle(
              fontSize: 16,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 24),
          // Add any other profile details here, such as email, phone number, etc.

          // Logout button
         Row(
          children: [
            SizedBox(
              width: 53,
            ),
             Container(
            width: 300,
            child: Align(
              alignment: Alignment.topLeft,
              child: ButtonTheme(
                minWidth: 200, // Adjust the minWidth here to resize the button
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
                    style: TextStyle(fontSize: 16),
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
