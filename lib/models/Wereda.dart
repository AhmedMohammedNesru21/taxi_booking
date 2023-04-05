
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Wereda {
  int id;
  String Wereda_Name;
  String weredaUpdated;


  Wereda({
    required this.id,
    required this.Wereda_Name,
    required this.weredaUpdated
  });
  factory Wereda.fromJson(Map<String, dynamic> json) =>
      Wereda(
        id:json["id"],
        Wereda_Name:json["Wereda_Name"].toString(),
          weredaUpdated:json["weredaUpdated"].toString()
      );

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "Wereda_Name":Wereda_Name,
      "weredaUpdated":weredaUpdated

    };
  }
  static List<Wereda>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Wereda>((json) =>Wereda.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }
  }
  static List<Wereda>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<Wereda>((json) =>Wereda.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }
  }
}