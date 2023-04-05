// To parse this JSON data, do
//
//     final salesOrders = salesOrdersFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Rates Rates_ratesFromJson(String str) => Rates.fromJson(json.decode(str));


class Rates {
  Rates({
    required this.Rid,
    required this.ratetypes,
    required this.rateWaitingTimePrice,
    required this.ratePerKilloMeterPrice,
    required this.rateNightWaitingTimePrice,
    required this.rateFormula,
    required this.isDirect,
    required this.lastUpdatedDate,
    required this.isDeleted,


  });

  String Rid;
  String ratetypes;
  String rateWaitingTimePrice;
  String ratePerKilloMeterPrice;
  String rateNightWaitingTimePrice;
  String rateFormula;
  String isDirect;
  String lastUpdatedDate;
  String isDeleted;

  Rates.toDisplay({
    required this.Rid,
    required this.ratetypes,
    required this.rateWaitingTimePrice,
    required this.ratePerKilloMeterPrice,
    required this.rateNightWaitingTimePrice,
    required this.rateFormula,
    required this.isDirect,
    required this.lastUpdatedDate,
    required this.isDeleted,

  });

  factory Rates.fromJson(Map<String, dynamic> json) =>
      Rates(
        Rid:json["Rid"].toString(),
        ratetypes:json["ratetypes"].toString(),
        rateWaitingTimePrice:json["rateWaitingTimePrice"].toString(),
        ratePerKilloMeterPrice:json["ratePerKilloMeterPrice"].toString(),
        rateNightWaitingTimePrice:json["rateNightWaitingTimePrice"].toString(),
        rateFormula:json["rateNightWaitingTimePrice"].toString(),
        isDirect:json["isDirect"].toString(),
        lastUpdatedDate :json["lastUpdatedDate"],
        isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      "Rid":Rid,
      "ratetypes":ratetypes,
      "rateWaitingTimePrice":rateWaitingTimePrice,
      "ratePerKilloMeterPrice":ratePerKilloMeterPrice,
      "rateNightWaitingTimePrice":rateNightWaitingTimePrice,
      "rateFormula":rateFormula,
      "isDirect":isDirect,
      "lastUpdatedDate":lastUpdatedDate,
      "isDeleted":isDeleted,
    };
  }

  static List<Rates>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Rates>((json) =>Rates.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<Rates>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<Rates>((json) =>Rates.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
// Rates
