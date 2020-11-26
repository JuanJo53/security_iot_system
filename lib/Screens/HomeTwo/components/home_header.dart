import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/Login/login_screen.dart';
import 'package:security_iot_system/Services/authentication_service.dart';
import 'package:security_iot_system/main.dart';

import '../../../size_config.dart';
import '../home_two.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';
import 'package:provider/provider.dart';
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "assets/icons/user-icon.svg",
            press: ()async{
              await context.read<AuthenticationService>().signOut();
              if(FirebaseAuth.instance.currentUser==null){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MyApp();
                    },
                  ),
                  (route)=>false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}