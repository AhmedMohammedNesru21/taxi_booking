
import 'dart:convert';

import 'package:taxi_booking/models/RideDetails.dart';


class DriverRequestDetailsDto
{
  String userName;
  String passWord;
  String imei;
  int Is_Success;
  late List<DriverRequestDetails> driverRequestDetails;
  DriverRequestDetailsDto({required this.userName, required this.passWord, required this.imei,
    required this.Is_Success, required this.driverRequestDetails});
  DriverRequestDetailsDto.toRequest({required this.userName, required this.passWord, required this.imei,
    required this.Is_Success});
  DriverRequestDetailsDto mapFromJson(String jsonData)=> DriverRequestDetailsDto.fromJson(jsonDecode(jsonData));
  String mapToJson(DriverRequestDetailsDto driversRequestDto)=> jsonEncode(driversRequestDto.toJson);

  factory DriverRequestDetailsDto.fromJson(Map<String, dynamic> jsonData)=>DriverRequestDetailsDto
    (
    userName:jsonData['userName'],
    passWord: jsonData['passWord'],
    imei: jsonData['imei'],
    Is_Success:jsonData['Is_Success'],
    driverRequestDetails:DriverRequestDetails.parseFromJsonArray(jsonData['driverRequestDetails'])!,

  );
  Map<String, dynamic> toJson() =>{
    'userName': userName,
    'passWord': passWord,
    'imei': imei,
    'driverRequestDetails': driverRequestDetails,
  };
}