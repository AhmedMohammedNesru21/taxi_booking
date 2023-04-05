import 'package:taxi_booking/screens/Homemap/home_Map_Screen.dart';
import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'package:taxi_booking/screens/splash/splash_screen.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';
import 'globals.dart';

class WellCome extends StatefulWidget {
  static String routeName = "/WellCome";
  @override
  _WellComeState createState() => _WellComeState();
}

class _WellComeState extends State<WellCome> {

  @override
  initState() {
    super.initState();
    detectUser();
  }

  void detectUser() async {
    if ( await SystemConfig.getStringValuesSF("userName")!= null && await SystemConfig.getStringValuesSF("userName")!= "" ) {
      glUserName=(await SystemConfig.getStringValuesSF("fullName"))!;
      glPhoneNumber=(await SystemConfig.getStringValuesSF("userName"))!;
      glEmail=(await SystemConfig.getStringValuesSF("email"))!;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeMapPage()));
    }
    else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SplashScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final ThemeData _theme = Theme.of(context);
    return WillPopScope(
        onWillPop: () {
          return Future.value(true); // or return Future.value(false);
        },

        child: HomeMapPage()
    );

  }

}
