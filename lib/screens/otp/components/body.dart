import 'package:flutter/material.dart';
import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/size_config.dart';

import '../otp_screen.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  final String? phone;
  final String? password;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  Body(this.phone, this.password,this.firstName,this.middleName,this.lastName,this.email);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              Text("We sent your code to +251 9 ***"),
              buildTimer(),
              OtpForm(phone,password,firstName,middleName,lastName,email),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => OtpScreen(
                        phone:phone,password:password,firstName: firstName,middleName:middleName ,lastName: lastName,email: email,
                      )));
                  // OTP code resend
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 59.0, end: 0.0),
          duration: Duration(seconds: 59),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
