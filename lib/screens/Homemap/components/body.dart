
import 'package:taxi_booking/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../home_Map_Screen.dart';
import 'homemap_form.dart';
import 'nearby_Map.dart';

class Body extends StatelessWidget {
  bool drawerOpen = true;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              // Container(
              //   margin: EdgeInsets.only(top: 20.0),
              // ),
              HomeMapPage(),

              Positioned(
                top: 38.0,
                left: 22.0,
                child: GestureDetector(
                  onTap: () {
                       Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22.0),
                      boxShadow: [
                        BoxShadow(color: Colors.black,
                            blurRadius: 6.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7,))
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon((drawerOpen) ? Icons.menu : Icons.close,
                        color: Colors.black,),
                      radius: 20.0,
                    ),

                  ),
                ),
              ),
              HomeMapForm(),

            ],
          ),

        ],
      ),
    );
  }
}


