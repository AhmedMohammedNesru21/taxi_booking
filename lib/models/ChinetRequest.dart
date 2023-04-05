import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ChinetRequest
{
  ChinetRequest({
    required this.Createdat,
    required this.Did,
    required this.Dropofflatitude,
    required this.Dropofflongitude,
    required this.Pickuplatitude,
    required this.Pickuplongitude,
    required this.DropoffAddress,
    required this.PickupAddress,
    required this.rider_name,

  });
  String Createdat;
  String Did;
  String Dropofflatitude;
  String Dropofflongitude;
  String Pickuplatitude;
  String Pickuplongitude;
  String DropoffAddress;
  String PickupAddress;
  String rider_name;
  ChinetRequest.toDisplay({
    required this.Createdat,
    required this.Did,
    required this.Dropofflatitude,
    required this.Dropofflongitude,
    required this.Pickuplatitude,
    required this.Pickuplongitude,
    required this.DropoffAddress,
    required this.PickupAddress,
    required this.rider_name,
  });

  factory ChinetRequest.fromJson(Map<String, dynamic> json) =>
      ChinetRequest(
          Createdat:json["Createdat"].toString(),
      Did:json["Did"].toString(),
      Dropofflatitude:json["Dropofflatitude"].toString(),
      Dropofflongitude:json["Dropofflongitude"].toString(),
      Pickuplatitude:json["Pickuplatitude"].toString(),
      Pickuplongitude:json["Pickuplongitude"].toString(),
      DropoffAddress:json["DropoffAddress"].toString(),
      PickupAddress:json["PickupAddress"].toString(),
      rider_name:json["rider_name"].toString(),


        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );
  Map<String, dynamic> toMap() {
    return {
    "Createdat":Createdat,
    "Did":Did,
    "Dropofflatitude":Dropofflatitude,
    "Dropofflongitude":Dropofflongitude,
    "Pickuplatitude":Pickuplatitude,
    "Pickuplongitude":Pickuplongitude,
    "DropoffAddress":DropoffAddress,
    "PickupAddress":PickupAddress,
    "rider_name":rider_name

      // "lastModifiedDate":lastModifiedDate,
      // "isDeleted":isDeleted,
    };
  }

  static List<ChinetRequest>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<ChinetRequest>((json) =>ChinetRequest.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<ChinetRequest>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<ChinetRequest>((json) =>ChinetRequest.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
