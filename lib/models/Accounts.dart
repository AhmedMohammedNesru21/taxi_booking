
import 'dart:convert';

import 'package:flutter/cupertino.dart';

Accounts accounts_accountsFromJson(String str) => Accounts.fromJson(json.decode(str));


class Accounts {
  Accounts({
   required this.Aid,
   required this.Username,
   required this.Email,
   required this.Phone,
   required this.AccountType,
   required this.ReferalCodeApplied,
   required this.Password,
   required this.RoleID,
   required this.Status,
   required this.lastLogin,
   required this.otp,
   required this.AccountMiles,
   required this.NotificationStatus,
   required this.FullName,

  });

  String   Aid;
  String   Username;
  String   Email;
  String   Phone;
  String   AccountType;
  String   ReferalCodeApplied;
  String   Password;
  String   RoleID;
  String   Status;
  String   lastLogin;
  String   otp;
  String   AccountMiles;
  String   NotificationStatus;
  String   FullName;

  Accounts.toDisplay({
    required this.Aid,
    required this.Username,
    required this.Email,
    required this.Phone,
    required this.AccountType,
    required this.ReferalCodeApplied,
    required this.Password,
    required this.RoleID,
    required this.Status,
    required this.lastLogin,
    required this.otp,
    required this.AccountMiles,
    required this.NotificationStatus,
    required this.FullName,

  });

  factory Accounts.fromJson(Map<String, dynamic> json) =>
      Accounts(
        Aid:json["Aid"].toString(),
        Username:json["Username"].toString(),
        Email:json["Email"].toString(),
        Phone:json["Phone"].toString(),
        AccountType:json["AccountType"].toString(),
        ReferalCodeApplied:json["ReferalCodeApplied"].toString(),
        Password:json["Password"].toString(),
        RoleID:json["RoleID"].toString(),
        Status:json["Status"].toString(),
        lastLogin:json["lastLogin"].toString(),
        otp:json["otp"].toString(),
        AccountMiles:json["AccountMiles"].toString(),
        NotificationStatus:json["NotificationStatus"].toString(),
        FullName:json["FullName"].toString(),

        // lastModifiedDate :json["lastModifiedDate"],
        // isDeleted:json["isDeleted"].toString(),
      );

  Map<String, dynamic> toMap() {
    return {
      "Aid":Aid,
      "Username":Username,
      "Email":Email,
      "Phone":Phone,
      "AccountType":AccountType,
      "ReferalCodeApplied":ReferalCodeApplied,
      "Password":Password,
      "RoleID":RoleID,
      "Status":Status,
      "lastLogin":lastLogin,
      "otp":otp,
      "AccountMiles":AccountMiles,
      "NotificationStatus":AccountMiles,
      "FullName":FullName,

      // "lastModifiedDate":lastModifiedDate,
      // "isDeleted":isDeleted,
    };
  }

  static List<Accounts>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<Accounts>((json) =>Accounts.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<Accounts>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<Accounts>((json) =>Accounts.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}
