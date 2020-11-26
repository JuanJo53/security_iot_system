import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/Details/details_screen.dart';
import 'package:security_iot_system/components/reading_card_list.dart';
import 'package:security_iot_system/repository/foco1_repository.dart';
import 'package:security_iot_system/repository/foco2_repository.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'sensores_lib.dart';
import 'disp_prueba.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Body();
  }
}

class _Body extends State<Body> {
  Foco1Repository foco1repository = Foco1Repository();
  Foco2Repository foco2repository = Foco2Repository();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(10)),
            Categories(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  Accionador(
                    image: "assets/images/foco_on.png",
                    title: "Foco 1",
                    auth: "Cuarto A",
                    rating: 4.9,
                    pressDetails: () {
                      print('Encendido Foco1');
                      foco1repository.estadoFoco1(1023);
                    },
                    pressRead: () {
                      print('Apagado Foco1');
                      foco1repository.estadoFoco1(0);
                    },
                  ),
                  Accionador(
                    image: "assets/images/foco_on.png",
                    title: "Foco 2",
                    auth: "Cuarto B",
                    rating: 4.8,
                    pressDetails: () {
                      print('Encendido Foco2');
                      foco2repository.estadoFoco2(1023);
                    },
                    pressRead: () {
                      print('Apagado Foco2');
                      foco2repository.estadoFoco2(0);
                    },
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
            DispRec(),
            SizedBox(height: getProportionateScreenWidth(30)),
            SensoresPr(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
