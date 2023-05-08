import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_app/Screens/Login/login_screen.dart';
import 'package:my_app/newTbb.dart';
import 'package:my_app/tbb.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var _idLoggedIn;
  var email;
  var name;
  String _selectedLanguage = 'English';
  var name_;
  void initState() {
    super.initState();
    var box = Hive.openBox("mybox");
    final _box2 = Hive.box("mybox");
    _idLoggedIn = _box2.get("User_id"); //my user id
    email = _box2.get("User_email");
    name = _box2.get("User_name");

    //put
    //  _box2.put("User_id",jh['data']['_id'] );
    // _box2.put("User_email",username );
    //     _box2.put("User_id",jh['data']['_id'] );
    // _box2.put("User_name2",jh['data']['userName'] );
    _box2.put("Lang_val", _selectedLanguage);

    print("gofun");
    print(name);
    //name
    name_ = _box2.get("User_name2");
    print("ooooooooooooooooooooooooooooooooooo");
    print(name_);
    GoFunction();
  }

  GoFunction() async {}
  Widget build(BuildContext context) {
    var height_safearea =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var width_safearea = MediaQuery.of(context).size.width;
    GoFunction();
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to deep purple
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),

        backgroundColor: Colors.white,
        // textDirection: TextDirection.rtl, // Set text direction to right-to-left
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
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            email.toString(), // Set profile title here
            style: TextStyle(
              fontSize: width_safearea * 0.045918367,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: height_safearea * 0.032),

          Container(
              width: width_safearea * 0.997,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Phone number",
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Language",
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width_safearea * 0.032),
                    Column(
                      children: [
                        Text(
                          ":",
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ":",
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          ":",
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: width_safearea * 0.032),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name_.toString(),
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Phone number",
                          style: TextStyle(
                            fontSize: width_safearea * 0.045918367,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        //container as the dropdown

                        Container(
                          height: height_safearea * 0.0333,
                          width: width_safearea * 0.376,
                          child: DropdownButton(
                            hint: _selectedLanguage == null
                                ? Text('Dropdown')
                                : Text(
                                    _selectedLanguage,
                                    style: TextStyle(color: Colors.black),
                                  ),
                            isExpanded: true,
                            iconSize: 30.0,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            items: ['Bangla', 'English'].map(
                              (val) {
                                return DropdownMenuItem<String>(
                                  value: val,
                                  child: Text(val),
                                );
                              },
                            ).toList(),
                            onChanged: (val) {
                              setState(
                                () {
                                  _selectedLanguage = val!;
                                  print("onstate");
                                  print(_selectedLanguage);
                                  final _box = Hive.box("mybox");
                                  _box.put("Lang_val", _selectedLanguage);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        // return MyBottomNavigationBar();

                                        return dash_newMyBottomNavigationBar_new();
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
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
