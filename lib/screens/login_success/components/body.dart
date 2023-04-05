import 'package:flutter/material.dart';
import 'package:taxi_booking/components/default_button.dart';
import 'package:taxi_booking/components/white_button.dart';
import 'package:taxi_booking/screens/complete_profile/complete_profile_screen.dart';
import 'package:taxi_booking/screens/complete_profile/components/complete_profile_form.dart';
import 'package:taxi_booking/screens/home/home_screen.dart';
import 'package:taxi_booking/screens/sign_up/sign_up_screen.dart';
import 'package:taxi_booking/size_config.dart';

import '../login_success_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "CLIENT SIGN UP",
            press: () {
               Navigator.pushNamed(context, SignUpScreen.routeName);
            },
          ),
        ),
    // SizedBox(height:10),
    //     SizedBox(
    //       width: SizeConfig.screenWidth * 0.6,
    //       child: WhiteButton(
    //         text: "DRIVER SIGN UP",
    //         press: () {
    //           Navigator.pushNamed(context, DriverProfileScreen.routeName);
    //         },
    //       ),
    //     ),

      ],
    );
  }
}
