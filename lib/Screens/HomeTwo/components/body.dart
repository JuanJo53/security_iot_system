import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/Details/details_screen.dart';
import 'package:security_iot_system/components/reading_card_list.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'sensores_lib.dart';
import 'disp_prueba.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    image: "assets/images/q12w.jpg",
                    title: "Foco 1",
                    auth: "Cuarto A",
                    rating: 4.9,
                    pressDetails: () {},
                  ),
                  Accionador(
                    image: "assets/images/q12w.jpg",
                    title: "Foco 2",
                    auth: "Cuarto B",
                    rating: 4.8,
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
