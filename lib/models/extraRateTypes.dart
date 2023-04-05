

import 'dart:convert';

import 'package:flutter/cupertino.dart';

ExtraRateTypes ExtraRateTypes_ExtraRateTypesFromJson(String str) => ExtraRateTypes.fromJson(json.decode(str));


class ExtraRateTypes {
  ExtraRateTypes({
    required this.Id,
    required this.rateName,
     this.lastUpdateDate,
    this.isDeleted

  });

  String  Id;
  String  rateName;
  String?  lastUpdateDate;
  String ? isDeleted;


  ExtraRateTypes.toDisplay({
    required this.Id,
    required this.rateName,
    required this.lastUpdateDate,
    required this.isDeleted

    // required this.lastModifiedDate ,
    // required this.isDeleted,

  });

  factory ExtraRateTypes.fromJson(Map<String, dynamic> json) =>
      ExtraRateTypes(
        Id:json["Id"].toString(),
        rateName:json["rateName"].toString(),
        lastUpdateDate:json["lastUpdateDate"].toString(),
        isDeleted:json["isDeleted"].toString(),


        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {

      "Id":Id,
      "rateName":rateName,
      "lastUpdateDate":lastUpdateDate,
      "isDeleted":isDeleted,

      // "lastModifiedDate":lastModifiedDate,
      // "isDeleted":isDeleted,
    };
  }

  static List<ExtraRateTypes>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<ExtraRateTypes>((json) =>ExtraRateTypes.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<ExtraRateTypes>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<ExtraRateTypes>((json) =>ExtraRateTypes.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
