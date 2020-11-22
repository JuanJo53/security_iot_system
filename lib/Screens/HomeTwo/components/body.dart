import 'package:flutter/material.dart';
import 'package:security_iot_system/Screens/Details/details_screen.dart';
import 'package:security_iot_system/components/reading_card_list.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

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
                    title: "Crushing & Influence",
                    auth: "Gary Venchuk",
                    rating: 4.9,
                    pressDetails: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailsScreen();
                          },
                        ),
                      );
                    },
                  ),
                  Accionador(
                    image: "assets/images/q12w.jpg",
                    title: "Top Ten Business Hacks",
                    auth: "Herman Joel",
                    rating: 4.8,
                  ),
                  SizedBox(width: 30),
                ],
              ),
            ),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
