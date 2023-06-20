import 'package:flutter/material.dart';
import 'package:my_app/MyCreastedList.dart';
import 'package:my_app/abc.dart';

import 'LoangivenPages.dart';
import 'loanTakenPage.dart';

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
        child: Scaffold(
            appBar: AppBar(
               automaticallyImplyLeading: false,// Remove the app bar icon
              elevation: 0,
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.deepPurple),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                "Recent Dates",
                style: TextStyle(color: Color.fromARGB(255, 57, 25, 176)),
              ),
                ],
              )
            ),
            body: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                          icon: Icon(
                        Icons.credit_card,
                        color: Colors.deepPurple,
                      )),
                      Tab(
                          icon: Icon(
                        Icons.directions_boat_filled_rounded,
                        color: Colors.deepPurple,
                      ))
                    ],
                  ),
                  SizedBox(
                      width: 380,
                      height: 700,
                      child: TabBarView(children: [ LoanTakenPages(),LoanGivenPages()]))
                ],
              ),
            )));
  }
}
