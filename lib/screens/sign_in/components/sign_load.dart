import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../globals.dart';
import '../sign_in_screen.dart';

class SignLoad extends StatefulWidget {
  @override
  _SignLoadState createState() => _SignLoadState();
}

class _SignLoadState extends State<SignLoad> {

  @override
  void initState() {
    detectUser();
    super.initState();
  }
  int currentPage = 0;
  void detectUser() async {
    if ( await SystemConfig.getStringValuesSF("userName")!= null && await SystemConfig.getStringValuesSF("userName")!= "" && await SystemConfig.getStringValuesSF("passWord") != null && await SystemConfig.getStringValuesSF("passWord") !="") {
      glUserName=(await SystemConfig.getStringValuesSF("fullName"))!;
      glPhoneNumber=(await SystemConfig.getStringValuesSF("userName"))!;
      glEmail=(await SystemConfig.getStringValuesSF("email"))!;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeMapScreen()));
    }
    else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen()));
    }
  }
  Widget build(BuildContext context) {
    return Container();
  }
}