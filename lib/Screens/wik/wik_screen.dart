import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/wik/components/body.dart';

import '../../size_config.dart';

class WikScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
