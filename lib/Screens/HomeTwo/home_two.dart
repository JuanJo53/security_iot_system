import 'package:flutter/material.dart';

import 'components/body.dart';

class HomeTwo extends StatelessWidget {

  const HomeTwo({Key key, @required this.username}) : super(key: key);

  final String username;
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
