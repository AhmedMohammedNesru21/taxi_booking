import 'package:flutter/material.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:geolocator/geolocator.dart';


String mapKey = "";



late Position currentPosition;
const kPrimaryColor = Color(0xffcc0624);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

final Color lprimaryColor = const Color(0xffb2cd4e);
final Color lsecondaryColor = const Color(0xfff99c37);
final Color lbasicDarkColor = const Color(0xff5c6a41);
final Color lbasicGreyColor = const Color(0xff8F9BB3);
final Color lbackgroundColor = const Color(0xffF7F9FC);

final Color dprimaryColor = const Color(0xffEE4B45);
final Color dsecondaryColor = const Color(0xffFFAA00);
final Color dbasicDarkColor = const Color(0xff222B45);
final Color dbasicGreyColor = const Color(0xff8F9BB3);
final Color dbackgroundColor = const Color(0xff222B45);

final Color facebookColor = const Color(0xff3B5998);
final Color googleColor = const Color(0xff4285f4);
final Color googlewhiteColor = const Color(0xff77adf8);

final Color black = const Color(0x000000);
final Color white = const Color(0xFFFFFF);

final Color abcColor1 = const Color(0xfff99c37);
final Color abcColor2 = const Color(0xff5c6a41);
final Color abcColor3 = const Color(0xffcacba3);
final Color abcColor4 = const Color(0xffb2cd4e);
final Color abcColor5 = const Color(0xffefa248);
final Color abcColor6 = const Color(0xfff8f8ea);
final Color abcColor7 = const Color(0xff7e826e);
final Color abcColor8 = const Color(0xff8b9965);
final Color abcColor9 = const Color(0xff86b03e);
final Color abcColor10 = const Color(0xff86b03e);
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kkmNumberNullError = "Please Enter side road meter number";
const String kPhoneNullError = "Please Enter your Phone";
const String kKglNullError = "Please Enter your KG";
const String kRateNullError = "Please Select your Rate";
const String kCarNullError = "Please Select Truck Type ";
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
class APIUrls
{
  // static String domainname='http://sicsoutsourcing-001-site16.mysitepanel.net';
  static String domainname='https://kayologistics.sicsoutsourcing.com';

}
class Constants {
   static const double padding =20;
  static const double avatarRadius =45;
   static const double margin =7;
}
class ConstantColors {
  // #cc0624
   static const Color PrimaryColor = Color(0xffcc0624);
   static const Color SecondColor = Color(0xff000000);
  // static const Color ActivePink = Color(0xfffb376a);
  static const Color DeepBlue = Color(0xff13034d);
}