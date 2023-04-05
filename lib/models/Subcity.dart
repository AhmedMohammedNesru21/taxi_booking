import 'dart:convert';

import 'package:flutter/cupertino.dart';

class SubCity {
  int id;
  String Town_Name;
  String subcityUpdated;


  SubCity({
    required this.id,
    required this.Town_Name,
    required this.subcityUpdated,
  });
  factory SubCity.fromJson(Map<String, dynamic> json) =>
      SubCity(
        id:json["id"],
        Town_Name:json["Town_Name"].toString(),
        subcityUpdated:json["subcityUpdated"].toString()

      );

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "Town_Name":Town_Name,
      "subcityUpdated":subcityUpdated

    };
  }
  static List<SubCity>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<SubCity>((json) =>SubCity.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<SubCity>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<SubCity>((json) =>SubCity.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}