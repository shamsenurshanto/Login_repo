import 'package:flutter/material.dart';
import 'package:my_app/MainLogin.dart';
import 'package:my_app/MyCreastedList.dart';
import 'package:my_app/PendingForm.dart';
import 'package:my_app/abc.dart';
import 'package:my_app/aboutUs.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/homeGrid.dart';
import 'package:my_app/profilePages.dart';
import 'package:my_app/userDetailsTesting.dart';

import 'NotificationWidget.dart';
import 'newDash.dart';
import 'notificationPages.dart';

class pendingListBottom extends StatefulWidget {
  @override
  _pendingListBottomState createState() => _pendingListBottomState();
}

class _pendingListBottomState extends State<pendingListBottom> {
  int _selectedIndex = 1;
  bool _isVisible = false;

  final List<Widget> _pages = [
    homeGrid(),
    dash4(),
    ProfilePage(),
    NotificationPage(),
    dash3()
  ];
  final List<Widget> _pages2 = [
    homeGrid(),
    userdetails_new_with_sidebar(),
    ProfilePage(),
    NotificationPage(),
    dash3()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)
            ),
        child: Drawer(
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              color: Colors.white,
            ),
            width: 10,
            child: ListView(
              children: [
                DrawerHeader(
                    child: Center(
                        child: Text(
                  "L O G O",
                  style: TextStyle(fontSize: 40),
                ))),
                Container(
                  width: 10,
                  child: ListTile(
                      title: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.dashboard_outlined,
                        size: 24,
                        color: Colors.black38, //<-- SEE HERE
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Dashboard",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
                ),
                Container(
                  width: 10,
                  child: ListTile(
                      title: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      //https://fontawesome.com/icons/wallet?f=classic&s=thin  wallet
                      Icon(
                        Icons.wallet_outlined,
                        size: 24,
                        color: Colors.black38, //<-- SEE HERE
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Transaction",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
                ),
                Container(
                  width: 10,
                  child: ListTile(
                    title: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.dashboard_outlined,
                          size: 24,
                          color: Colors.black38, //<-- SEE HERE
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Dashboard",
                          style: TextStyle(fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 10,
                  child: ListTile(
                      title: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.dashboard_outlined,
                        size: 24,
                        color: Colors.black38, //<-- SEE HERE
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Dashboard",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
                ),
                Container(
                  width: 10,
                  child: ListTile(
                      title: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.dashboard_outlined,
                        size: 24,
                        color: Colors.black38, //<-- SEE HERE
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Dashboard",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
                ),
                Container(
                  width: 10,
                  child: ListTile(
                      title: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.dashboard_outlined,
                        size: 24,
                        color: Colors.black38, //<-- SEE HERE
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Dashboard",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
      appBar: _selectedIndex != 1
          ? AppBar(
              title: _selectedIndex == 0
                  ? Text(
                      "Home",
                      style: TextStyle(color: Colors.black38),
                    )
                  : _selectedIndex == 1
                      ? Text(
                          "Transactions",
                          style: TextStyle(color: Colors.black38),
                        )
                      : _selectedIndex == 2
                          ? Text(
                              "Profile",
                              style: TextStyle(color: Colors.black38),
                            )
                          : _selectedIndex == 3
                              ? Text(
                                  "Notifications",
                                  style: TextStyle(color: Colors.black38),
                                )
                              : _selectedIndex == 4
                                  ? Text(
                                      "Loans",
                                      style: TextStyle(color: Colors.black38),
                                    )
                                  : Text(
                                      "Received",
                                      style: TextStyle(color: Colors.black38),
                                    ),
              elevation: 1,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.deepPurple),

              // automaticallyImplyLeading: false,
            )
          : AppBar(
              elevation: 0.0,
            
              backgroundColor: Colors.transparent,
              
              )
              
              ,
      // backgroundColor: Colors.deepPurple,
      body:
          _isVisible == true ? _pages2[_selectedIndex] : _pages[_selectedIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.yellow))),
        child: 
        //if it is true 
        _isVisible?
        BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.deepOrange,
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.blueGrey,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Transactions',
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
          ],
        )
        
        : // false

        BottomNavigationBar(
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
              label: 'Transactions',
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
          ],
        ),
      ),
    );
  }
}
