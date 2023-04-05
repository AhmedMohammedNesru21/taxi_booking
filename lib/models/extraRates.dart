import 'dart:convert';

import 'package:flutter/cupertino.dart';
ExtraRates ExtraRates_ExtraRatesFromJson(String str) => ExtraRates.fromJson(json.decode(str));
class ExtraRates
{
  ExtraRates({
    required this.Id,
     this.extraRateTypeId,
     this.rateName,
     this.rateValue,
     this.isFixed,
     this.formula,
     this.lastUpdatedDate,
     this.isDeleted
  });
  String Id;
  String? extraRateTypeId;
  String? rateName;
  String? rateValue;
  String? isFixed;
  String? formula;
  String? lastUpdatedDate;
  String? isDeleted;



  ExtraRates.toDisplay({
    required this.Id,
    required this.extraRateTypeId,
     this.rateName,
    required this.rateValue,
    required this.isFixed,
    required this.formula,
    required this.lastUpdatedDate,
    required this.isDeleted
  });

  factory ExtraRates.fromJson(Map<String, dynamic> json) =>
      ExtraRates(
        Id:json["Id"].toString(),
        rateName:json["rateName"],
        rateValue:json["rateValue"].toString(),
        extraRateTypeId:json["extraRateTypeId"].toString(),
        isFixed:json["isFixed"].toString(),
        formula:json["formula"].toString(),
        lastUpdatedDate:json["lastUpdatedDate"].toString(),
        isDeleted:json["isDeleted"].toString(),
        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      "Id":Id,
      "rateValue":rateValue,
      "rateName":rateName,
      "extraRateTypeId":extraRateTypeId,
      "isFixed":isFixed,
      "formula":formula,
      "lastUpdatedDate":lastUpdatedDate,
      "isDeleted":isDeleted,
    };
  }

  static List<ExtraRates>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<ExtraRates>((json) =>ExtraRates.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<ExtraRates>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<ExtraRates>((json) =>ExtraRates.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }

}