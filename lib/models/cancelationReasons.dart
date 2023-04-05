

import 'dart:convert';

import 'package:flutter/cupertino.dart';

CancelationReasons CancelationReasons_brandFromJson(String str) => CancelationReasons.fromJson(json.decode(str));

class CancelationReasons {
  CancelationReasons({
    required this.Id,
    required this.reasonName,
    required this.reasonDescription,
    required this.remark,
    required this.isDeleted,
    required this.lastModifiedDate,
    // required this.lastModifiedDate ,
    // required this.isDeleted,

  });

  String Id  ;
  String reasonName;
  String reasonDescription;
  String remark;
  String isDeleted;
  String lastModifiedDate;

  CancelationReasons.toDisplay({
    required this.Id  ,
    required this.reasonName,
    required this.reasonDescription,
    required this.remark,
    required this.isDeleted,
    required this.lastModifiedDate,

  });

  factory CancelationReasons.fromJson(Map<String, dynamic> json) =>
      CancelationReasons(
        Id  :json["Id"].toString(),
        reasonName:json["reasonName"].toString(),
        reasonDescription:json["reasonDescription"].toString(),
        remark:json["remark"].toString(),
        isDeleted:json["isDeleted"].toString(),
        lastModifiedDate:json["lastModifiedDate"].toString(),


        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      "Id":Id,
      "reasonName":reasonName,
      "reasonDescription":reasonDescription,
      "remark":remark,
      "isDeleted":isDeleted,
      "lastModifiedDate":lastModifiedDate,


      // "lastModifiedDate":lastModifiedDate,
      // "isDeleted":isDeleted,
    };
  }

  static List<CancelationReasons>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<CancelationReasons>((json) =>CancelationReasons.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<CancelationReasons>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<CancelationReasons>((json) =>CancelationReasons.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
