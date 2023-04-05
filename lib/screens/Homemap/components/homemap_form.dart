import 'package:taxi_booking/models/place_prediction.dart';
import 'package:taxi_booking/screens/Assitants/request_assitance.dart';
import 'package:taxi_booking/screens/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import 'package:provider/provider.dart';
import '/constants.dart';
import '/size_config.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeMapForm extends StatefulWidget {
  @override
  _HomeMapFormState createState() => _HomeMapFormState();
}

class _HomeMapFormState extends State<HomeMapForm> {

  AppData appData = AppData();
  bool remember = false;
  late LatLng myLocation;
  late String placeAddress;
  late String meterNumber;
  final List<String> errors = [];
  List<PlacePrediction> placePickUpPredictionList = [];


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

  TextFormField buildNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      onSaved: (newValue) => meterNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kkmNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kkmNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Number",
        hintText: "meter",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,

      ),
    );
  }
  void findPickUpPlace(String placeName) async {
    try {
      if (placeName.length > 1) {
        String autoComplete =
            "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ET";

        var res = await RequestAssitant.getRequest(autoComplete);

        if (res == "failed") {
          return;
        }

        if (res["status"] == "OK") {
          var predictions = res["predictions"];
          var placeList = (predictions as List)
              .map((e) => PlacePrediction.fromJson(e))
              .toList();
          setState(() {
            placePickUpPredictionList = placeList;
          });
        }
      }
    }
    catch(ex)
    {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {


    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      //top: getProportionateScreenHeight(MediaQuery.of(context).size.height - 200.0),
      // child: AnimatedSize(
      //   //vsync: this,
      //   curve: Curves.bounceIn,
      //   duration: new Duration(milliseconds: 500),
      child:Container(
        height: getProportionateScreenWidth(130),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ), //width: width * 0.9,
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
                    height:getProportionateScreenWidth(40),

                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[300]!,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(15),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_city,
                          color: kPrimaryColor,
                        ),
                        Expanded(
                          child:

                          Text(

                            LocaleKeys.where_to.tr()+" ?",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: getProportionateScreenWidth(16),
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
              SizedBox(height: getProportionateScreenHeight(16),),

              Row(
                children: [
                  SizedBox(width: getProportionateScreenWidth(15),),
                  Icon(Icons.my_location_sharp, color: kPrimaryColor,),
                  SizedBox(width: getProportionateScreenWidth(10),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${
                          Provider
                              .of<AppData>(context)
                              .pickUpLocation != null ? Provider
                              .of<AppData>(context)
                              .pickUpLocation
                              ?.placeFormattedAddress
                              : ""
                      }", style: TextStyle(
                          fontSize: getProportionateScreenWidth(12)
                      ),),

                    ],
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );

  }
}
