import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverRequestDetails
{
  LatLng pickup;
  String ride_request_id;
  String payment_method;
  LatLng dropoff;
  String status;
  String driver_name;
  String driver_phone;
  String driver_id;
  LatLng driver_location;

  DriverRequestDetails({
    required this.ride_request_id,
    required this.pickup,
    required this.payment_method,
    required this.dropoff,
    required this.status,
    required this.driver_name,
    required this.driver_phone,
    required this.driver_id,
    required this.driver_location
  });

  DriverRequestDetails.toDisplay({
    required this.ride_request_id,
    required this.pickup,
    required this.payment_method,
    required this.dropoff,
    required this.status,
    required this.driver_name,
    required this.driver_phone,
    required this.driver_id,
    required this.driver_location
  });

  factory DriverRequestDetails.fromJson(Map<String, dynamic> json) =>
      DriverRequestDetails(
        ride_request_id:json["ride_request_id"].toString(),
        pickup:json["pickup"],
        dropoff:json["dropoff"],
        status:json["status"].toString(),
        payment_method:json["payment_method"].toString(),
        driver_name:json["driver_name"].toString(),
        driver_phone:json["driver_phone"].toString(),
        driver_id:json["driver_id"].toString(),
        driver_location:json["driver_location"],
        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      "ride_request_id":ride_request_id,
      "pickup":pickup,
      "status":status,
      "dropoff":dropoff,
      "payment_method":payment_method,
      "driver_name":driver_name,
      "driver_phone":driver_phone,
      "driver_id":driver_id,
      "driver_location":driver_location,
    };
  }

  static List<DriverRequestDetails>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<DriverRequestDetails>((json) =>DriverRequestDetails.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<DriverRequestDetails>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<DriverRequestDetails>((json) =>DriverRequestDetails.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}