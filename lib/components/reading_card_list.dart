import 'package:flutter/material.dart';
import 'package:security_iot_system/components/two_side_rounded_button.dart';
import 'package:security_iot_system/constants.dart';

import 'book_rating.dart';

class Accionador extends StatelessWidget {
  final String image;
  final String title;
  final String auth;
  final double rating;
  final Function pressDetails;
  final Function pressRead;

  const Accionador({
    Key key,
    this.image,
    this.title,
    this.auth,
    this.rating,
    this.pressDetails,
    this.pressRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, bottom: 40),
      height: 245,
      width: 200,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
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
            image,
            width: 200,
            height: 200,
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
                            text: "$title\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: auth,
                            style: TextStyle(
                              color: kPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      /*GestureDetector(
                        onTap: pressDetails,
                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text("ON"),
                        ),
                      ),*/
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "ON",
                          press: pressDetails,
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          text: "OFF",
                          press: pressRead,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
