import 'package:flutter/material.dart';
import 'package:taxi_booking/components/socal_card.dart';
import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/size_config.dart';

import 'sign_up_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: getProportionateScreenHeight(30),fontWeight: FontWeight.bold)
                ),
                Text(
                  "Complete the form below to register",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                SignUpForm(),
                //SizedBox(height: SizeConfig.screenHeight * 0.08),
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
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  'By continuing, you are confirming that you agree \nwith our terms and conditions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
