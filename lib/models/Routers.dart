// To parse this JSON data, do
//
//     final salesOrders = salesOrdersFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Routers Routers_brandFromJson(String str) => Routers.fromJson(json.decode(str));


class Routers {
  Routers({
    required this.DriverID             ,
    required this.PassengerId,
    required this.PickupLatitud,
    required this.PickupLongtide,
    required this.PickupLocationName,
    required this.DropOffLatitude,
    required this.DropOffLongitude,
    required this.DropOffLocationName,
    required this.DriverCofirmTime,
    required this.ArrivalTime,
    required this.DropOffTime,
    required this.RouterNote,
    required this.DriverRating,
    required this.PassangerRating,
    required this.Password,
    required this.KiloMeters,
    required this.AmountPaid,

  });

  String DriverID ;
  String PassengerId;
  String PickupLatitud;
  String PickupLongtide;
  String PickupLocationName;
  String DropOffLatitude;
  String DropOffLongitude;
  String DropOffLocationName;
  String DriverCofirmTime;
  String ArrivalTime;
  String DropOffTime;
  String RouterNote;
  String DriverRating;
  String PassangerRating;
  String Password;
  String KiloMeters;
  String AmountPaid;


  Routers.toDisplay({
    required this.DriverID             ,
    required this.PassengerId,
    required this.PickupLatitud,
    required this.PickupLongtide,
    required this.PickupLocationName,
    required this.DropOffLatitude,
    required this.DropOffLongitude,
    required this.DropOffLocationName,
    required this.DriverCofirmTime,
    required this.ArrivalTime,
    required this.DropOffTime,
    required this.RouterNote,
    required this.DriverRating,
    required this.PassangerRating,
    required this.Password,
    required this.KiloMeters,
    required this.AmountPaid,


  });

  factory Routers.fromJson(Map<String, dynamic> json) =>
      Routers(
          DriverID:json["DriverID"].toString(),
          PassengerId:json["PassengerId"].toString(),
          PickupLatitud:json["PickupLatitud"].toString(),
          PickupLongtide:json["PickupLongtide"].toString(),
          PickupLocationName:json["PickupLocationName"].toString(),
          DropOffLatitude:json["DropOffLatitude"].toString(),
          DropOffLongitude:json["DropOffLongitude"].toString(),
          DropOffLocationName:json["DropOffLocationName"].toString(),
          DriverCofirmTime:json["DriverCofirmTime"].toString(),
          ArrivalTime:json["ArrivalTime"].toString(),
          DropOffTime:json["DropOffTime"].toString(),
          RouterNote:json["RouterNote"].toString(),
          DriverRating:json["DriverRating"].toString(),
          PassangerRating:json["PassangerRating"].toString(),
          Password:json["Password"].toString(),
          KiloMeters:json["KiloMeters"].toString(),
          AmountPaid:json["AmountPaid"].toString(),

      );

  Map<String, dynamic> toMap() {
    return {
      "DriverID            ":DriverID,
      "PassengerId":PassengerId,
      "PickupLatitud":PickupLatitud,
      "PickupLongtide":PickupLongtide,
      "PickupLocationName":PickupLocationName,
      "DropOffLatitude":DropOffLatitude,
      "DropOffLongitude":DropOffLongitude,
      "DropOffLocationName":DropOffLocationName,
      "DriverCofirmTime":DriverCofirmTime,
      "ArrivalTime":ArrivalTime,
      "DropOffTime":DropOffTime,
      "RouterNote":RouterNote,
      "DriverRating":DriverRating,
      "PassangerRating":PassangerRating,
      "Password":Password,
      "KiloMeters":KiloMeters,
      "AmountPaid":AmountPaid,

    };
  }

  static List<Routers>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Routers>((json) =>Routers.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<Routers>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<Routers>((json) =>Routers.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
