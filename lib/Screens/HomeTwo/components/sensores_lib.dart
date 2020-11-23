import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/Details/details_screen.dart';
import 'package:security_iot_system/components/product_card.dart';
import 'package:security_iot_system/components/reading_card_list.dart';
import 'package:security_iot_system/models/Product.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class SensoresPr extends StatelessWidget {
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
              Accionador(
                image: "assets/images/q12w.jpg",
                title: "LM35",
                auth: "Cuarto B",
                rating: 4.8,
              ),
              Accionador(
                image: "assets/images/q12w.jpg",
                title: "RGB",
                auth: "Cuarto C",
                rating: 4.8,
              ),
              SizedBox(width: 30),
            ],
          ),
        ),
      ],
    );
  }
}
