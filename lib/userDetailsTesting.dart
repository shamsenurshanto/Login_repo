import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class userdetails_new_with_sidebar extends StatelessWidget {
  const userdetails_new_with_sidebar ({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        
      ),
      );
  }
}