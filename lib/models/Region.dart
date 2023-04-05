
import 'dart:convert';

import 'package:flutter/cupertino.dart';
// String ratesUpdated;
// String regionUpdated;
// String subcityUpdated;
// String weredaUpdated;
// String serviceUpdate;
Region region_accountsFromJson(String str) => Region.fromJson(json.decode(str));
class Region {
  int id;
  String Region_Name;
  String regionUpdated;


  Region({
    required this.id,
    required this.Region_Name,
    required this.regionUpdated
   });
  factory Region.fromJson(Map<String, dynamic> json) =>
      Region(
        id:json["id"],
        Region_Name:json["Region_Name"].toString(),
          regionUpdated:json["regionUpdated"].toString()
    
      );

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "Region_Name":Region_Name,
      "regionUpdated":regionUpdated,
  
    };
  }
  static List<Region>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Region>((json) =>Region.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<Region>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<Region>((json) =>Region.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }

}