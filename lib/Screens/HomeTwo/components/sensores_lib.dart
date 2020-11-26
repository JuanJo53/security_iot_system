import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:security_iot_system/Screens/Details/details_screen.dart';
import 'package:security_iot_system/components/product_card.dart';
import 'package:security_iot_system/components/reading_card_list.dart';
import 'package:security_iot_system/components/two_side_rounded_button.dart';
import 'package:security_iot_system/constants.dart';
import 'package:security_iot_system/models/Product.dart';
import 'package:security_iot_system/repository/alarma_repository.dart';
import 'package:security_iot_system/repository/movesensor_repository.dart';
import 'package:security_iot_system/repository/rgb_repository.dart';
import 'package:security_iot_system/repository/temperature_repository.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SensoresPr extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateSensoresPr();
  }
}

class _StateSensoresPr extends State<SensoresPr> {
  RgbRepository rgbRepository = RgbRepository();
  TemperatureRepository temperatureRepository = TemperatureRepository();
  AlarmaRepository alarmaRepository = AlarmaRepository();
  MoveSensorRepository moveSensorRepository = MoveSensorRepository();
  double valor;
  int valorPIR;
  int i = 0;
  Size size;
  var temperatura = "";
  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated;
  bool control = true;

  Future<void> _authenticate() async {
    authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          androidAuthStrings: AndroidAuthMessages(
              signInTitle: "Alarma Encedida!",
              fingerprintHint: "",
              cancelButton: "Sistema expuesto"),
          localizedReason: 'Apagar la alarma con la autenticación de huella',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    print(message);
    setState(() {
      _authorized = message;
    });
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  hilo() async {
    valor = await temperatureRepository.estadoTemperature();
    i++;
    //print(i);
    if (valor != null) {
      //print(valor);
      setState(() {
        temperatura = valor.toString();
      });
    }
    await Future.delayed(Duration(seconds: 1));
    hilo();
  }

  hilo1() async {
    //print('hilo 1');
    //print(control);
    if (control) {
      //print('entra');
      valorPIR = await moveSensorRepository.estadoSensor();
      if (valorPIR != null) {
        if (valorPIR == 1) {
          //print('Hola');
          _isAuthenticating
              ? await _cancelAuthentication()
              : await _authenticate();
          if (_authorized == "Authorized") {
            //print('Alarma Apagada cambia a true');
            control = true;
          }
          if (_authorized == "Not Authorized") {
            //print('cambia a false');
            control = false;
          }
        }
      }
    }
    await Future.delayed(Duration(seconds: 1));
    hilo1();
  }

  @override
  initState() {
    super.initState();
    hilo();
    hilo1();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(title: "Sensores", press: () {}),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Accionador(
                image: "assets/images/ala_on.png",
                title: "",
                auth: "",
                rating: 4.9,
                pressDetails: () {
                  _isAuthenticating ? _cancelAuthentication() : _authenticate();
                  //print("esta autenticado: "+_isAuthenticating.toString());
                  /*if(authenticated){
                    print('Alarma Apagada');
                    alarmaRepository.estadoAlarma(0);
                    control = true;
                  }*/
                },
              ),
              /*Accionador(
                image: "assets/images/q12w.jpg",
                title: "LM35",
                auth: "Cuarto B",
                rating: 4.8,
                pressDetails: ()async {},
              ),*/
              Container(
                margin: EdgeInsets.only(left: 24, bottom: 40),
                height: 245,
                width: 202,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 221,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 10),
                              blurRadius: 33,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/images/termo.png",
                      width: 150,
                      height: 150,
                    ),
                    Positioned(
                      top: 160,
                      child: Container(
                        height: 85,
                        width: 202,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 24),
                              child: RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  style: TextStyle(color: kPrimaryColor),
                                  children: [
                                    TextSpan(
                                      text: "LM35",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: " Cuarto B",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            //Spacer(),
                            SizedBox(width: 25),
                            Row(
                              children: [
                                Text(
                                  "Temperatura Actual: ",
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                                Text(
                                  "$temperatura",
                                  style: TextStyle(color: Colors.indigo),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Accionador(
                image: "assets/images/redled.png",
                title: "RGB Rojo",
                auth: "Cuarto C",
                rating: 4.8,
                pressDetails: () {
                  print('Rojo encendido');
                  rgbRepository.estadoRgbRojo(255);
                },
                pressRead: () {
                  print('Rojo apagado');
                  rgbRepository.estadoRgbRojo(0);
                },
              ),
              Accionador(
                image: "assets/images/greeled.png",
                title: "RGB Verde",
                auth: "Cuarto C",
                rating: 4.8,
                pressDetails: () {
                  print('Verde encendido');
                  rgbRepository.estadoRgbVerde(255);
                },
                pressRead: () {
                  print('Verde apagado');
                  rgbRepository.estadoRgbVerde(0);
                },
              ),
              Accionador(
                image: "assets/images/bluled.png",
                title: "RGB Azul",
                auth: "Cuarto C",
                rating: 4.8,
                pressDetails: () {
                  print('Azul encendido');
                  rgbRepository.estadoRgbAzul(255);
                },
                pressRead: () {
                  print('Azul apagado');
                  rgbRepository.estadoRgbAzul(0);
                },
              ),
              SizedBox(width: 30),
            ],
          ),
        ),
      ],
    );
  }
}
