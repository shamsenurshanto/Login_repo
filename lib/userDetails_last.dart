import 'package:flutter/material.dart';

class tabBarForRecentDates extends StatefulWidget {
  const tabBarForRecentDates({super.key});

  @override
  State<tabBarForRecentDates> createState() => _tabBarForRecentDatesState();
}

class _tabBarForRecentDatesState extends State<tabBarForRecentDates> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
       child:Scaffold(
        body: Container(
          color: Colors.green,
          child: Column(

          children: [
            TabBar(
              tabs: [
                Tab(
                icon: Icon(Icons.home,
                
                color: Colors.amber,
                )
              ),
                Tab(
                icon: Icon(Icons.add,
                
                color: Colors.amber,
                )
              )
            
              ]
            )
          ],

        ),
        )
       )
       
       
        );
  }
}