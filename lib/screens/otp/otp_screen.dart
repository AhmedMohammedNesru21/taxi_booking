import 'package:taxi_booking/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/size_config.dart';


import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  final String? phone;
  final String? password;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;

  const OtpScreen({ this.phone, this.password,this.firstName,this.middleName,this.lastName,this.email});

  static String routeName = "/otp";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
      return false;
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SplashScreen()));
          },
        ),
      ),
      body: Body(phone,password,firstName,middleName,lastName,email),
    ));
  }
}
