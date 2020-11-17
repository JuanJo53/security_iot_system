import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:security_iot_system/Screens/Facial/facial_screen.dart';
import 'package:security_iot_system/Screens/Login/login_screen.dart';
import 'package:security_iot_system/Screens/Welcome/components/background.dart';
import 'package:security_iot_system/components/rounded_button.dart';
import 'package:security_iot_system/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SAFE SMARTHOME",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.white),
            ),
            SizedBox(height: size.height * 0.03),
            /*SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),*/
            Icon(
              Icons.security,
              color: kPrimaryColor,
              size: 300.0,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "Reconocimiento Facial",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Rec_Facial();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "Crendenciales",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
