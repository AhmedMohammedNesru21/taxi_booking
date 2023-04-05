import 'package:taxi_booking/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

    Widget build(BuildContext context) {

      return WillPopScope(
          onWillPop: () async {
        return false;
      },
      child: Scaffold(
      appBar: AppBar(
        title: Text("Re-Login"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SplashScreen()));
            // if (Navigator.of(context).canPop()) {
            //   Navigator.of(context).pop();
            // }
          },
        ),
      ),
      body: Body(),
    ),);
  }
}
