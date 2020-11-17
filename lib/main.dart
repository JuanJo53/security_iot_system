import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:security_iot_system/Screens/Welcome/welcome_screen.dart';
import 'package:security_iot_system/constants.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'IOT',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}