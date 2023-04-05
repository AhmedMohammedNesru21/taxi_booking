
import 'dart:async';

import 'package:taxi_booking/screens/Homemap/home_Map_Screen.dart';
import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:taxi_booking/wellcome.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/components/white_button.dart';
import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/screens/sign_in/sign_in_screen.dart';
import 'package:taxi_booking/screens/sign_up/sign_up_screen.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../globals.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      detectUser();
    });
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
              builder: (context) => WellCome()));
    }
  }
  List<Map<String, String>> splashData = [
    {
      "text": LocaleKeys.wel_come.tr(),
      "image": "assets/images/splash_1.png"
    },
    {
      "text":
      LocaleKeys.wel_come2.tr(),
      "image": "assets/images/splash_2.png"
    },
    {
      "text": LocaleKeys.show_easy.tr(),
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"]!,
                  text: splashData[index]['text']!,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    DefaultButton(

                      text: LocaleKeys.sign_in.tr(),
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                    ),
                    SizedBox(height:3),
                    WhiteButton(
                      text: LocaleKeys.create_account.tr(),
                      press: () {
                        Navigator.pushNamed(context,SignUpScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
