import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
// import 'package:flutter_auth/constants.dart';
import 'package:my_app/Screens/Welcome/welcome_screen.dart';
import 'package:my_app/addTransaction2.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/dashBoard2.dart';
import 'package:my_app/homeGrid.dart';
import 'package:my_app/homePage2.dart';
import 'package:my_app/profilePages.dart';
import 'package:my_app/testing.dart';
import 'package:my_app/transactionWithPending.dart';
import 'package:my_app/userDetailsTesting.dart';
import 'package:workmanager/workmanager.dart';

import 'demoBottombar.dart';
import 'local_notifications.dart';
import 'newTbb.dart';
import 'otpPhoneCode.dart';
import 'otpPhoneCode_2.dart';
import 'otpTester.dart';


void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    print("Task executing2222 :" + taskName);
      NotificationService().showNotification(
                                      title: 'Sample title',
                                      body: 'Itddddddddddddddddddddddds!'+taskName.toString());
    return Future.value(true);
  });
}
Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
   WidgetsFlutterBinding.ensureInitialized();
      WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);
   
  NotificationService().initNotification();
await Firebase.initializeApp();

  runApp(
  
   
  const MyApp()
  
  
  );
  
  }

class MyApp extends StatelessWidget {
  const  MyApp ({Key? key}) : super(key: key);
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: kPrimaryLightColor,
            iconColor: kPrimaryColor,
            prefixIconColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: defaultPadding, vertical: defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
            // home : dash_newMyBottomNavigationBar_new(),
            // home: const homeGrid(),
            // home: const transactionWithPending(),
            // home: userdetails_new_with_sidebar(),
            // home: ProfilePage2()
            // home: CupertinoNavigationDemo(),
              //  home: otpTester(),
              // home:  otpPhone_2("0190929290"),


    );
  }
}