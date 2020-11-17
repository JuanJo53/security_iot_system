import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:security_iot_system/Screens/Home/home_screen.dart';
import 'package:security_iot_system/Screens/SignUp/signup_screen.dart';
import 'package:security_iot_system/Screens/Welcome/components/background.dart';
import 'package:security_iot_system/Services/authentication_service.dart';
import 'package:security_iot_system/components/already_have_an_account_acheck.dart';
import 'package:security_iot_system/components/rounded_button.dart';
import 'package:security_iot_system/components/rounded_input_field.dart';
import 'package:security_iot_system/components/rounded_password_field.dart';
import 'package:security_iot_system/constants.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
  }) : super(key: key);

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
              "INGRESO CON CREDENCIALESS",
              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: size.height * 0.03),
            /*SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),*/
            Icon(
              Icons.supervised_user_circle,
              color: kPrimaryColor,
              size: 300.0,
            ),
            SizedBox(height: size.height * 0.03),
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
              text: "INGRESAR",
              press: () {
                context.read<AuthenticationService>().signIn(
                  email: email,
                  password: password
                );

              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
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