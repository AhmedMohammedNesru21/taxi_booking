// To parse this JSON data, do
//
//     final salesOrders = salesOrdersFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

VehicleModels VehicleModels_VehicleModelsFromJson(String str) => VehicleModels.fromJson(json.decode(str));


class VehicleModels {
  VehicleModels({
    required this.Id,
    required this.modelName,
    required this.brandId,
    required this.lastUpdatedDate,
    required this.isDeleted,


  });

  String Id;
  String modelName;
  String brandId;
  String lastUpdatedDate;
  String isDeleted;





  // String lastModifiedDate ;
  // String isDeleted ;

  VehicleModels.toDisplay({
    required this.Id,
    required this.modelName,
    required this.brandId,
    required this.lastUpdatedDate,
    required this.isDeleted,

  });

  factory VehicleModels.fromJson(Map<String, dynamic> json) =>
      VehicleModels(

        Id:json["Id"].toString(),
        modelName:json["modelName"].toString(),
        brandId:json["brandId"].toString(),
        lastUpdatedDate:json["lastUpdatedDate"].toString(),
        isDeleted:json["isDeleted"].toString(),


        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {


      "Id":Id,
      "modelName":modelName,
      "brandId":brandId,
      "lastUpdatedDate":lastUpdatedDate,
      "isDeleted":isDeleted,


      // "lastModifiedDate":lastModifiedDate,
      // "isDeleted":isDeleted,
    };
  }

  static List<VehicleModels>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<VehicleModels>((json) =>VehicleModels.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<VehicleModels>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<VehicleModels>((json) =>VehicleModels.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
