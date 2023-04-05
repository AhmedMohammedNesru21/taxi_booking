// To parse this JSON data, do
//
//     final salesOrders = salesOrdersFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

Service Service_brandFromJson(String str) => Service.fromJson(json.decode(str));


class Service {
  Service({
required this.Id,
required this.serviceName,
required this.lastUpdateDate,
required this.isDeleted,

  });

String Id         ;
String serviceName;
String lastUpdateDate;
String isDeleted;

  Service.toDisplay({
    required this.Id,
    required this.serviceName,
    required this.lastUpdateDate,
    required this.isDeleted,

  });

  factory Service.fromJson(Map<String, dynamic> json) =>
      Service(
          Id:json["Id"].toString(),
          serviceName:json["serviceName"].toString(),
          lastUpdateDate:json["lastUpdateDate"].toString(),
          isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      "Id":Id.toString(),
      "serviceName":serviceName.toString(),
      "lastUpdateDate":lastUpdateDate.toString(),
      "isDeleted":isDeleted.toString(),

    };
  }

  static List<Service>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Service>((json) =>Service.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<Service>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<Service>((json) =>Service.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
