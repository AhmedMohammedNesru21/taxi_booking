import 'package:taxi_booking/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import '/constants.dart';
import '/size_config.dart';

class HomeMapForm extends StatefulWidget {
  @override
  _HomeMapFormState createState() => _HomeMapFormState();
}

class _HomeMapFormState extends State<HomeMapForm> {
  final _formKey = GlobalKey<FormState>();
  AppData appData = AppData();
  bool remember = false;
  late LatLng myLocation;
  late String placeAddress;
  late String meterNumber;
  final List<String> errors = [];




  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }



  @override
  Widget build(BuildContext context) {

    return  Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        height: SizeConfig.screenHeight * 0.15,

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [


              InkWell(
                onTap: () async
                {
                  var res = Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SearchScreen()),);
                  if (res == "obtainDirection") {

                  }
                },
                child: Hero(
                  tag: "Book now",
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Search ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenWidth(17),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: kPrimaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.006),


            ],
          ),),
      ),
    );

  }
}
