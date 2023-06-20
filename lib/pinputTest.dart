import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerificationCodePage extends StatefulWidget {
  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  String pin = '';

  void onPinChanged(String value) {
    setState(() {
      pin += value;
      print(pin);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification Code'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                  onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                  onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                 onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            )
            ,
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                 onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                  onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            ),
               SizedBox(
              height: 60,
              width: 60,
              child: TextField(
                onChanged: (value){
                  FocusScope.of(context).nextFocus();
                 onPinChanged(value);
                },
                style: Theme.of(context).textTheme.headlineMedium,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.digitsOnly,
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VerificationCodePage(),
  ));
}
