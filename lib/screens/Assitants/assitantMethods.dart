
import 'dart:math';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:taxi_booking/models/address.dart';
import 'package:taxi_booking/models/direction%20_details.dart';
import 'package:taxi_booking/screens/Assitants/request_assitance.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import '../../constants.dart';


class AssistantMethods {

  Future<String> searchCordinateAddress(Position position, context) async {

    String placeAddress = "";
    String st1,st2,st3,st4;
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    print(url);

    var response = await RequestAssitant.getRequest(url);

    if (response != "failed"){
      placeAddress = response["results"][0]["formatted_address"];

      st1= response["results"][0]["address_components"][0]["long_name"];
      st2= response["results"][0]["address_components"][1]["long_name"];
      st3= response["results"][0]["address_components"][2]["long_name"];
      st4= response["results"][0]["address_components"][3]["long_name"];

      Address userPickUpAddress = new Address();
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.placeFormattedAddress = placeAddress;
      userPickUpAddress.placeName = st1+" "+st2+ " "+st3+ " "+st4;
      print("${userPickUpAddress.placeName}");


      Provider.of<AppData>(context, listen: false).upadatePickUpLocationAddress(userPickUpAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails?> obtainPlaceDirection(LatLng initialPosition, LatLng finalPosition) async{
    String directionUrl ="https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";
    var res = await RequestAssitant.getRequest(directionUrl);

    if(res == "failed" ){
      return null;
    }
    DirectionDetails directionDetails  = DirectionDetails();
    directionDetails.encodedPoints = res["routes"][0]["overview_polyline"]["points"];
    directionDetails.distanceText = res["routes"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue = res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText = res["routes"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue = res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;

  }
  static int calculateFares(DirectionDetails directionDetails)
  {
    double timeTraveledFare=(directionDetails.durationValue!/60)*7;
    double distanceTravedFare=(directionDetails.distanceValue!/1000)*7;
    double totalFareAmount=timeTraveledFare+distanceTravedFare;

    return totalFareAmount.truncate();
  }

  static void getCurrentOnlineUserInfo() async
  {
    // firbaseUser =await FirebaseAuth.instance.currentUser;
    // String userId=firbaseUser.uid;
    // DatabaseReference reference=FirebaseDatabase.instance.reference().child("users").child(userId);
    // reference.once().then((DataSnapshot dataSnapshot){
    //   if(dataSnapshot.value!=null)
    //     {
    //       userCurrentInfo=Users.fromSnapshote(dataSnapshot);
    //     }
    //
    // });
  }

  static double creatRandomNumber(int num)
  {
    var random=Random();
    int radNumber=random.nextInt(num);
    return radNumber.toDouble();
  }

}