import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'complete_profile_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text(LocaleKeys.fill_missing_info.tr(), style: TextStyle(fontSize:getProportionateScreenWidth(20),fontWeight: FontWeight.bold,color: Colors.black87)),
                // Text(
                //   "Complete your details information  \nto start CHINET Truck cargo",
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                CompleteProfileForm(),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  LocaleKeys.by_continuing_your_confirm.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
