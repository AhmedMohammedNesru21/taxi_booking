import 'package:flutter/material.dart';

import 'components/body.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
class MapViewScreen extends StatelessWidget {
  static String routeName = "/MapView_in";
  AppData appData = AppData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map View"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Body(),
    );
  }
}