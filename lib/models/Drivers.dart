
import 'dart:convert';

import 'package:flutter/cupertino.dart';

Drivers drivers_brandFromJson(String str) => Drivers.fromJson(json.decode(str));


class Drivers {
  Drivers({
   required this.Did              ,
   required this.AccountId,
   required this.status,
   required this.isOnline,
   required this.Balance,
   required this.AverageRating,



    // required this.lastModifiedDate ,
    // required this.isDeleted,

  });

  String Did             ;
  String AccountId;
  String status;
  String isOnline;
  String Balance;
  String AverageRating;

  Drivers.toDisplay({
    required this.Did              ,
    required this.AccountId,
    required this.status,
    required this.isOnline,
    required this.Balance,
    required this.AverageRating,

  });

  factory Drivers.fromJson(Map<String, dynamic> json) =>
      Drivers(
          Did:json["Did"].toString(),
          AccountId:json["AccountId"].toString(),
          status:json["status"].toString(),
          isOnline:json["isOnline"].toString(),
          Balance:json["Balance"].toString(),
          AverageRating:json["AverageRating"].toString(),

        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
     "Did":Did,
     "AccountId":AccountId,
     "status":status,
     "isOnline":isOnline,
     "Balance":Balance,
     "AverageRating":AverageRating,
    };
  }

  static List<Drivers>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Drivers>((json) =>Drivers.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<Drivers>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<Drivers>((json) =>Drivers.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
