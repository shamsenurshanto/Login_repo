import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class abc extends StatefulWidget {
  @override
  State<abc> createState() => _abcState();
}

class _abcState extends State<abc> {
  String data="";
  bool _isLoading=false;
  getFokatKiAdvice() async {
    final response =
        await http.get(Uri.parse("https://api.adviceslip.com/advice"));
    var resp = json.decode(response.body);
    if (response.statusCode != 200) {
      data = "Oye !! Thare pass Internet naahi hn !!";
    }
    print(resp);
    setState(() {
      data = resp['slip']['advice'];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    _isLoading = true;
    getFokatKiAdvice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Card(
                  child: ListTile(
                    title: Text(
                      "Advice for you !",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                          title: _isLoading
                              ? Center(child: const CircularProgressIndicator())
                              : Text(
                                  data,
                                  textAlign: TextAlign.center,
                                )),
                      const SizedBox(
                        height: 5.00,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            data = '';
                          });
                          getFokatKiAdvice();
                        },
                        child: const Text("Ghe Advice !"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}