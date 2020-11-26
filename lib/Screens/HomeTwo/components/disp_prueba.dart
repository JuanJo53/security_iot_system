import 'package:flutter/material.dart';
import 'package:security_iot_system/repository/servomotor_repository.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class DispRec extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateDispRec();
  }
}

class _StateDispRec extends State<DispRec> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Dispositivos Recientes",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: "assets/images/foco_on.png",
                category: "SERVOMOTOR",
                numOfBrands: 18,
                press: () {},
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatefulWidget {
  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;
  SpecialOfferCard({
    Key key,
    @required this.category,
    @required this.image,
    @required this.numOfBrands,
    @required this.press,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StateSpecialOfferCard(
        this.category, this.image, this.numOfBrands, this.press);
  }
}

class _StateSpecialOfferCard extends State<SpecialOfferCard> {
  _StateSpecialOfferCard(
    this.category,
    this.image,
    this.numOfBrands,
    this.press,
  );

  ServomotorRepository servomotorRepository = ServomotorRepository();

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;
  bool state = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(242),
        height: getProportionateScreenWidth(110),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF343434).withOpacity(0.4),
                      Color(0xFF343434).withOpacity(0.15),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15.0),
                      vertical: getProportionateScreenWidth(10),
                    ),
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "$category\n",
                            style: TextStyle(
                              fontSize: getProportionateScreenWidth(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(text: "$numOfBrands Brands")
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        //horizontal: getProportionateScreenWidth(50.0),
                        //vertical: getProportionateScreenWidth(10),
                        ),
                    child: Switch(
                      value: state,
                      onChanged: (bool s) {
                        setState(() {
                          state = s;
                          print(state);
                          if (state) {
                            print('Encendiendo');
                            servomotorRepository.estadoServomotor(1);
                          } else {
                            print('Apagando');
                            servomotorRepository.estadoServomotor(0);
                          }
                        });
                      },
                      activeColor: Colors.indigo,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
