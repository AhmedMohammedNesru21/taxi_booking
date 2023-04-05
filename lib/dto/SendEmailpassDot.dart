import 'dart:convert';
import 'package:flutter/cupertino.dart';
class SendEmailPassDto
{
  String username;
  String Password;
  String email;
  String OTP;
  int isSuccess;
  SendEmailPassDto({required this.username, required this.Password, required this.email,
    required this.OTP,required this.isSuccess});
  SendEmailPassDto.toSend({required this.username, required this.Password, required this.email,required this.OTP,required this.isSuccess});
  SendEmailPassDto mapFromJson(String jsonData)=> SendEmailPassDto.fromJson(jsonDecode(jsonData));
  String mapToJson(SendEmailPassDto userCredential)=> jsonEncode(userCredential.toJson);
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'Password': Password,
      'email': email,
      'OTP': OTP,
      'isSuccess':isSuccess,
    };
  }
  factory SendEmailPassDto.fromJson(Map<String, dynamic> jsonData)=>SendEmailPassDto
    (
    username:jsonData['username'],
    Password: jsonData['Password'],
    email: jsonData['email'],
    OTP: jsonData['OTP'],
    isSuccess:jsonData['isSuccess'],

  );
  Map<String, dynamic> toJson() =>{
    'username': username,
    'Password': Password,
    'email': email,
    'OTP': OTP,
    'isSuccess':isSuccess,
  };
  // static List<SendEmailPassDto> parseFromString(String responseBody)
  // {
  //   try
  //   {
  //     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //     return parsed.map<SendEmailPassDto>((json) =>SendEmailPassDto.fromJson(json)).toList();
  //   }
  //   catch(Exception)
  //   {
  //
  //   }
  //
  // }
  // static List<SendEmailPassDto> parseFromJsonArray(dynamic parsed)
  // {
  //   try
  //   {
  //     return parsed.map<SendEmailPassDto>((json) =>SendEmailPassDto.fromJson(json)).toList();
  //   }
  //   catch(Exception)
  //   {
  //     debugPrint(Exception.toString());
  //
  //   }
  //
  // }
}