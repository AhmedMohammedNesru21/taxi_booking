
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homemap_form.dart';
import 'nearby_Map.dart';
class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              NearByMap(),
              Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: Icon(
                      Icons.person,
                      size: 35.0,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
            ],
          ),
          HomeMapForm(),
        ],
      ),
    );
  }
}


