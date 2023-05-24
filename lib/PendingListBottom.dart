import 'package:flutter/cupertino.dart';
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
import 'homePage2.dart';
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
      body: CupertinoTabScaffold(
      
      tabBar: CupertinoTabBar(
        
        items: <BottomNavigationBarItem>[

             BottomNavigationBarItem(
              
              icon: Icon(CupertinoIcons.home),
              label: "Home",

             
             ),

             BottomNavigationBarItem(
              
              icon: Icon(CupertinoIcons.list_dash),
              label: "Dashboard",
              
             
             ),
             BottomNavigationBarItem(
              
              icon: Icon(CupertinoIcons.person),
              label: "Profile",
              
             
             ),
              BottomNavigationBarItem(
              
              icon: Icon(Icons.notifications_none),
              label: "Notification",
              
             
             ),


        ]
      
      
      )
     
     
     , 
     
     tabBuilder: (context,index){
      

      if(index==0)
      {
        return CupertinoTabView(
          builder: (context){
            print("--------------))))");
            print(index);
            return CupertinoPageScaffold(child: 
                 homepage2()
            );
          },
        );
      }
      else  if(index==1)
      {
        return CupertinoTabView(
          builder: (context){
            return CupertinoPageScaffold(child: 
                 dash4()
            );
          },
        );
      }
      else  if(index==2)
      {
        return CupertinoTabView(
          builder: (context){
            return CupertinoPageScaffold(child: 
                 ProfilePage()
            );
          },
        );
      }
      else
      {
        return CupertinoTabView(
          builder: (context){
            return CupertinoPageScaffold(child: 
                 NotificationPage()
            );
          },
        );
      }

     }
  

      )
    );

  }
}
  

    
