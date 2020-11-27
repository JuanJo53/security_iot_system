import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_iot_system/Screens/Welcome/welcome_screen.dart';
import 'package:security_iot_system/Screens/wik/wik_screen.dart';
import 'package:security_iot_system/constants.dart';

import 'Screens/Home/home_screen.dart';
import 'Screens/Login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secure SmartHome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WikScreen(),
    );
  }
}
