import 'package:flutter/material.dart';
import 'package:my_app/MainLogin.dart';
import 'package:my_app/MyCreastedList.dart';
import 'package:my_app/abc.dart';
import 'package:my_app/aboutUs.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/homeGrid.dart';
import 'package:my_app/profilePages.dart';

import 'NotificationWidget.dart';
import 'newDash.dart';
import 'notificationPages.dart';

class dash_newMyBottomNavigationBar_new extends StatefulWidget {
  @override
  _dash_newMyBottomNavigationBar_newState createState() =>
      _dash_newMyBottomNavigationBar_newState();
}

class _dash_newMyBottomNavigationBar_newState
    extends State<dash_newMyBottomNavigationBar_new> {
  int _selectedIndex = 1;
  bool _isVisible = false;

  final List<Widget> _pages = [
    homeGrid(),
    dash_new(),
    ProfilePage(),
    NotificationPage(),
    dash3()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /** 
      */

      // backgroundColor: Colors.deepPurple,
      body: _pages[_selectedIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.deepOrange,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blueGrey,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
                icon: notificationsButton(
                  counter: 20,
                  child: Icon(Icons.notifications),
                ),
                label: 'Notification')
            /**BottomNavigationBarItem(
            icon: notificationsButton(
              counter : 4,
              child: Icon(Icons.notifications),
            ),
            label: 'Notification',
          ), */
          ],
        ),
      ),
    );
  }
}
