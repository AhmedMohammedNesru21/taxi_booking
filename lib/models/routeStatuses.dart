// To parse this JSON data, do
//
//     final salesOrders = salesOrdersFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

RouteStatuses RouteStatuses_brandFromJson(String str) => RouteStatuses.fromJson(json.decode(str));


class RouteStatuses {
  RouteStatuses({
    required this.Id,
    required this.routeStatusName,
    required this.lastUpdatedDate,
    required this.isDeleted,

  });

  String Id         ;
  String routeStatusName;
  String lastUpdatedDate;
  String isDeleted;



  // String lastModifiedDate ;
  // String isDeleted ;

  RouteStatuses.toDisplay({
    required this.Id,
    required this.routeStatusName,
    required this.lastUpdatedDate,
    required this.isDeleted,

  });

  factory RouteStatuses.fromJson(Map<String, dynamic> json) =>
      RouteStatuses(
        Id:json["Id"].toString(),
        routeStatusName:json["routeStatusName"].toString(),
        lastUpdatedDate:json["lastUpdatedDate"].toString(),
        isDeleted:json["isDeleted"].toString(),

        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      "Id":Id.toString(),
      "routeStatusName":routeStatusName.toString(),
      "lastUpdatedDate":lastUpdatedDate.toString(),
      "isDeleted":isDeleted.toString(),

    };
  }

  static List<RouteStatuses>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<RouteStatuses>((json) =>RouteStatuses.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<RouteStatuses>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<RouteStatuses>((json) =>RouteStatuses.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}