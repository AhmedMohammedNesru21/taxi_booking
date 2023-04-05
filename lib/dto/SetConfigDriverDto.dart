
import 'dart:convert';

import 'package:taxi_booking/models/Drivers.dart';


class DriversDto
{
  String userName;
  String passWord;
  String imei;
  int Is_Success;
  String Did;
  String AccountId;
  String status;
  String isOnline;
  String Balance;
  String AverageRating;
 // List<Drivers> drivers;
  DriversDto({required this.userName, required this.passWord, required this.imei,
     required this.Is_Success, required this.Did,required this.status,required this.AccountId,required this.AverageRating,required this.isOnline,required this.Balance});
  DriversDto.toRequest({required this.userName, required this.passWord, required this.imei,
     required this.Is_Success,required this.Did,required this.status,required this.AccountId,required this.AverageRating,required this.isOnline,required this.Balance});
  DriversDto mapFromJson(String jsonData)=> DriversDto.fromJson(jsonDecode(jsonData));
  String mapToJson(DriversDto driversDto)=> jsonEncode(driversDto.toJson);

  factory DriversDto.fromJson(Map<String, dynamic> jsonData)=>DriversDto
    (
    userName:jsonData['userName'],
    passWord: jsonData['passWord'],
    imei: jsonData['imei'],
    Is_Success:jsonData['Is_Success'],
    Did:jsonData['Did'].toString(),
    AccountId:jsonData['AccountId'].toString(),
    status:jsonData['status'].toString(),
    isOnline:jsonData['isOnline'].toString(),
    Balance:jsonData['Balance'].toString(),
    AverageRating:jsonData['AverageRating'].toString(),

  );
  Map<String, dynamic> toJson() =>{
   'userName': userName,
   'passWord': passWord,
   'imei': imei,
    'Did':Did,
    'AccountId':AccountId,
    'status':status,
    'isOnline':isOnline,
    'Balance':Balance,
    'AverageRating':AverageRating,
  };
}