import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/Details/details_screen.dart';
import 'package:security_iot_system/components/product_card.dart';
import 'package:security_iot_system/components/reading_card_list.dart';
import 'package:security_iot_system/components/two_side_rounded_button.dart';
import 'package:security_iot_system/constants.dart';
import 'package:security_iot_system/models/Product.dart';
import 'package:security_iot_system/repository/rgb_repository.dart';
import 'package:security_iot_system/repository/temperature_repository.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SensoresPr extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateSensoresPr();
  }

}

class _StateSensoresPr extends State<SensoresPr> {
  RgbRepository rgbRepository = RgbRepository();
  TemperatureRepository temperatureRepository = TemperatureRepository();
  double valor;
  int i = 0;
  Size size;
  var temperatura="";
  hilo()async{
    valor = await temperatureRepository.estadoTemperature();
    i++;
    print(i);
    if(valor != null){
      print(valor);
      setState(() {
        temperatura = valor.toString();
      });
    }
    await Future.delayed(Duration(seconds: 1));
    hilo();
  }
  @override
  initState(){
    super.initState();
    hilo();
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
                image: "assets/images/q12w.jpg",
                title: "SENSOR PIR",
                auth: "Cuarto A",
                rating: 4.9,
                pressDetails: () {},
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
                      "assets/images/q12w.jpg",
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
                                Text("Temperatura Actual: ",style: TextStyle(color: kPrimaryColor),),
                                Text("$temperatura",style: TextStyle(color: Colors.indigo),),
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
                image: "assets/images/q12w.jpg",
                title: "RGB Rojo",
                auth: "Cuarto C",
                rating: 4.8,
                pressDetails: (){
                  print('Rojo encendido');
                  rgbRepository.estadoRgbRojo(255);
                },
                pressRead: (){
                  print('Rojo apagado');
                  rgbRepository.estadoRgbRojo(0);
                },
              ),
              Accionador(
                image: "assets/images/q12w.jpg",
                title: "RGB Verde",
                auth: "Cuarto C",
                rating: 4.8,
                pressDetails: (){
                  print('Verde encendido');
                  rgbRepository.estadoRgbVerde(255);
                },
                pressRead: (){
                  print('Verde apagado');
                  rgbRepository.estadoRgbVerde(0);
                },
              ),
              Accionador(
                image: "assets/images/q12w.jpg",
                title: "RGB Azul",
                auth: "Cuarto C",
                rating: 4.8,
                pressDetails: (){
                  print('Azul encendido');
                  rgbRepository.estadoRgbAzul(255);
                },
                pressRead: (){
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
