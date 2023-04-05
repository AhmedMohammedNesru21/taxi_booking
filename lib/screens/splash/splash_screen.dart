import 'package:flutter/material.dart';
import 'package:taxi_booking/screens/splash/components/body.dart';
import 'package:taxi_booking/size_config.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return WillPopScope(
        onWillPop: () async {
      return false;
    },
    child: Scaffold(
      body: Body(),
    ));
  }
}
