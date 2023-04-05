import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:easy_localization/easy_localization.dart';
class SplashContent extends StatelessWidget {
  const SplashContent({
    required this.text,
    required this.image,
  }) ;
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
        LocaleKeys.kayo_logistics.tr(),
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(19),
          ),
        ),
        Spacer(flex: 2),
        Image.asset(
          image,
          height: getProportionateScreenHeight(265),
          width:  getProportionateScreenWidth(235),
        ),
      ],
    );
  }
}
