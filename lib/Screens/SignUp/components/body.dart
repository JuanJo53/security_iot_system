import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/Home/home_screen.dart';
import 'package:security_iot_system/Screens/Login/login_screen.dart';
import 'package:security_iot_system/Screens/SignUp/components/social_icon.dart';
import 'package:security_iot_system/Services/authentication_service.dart';
import 'package:security_iot_system/components/already_have_an_account_acheck.dart';
import 'package:security_iot_system/components/rounded_button.dart';
import 'package:security_iot_system/components/rounded_input_field.dart';
import 'package:security_iot_system/components/rounded_password_field.dart';
import 'package:security_iot_system/constants.dart';
import 'package:provider/provider.dart';
import 'background.dart';
import 'or_divider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String email, password;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold,color: logoHome),
            ),
            SizedBox(height: size.height * 0.03),
            /*SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),*/
            Icon(
              Icons.app_registration,
              color: Colors.white,
              size: 200.0,
            ),
            RoundedInputField(
              hintText: "Tu Correo",
              onChanged: (String value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (String value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "REGISTRARSE",
              press: () {
                context.read<AuthenticationService>().signUp(
                  email: email,
                  password: password,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
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
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}