import 'package:taxi_booking/translations/codegen_loader.g.dart';
import 'package:taxi_booking/wellcome.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/routes.dart';
import 'package:taxi_booking/screens/splash/splash_screen.dart';
import 'package:taxi_booking/theme.dart';
import 'package:provider/provider.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   runApp(MultiProvider(
            providers: [
              ChangeNotifierProvider(
              create: (_) => AppData(),
           ),
            ],
        child:  EasyLocalization(
            path: 'assets/translations',
            supportedLocales: [
              Locale('en'),
              Locale('am'),
              Locale('or'),
              Locale('so'),
              Locale('af'),
              Locale('tr'),
            ],
            fallbackLocale: Locale('en'),
            assetLoader: CodegenLoader(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: MyApp()
            ),
      )
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Kayo Logistic Customer',
      theme: theme(),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
