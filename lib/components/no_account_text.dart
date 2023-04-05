import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../size_config.dart';
import 'package:easy_localization/easy_localization.dart';
class NoAccountText extends StatelessWidget {
  const NoAccountText() ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.dont_have_an_account.tr(),
          style: TextStyle(fontSize: getProportionateScreenWidth(12)),
        ),
        SizedBox(width: getProportionateScreenWidth(10),),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            LocaleKeys.sign_up.tr(),
            style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
