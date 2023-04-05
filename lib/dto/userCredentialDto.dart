import 'dart:convert';
import 'package:flutter/cupertino.dart';
class UserCredentialDTO
{
  late String userName;
  late String passWord;
  late String email;
  late String fullName;
  late String phoneNumber;
  late String role;
  late String profileImage;
  late String isSuccess;
  late String OTP;
  UserCredentialDTO({required this.userName, required this.passWord, required this.email,
    required this.fullName, required this.phoneNumber, required this.role,
    required this.profileImage,required this.isSuccess,required this.OTP});
  UserCredentialDTO.toSend({required this.userName, required this.passWord, required this.phoneNumber,required this.role,required this.OTP});
  UserCredentialDTO mapFromJson(String jsonData)=> UserCredentialDTO.fromJson(jsonDecode(jsonData));
  String mapToJson(UserCredentialDTO userCredential)=> jsonEncode(userCredential.toJson);
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'passWord': passWord,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'role': role,
      'profileImage': profileImage,
      'isSuccess': isSuccess,
      'OTP':OTP,
    };
  }
  factory UserCredentialDTO.fromJson(Map<String, dynamic> jsonData)=>UserCredentialDTO
    (
    userName:jsonData['username'],
    passWord: jsonData['password'],
    email: jsonData['email'],
    fullName: jsonData['name'],
    phoneNumber: jsonData['phone_number'],
    role: jsonData['role'],
    profileImage: jsonData['image'],
    isSuccess: jsonData['isSuccess'].toString(),
    OTP:jsonData['OTP'].toString(),

  );
  Map<String, dynamic> toJson() =>{
    'username': userName,
    'password': passWord,
    'email': email,
    'name': fullName,
    'phone_number': phoneNumber,
    'role': role,
    'image': profileImage,
    'isSuccess':isSuccess,
    'OTP':OTP,
  };
  static List<UserCredentialDTO>? parseFromString(String responseBody)
  {
    try
    {
      final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
      return parsed.map<UserCredentialDTO>((json) =>UserCredentialDTO.fromJson(json)).toList();
    }
    catch(Exception)
    {
      return null;
    }

  }
  static List<UserCredentialDTO>? parseFromJsonArray(dynamic parsed)
  {
    try
    {
      return parsed.map<UserCredentialDTO>((json) =>UserCredentialDTO.fromJson(json)).toList();
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return null;
    }

  }
}