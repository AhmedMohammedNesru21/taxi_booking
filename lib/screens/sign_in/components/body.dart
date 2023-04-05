import 'package:taxi_booking/screens/sign_in/components/sign_load.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/components/no_account_text.dart';
import 'package:taxi_booking/components/socal_card.dart';
import '../../../size_config.dart';
import 'sign_form.dart';
import 'package:easy_localization/easy_localization.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  LocaleKeys.welcome_back.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  LocaleKeys.sign_in_with_your_phone.tr(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     SocalCard(
                //       // icon: "assets/icons/google-icon.svg",
                //       icon: "",
                //       press: () {},
                //     ),
                //     SocalCard(
                //       // icon: "assets/icons/facebook-2.svg",
                //       icon: "",
                //       press: () {},
                //     ),
                //     SocalCard(
                //       // icon: "assets/icons/twitter.svg",
                //       icon: "",
                //       press: () {},
                //     ),
                //   ],
                // ),
                // SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
