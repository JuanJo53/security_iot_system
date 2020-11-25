import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeTwo extends StatefulWidget{
  HomeTwo({Key key, @required this.username}) : super(key: key);

  final String username;
  static String routeName = "/home";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeTwo();
  }

}

class _HomeTwo extends State<HomeTwo> {

  _HomeTwo({this.username});

  final String username;
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
