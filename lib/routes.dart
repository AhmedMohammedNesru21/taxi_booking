import 'package:taxi_booking/screens/AttachedFile.dart';
import 'package:taxi_booking/screens/Homemap/HomeMScreen.dart';
import 'package:taxi_booking/screens/Homemap/home_Map_Screen.dart';
import 'package:taxi_booking/screens/MapView/MapViewScreen.dart';
import 'package:taxi_booking/screens/payment.dart';
import 'package:taxi_booking/screens/paymentdetail.dart';
import 'package:taxi_booking/screens/setting_screen.dart';
import 'package:taxi_booking/wellcome.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_booking/screens/cart/cart_screen.dart';
import 'package:taxi_booking/screens/complete_profile/complete_profile_screen.dart';
import 'package:taxi_booking/screens/details/details_screen.dart';
import 'package:taxi_booking/screens/forgot_password/forgot_password_screen.dart';
import 'package:taxi_booking/screens/login_success/login_success_screen.dart';
import 'package:taxi_booking/screens/my_rides.dart';
import 'package:taxi_booking/screens/profile/profile_screen.dart';
import 'package:taxi_booking/screens/sign_in/sign_in_screen.dart';
import 'package:taxi_booking/screens/splash/splash_screen.dart';
import 'package:taxi_booking/screens/userRequestHome/userrequesthome.dart';
import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'screens/OnGoingRideScreen.dart';
import 'screens/homeMapView/viewMap.dart';
import 'screens/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),

  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
 // OtpScreen.routeName: (context) => OtpScreen(),
 // HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  UserRequestHome.routeName:(context) => UserRequestHome(),
  OnGoingRideScreen.routeName:(context) => OnGoingRideScreen(),
  UserRequestHome.routeName:(context)=>UserRequestHome(),
  MapPage.routeName:(context)=>MapPage(),
  HomeMapScreen.routeName:(context)=>HomeMapScreen(),
  MyRides.routeName:(context)=>MyRides(),
  Setting_Screen.routeName:(context)=>Setting_Screen(toolbarname: '',),
  MapViewScreen.routeName:(context)=>MapViewScreen(),
  Payment.routeName:(context)=>Payment(),
  PaymentDetail.routeName:(context)=>PaymentDetail(),
  EmailSender.routeName:(context)=>EmailSender(),
  HomeMapPage.routeName:(context)=>HomeMapPage(),
  HomeMScreen.routeName:(context)=>HomeMScreen(),
  WellCome.routeName:(context)=>WellCome()


};
