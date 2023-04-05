import 'dart:convert';
import 'package:flutter/cupertino.dart';
class SetRegisterPassengerDto
{

  String userName;
  String password;
  String isSuccess;
  String lastModified;
  String AId;
  String Email;
  String ReferalCode;
  String RoleID;
  String StatusId;
  String otp;
  String AccountMiles;
  String NotificationStatusId;
  String FullName;
  String Phone;
  String PassengerId;

  SetRegisterPassengerDto({required this.userName,
    required this.password,
    required this.isSuccess,
    required this.lastModified,
    required this.AId,
    required this.FullName,
    required this.Email,
    required this.ReferalCode,
    required this.RoleID,
    required this.StatusId,
    required this.otp,
    required this.AccountMiles,
    required this.NotificationStatusId,
    required this.Phone,
    required this.PassengerId
  }
  );
  SetRegisterPassengerDto.toSend({required this.userName,
    required this.password,
    required this.isSuccess,
    required this.lastModified,
    required this.AId,
    required this.FullName,
    required this.Email,
    required this.ReferalCode,
    required this.RoleID,
    required this.StatusId,
    required this.otp,
    required this.AccountMiles,
    required this.NotificationStatusId,
    required this.Phone,
    required this.PassengerId
 });
  SetRegisterPassengerDto mapFromJson(String jsonData)=> SetRegisterPassengerDto.fromJson(jsonDecode(jsonData));
  String mapToJson(SetRegisterPassengerDto userCredential)=> jsonEncode(userCredential.toJson);
  Map<String, dynamic> toMap() {
    return {
      'userName':userName,
      'password':password,
      'isSuccess':isSuccess,
      'lastModified':lastModified,
      'AId':PassengerId,
      'FullName':FullName,
      'Email':Email,
      'ReferalCode':ReferalCode,
      'RoleID':RoleID,
      'StatusId':StatusId,
      'otp':otp,
      'AccountMiles':AccountMiles,
      'NotificationStatusId':NotificationStatusId,
      'Phone':Phone,
      'PassengerId':PassengerId

    };
  }
  factory SetRegisterPassengerDto.fromJson(Map<String, dynamic> jsonData)=>SetRegisterPassengerDto
    (
    userName:jsonData['userName'],
    password:jsonData['password'],
    isSuccess:jsonData['isSuccess'].toString(),
    lastModified:jsonData['lastModified'].toString(),
    AId:jsonData['AId'].toString(),
    FullName:jsonData['FullName'],
    Email:jsonData['Email'].toString(),
    ReferalCode:jsonData['ReferalCode'].toString(),
    RoleID:jsonData['RoleID'].toString(),
    StatusId:jsonData['StatusId'].toString(),
    otp:jsonData['otp'].toString(),
    AccountMiles:jsonData['AccountMiles'].toString(),
    NotificationStatusId:jsonData['NotificationStatusId'].toString(),
    Phone:jsonData['Phone'].toString(),
    PassengerId:jsonData['PassengerId'].toString(),

  );
  Map<String, dynamic> toJson() =>{
    'userName':userName,
    'password':password,
    'isSuccess':isSuccess,
    'lastModified':lastModified,
    'AId':AId,
    'FullName':FullName,
    'Email':Email,
     'ReferalCode':ReferalCode,
    'RoleID':RoleID,
    'StatusId':StatusId,
    'otp':otp,
    'AccountMiles':AccountMiles,
    'NotificationStatusId':NotificationStatusId,
    'Phone':Phone,
    'PassengerId':PassengerId

  };
  static List<SetRegisterPassengerDto>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<SetRegisterPassengerDto>((json) =>SetRegisterPassengerDto.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<SetRegisterPassengerDto>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<SetRegisterPassengerDto>((json) =>SetRegisterPassengerDto.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}