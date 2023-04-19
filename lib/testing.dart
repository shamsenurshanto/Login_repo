import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SummeryPage extends StatelessWidget {
  const SummeryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
     margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
     child: Center(
      child: Column(
      children: [
        Text("Total Sent: ")
      ],
     ),
     )
      ),
    );
  }
}