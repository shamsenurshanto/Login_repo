import 'package:flutter/cupertino.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/UserDetails.dart';
import 'package:my_app/newDash.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

import 'Team_new.dart';
import 'models/team.dart';
import 'newTbb.dart';
void main() => runApp(MaterialApp(home: CupertinoNavigationDemo()));

class CupertinoNavigationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: "home",
          )
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            return CupertinoDemoTab();
          },
        );
      },
    );
  }
}

class CupertinoDemoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute<void>(
            builder: (BuildContext context) => DetailPage(),
          ));
        },
        child: Text("Tap me"),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(),
        child: Container(
          color: Colors.green,
        ));
  }
}