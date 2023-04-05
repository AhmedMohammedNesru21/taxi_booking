import 'dart:developer';

import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/screens/complete_profile/complete_profile_screen.dart';
import 'package:taxi_booking/screens/forgot_password/forgot_password_screen.dart';
import 'package:taxi_booking/screens/my_rides.dart';
import 'package:taxi_booking/screens/payment.dart';
import 'package:taxi_booking/screens/setting_screen.dart';
import 'package:taxi_booking/screens/sign_in/sign_in_screen.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:flutter/material.dart';

import '../globals.dart';
import 'package:easy_localization/easy_localization.dart';

import '../size_config.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List _drawerMenu = [
      {
        "icon": Icons.restore,
        "text": LocaleKeys.my_history.tr(),
        "route": MyRides.routeName,
      },
      {
        "icon": Icons.person,
        "text": LocaleKeys.Profile.tr(),
        "route": CompleteProfileScreen.routeName
      },
      {
        "icon": Icons.settings,
        "text": LocaleKeys.setting.tr(),
        "route": Setting_Screen.routeName
      },
      {
        "icon": Icons.credit_card,
        "text": LocaleKeys.payments.tr(),
        "route": Payment.routeName,
      },
      {
        "icon": Icons.logout,
        "text": "Log Out",
        "route": SignInScreen.routeName,
      },
      // {
      //   "icon": Icons.chat,
      //   "text": "Support",
      //   "route": ChatRiderRoute,
      // }
      // {
      //   "icon": Icons.notifications,
      //   "text": "Notification",
      // },
    ];
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width -
          (MediaQuery.of(context).size.width * 0.4),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
              ),
              height: getProportionateScreenHeight(170),
              color: kPrimaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: getProportionateScreenWidth(20),
                    // child: Image.asset('assets/images/user.png'),

                    backgroundImage: NetworkImage(
                        "https://toppng.com/uploads/preview/icons-logos-emojis-user-icon-png-transparent-11563566676e32kbvynug.png"),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(7),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        glUserName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getProportionateScreenWidth(12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(CompleteProfileScreen.routeName);
                        },
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "(+251)" + glPhoneNumber,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: getProportionateScreenWidth(10),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                ),
                child: ListView(
                  children: _drawerMenu.map((menu) {
                    return GestureDetector(
                      onTap: () async {
                        menu["text"].toString();
                        if (menu["text"].toString() == "Log Out") {
                          bool result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Confirmation'),
                                content: Text(
                                  'Are you sure you want to logout?',
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(12)),
                                ),
                                actions: <Widget>[
                                  TextButton(

                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(
                                          true); // dismisses only the dialog and returns true
                                    },
                                    child: Text('Yes'),
                                  ),
                                  new TextButton(

                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(
                                          false); // dismisses only the dialog and returns true
                                    },
                                    child: Text('No'),
                                  )

                                ],
                              );
                            },
                          );

                          if (result) {
                            SystemConfig.setLogout();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordScreen()));
                          } else {
                            Navigator.pop(
                                context); // dismisses the entire widget
                          }
                        } else {
                          Navigator.of(context).pushNamed(menu["route"]);
                        }
                      },
                      child: ListTile(
                        leading: Icon(menu["icon"]),
                        title: Text(
                          menu["text"],
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(10),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
