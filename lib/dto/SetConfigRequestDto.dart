
import 'dart:convert';

import 'package:taxi_booking/models/ChinetRequest.dart';
import 'package:taxi_booking/models/Drivers.dart';


class ChinetRequestDto
{
  String userName;
  String password;
 // String imei;
  String isSuccess;
  String lastModified;
  String createdAt;
  String Did;
  String Dropofflatitude;
  String Dropofflongitude;
  String Pickuplatitude;
  String Pickuplongitude;
  String DropoffAddress;
  String PickupAddress;
  String passengerId;
  String requestId;
  String statusId;
  String RouteId;
  String FullName;
  String Phone;
  String RouteStatusId;
  String DriverConfirmTime;
  String ArrivalTime;
  String DropOffTime;
  String ReasonId;
  String Killometers;
  String AmountPaid;
  String MilesPaid;
  String IsPaid;
 // String extraRateValue;
  String ExtraRates;
  String scheduleddate;
  String scheduledtime;

  ChinetRequestDto({required this.userName, required this.password,
    required this.isSuccess, required this.lastModified,required this.createdAt,required this.Did,required this.DropoffAddress,required this.Dropofflatitude,required this.Dropofflongitude,required this.passengerId,required this.requestId,required this.PickupAddress,required this.Pickuplatitude,required this.Pickuplongitude,required this.statusId,
    required this.RouteId,
    required this.FullName,
    required this.Phone,
    required this.RouteStatusId,
    required this.DriverConfirmTime,
    required this.ArrivalTime,
    required this.DropOffTime,
    required this.ReasonId,
    required this.Killometers,
    required this.AmountPaid,
    required this.MilesPaid,
    required this.IsPaid,
    //this.extraRateValue,
    required this.ExtraRates,
    required this.scheduleddate,
    required this.scheduledtime,
  });
  ChinetRequestDto.toRequest({required this.userName, required this.password,
    required this.isSuccess,required this.lastModified,required this.createdAt,required this.Did,required this.DropoffAddress,required this.Dropofflatitude,required this.Dropofflongitude,required this.passengerId,required this.requestId,required this.PickupAddress,required this.Pickuplatitude,required this.Pickuplongitude,required this.statusId,
    required this.RouteId,
    required this.FullName,
    required this.Phone,
    required this.RouteStatusId,
    required this.DriverConfirmTime,
    required this.ArrivalTime,
    required this.DropOffTime,
    required this.ReasonId,
    required this.Killometers,
    required this.AmountPaid,
    required this.MilesPaid,
    required this.IsPaid,
   // required this.extraRateValue,
    required this.ExtraRates,
    required this.scheduleddate,
    required this.scheduledtime,});
  ChinetRequestDto mapFromJson(String jsonData)=> ChinetRequestDto.fromJson(jsonDecode(jsonData));
  String mapToJson(ChinetRequestDto ChinetRequestDto)=> jsonEncode(ChinetRequestDto.toJson);

  factory ChinetRequestDto.fromJson(Map<String, dynamic> jsonData)=>ChinetRequestDto
    (
    userName:jsonData['userName'],
    password: jsonData['password'],
    //imei: jsonData['imei'].toString(),
    isSuccess:jsonData['isSuccess'].toString(),
    lastModified:jsonData['lastModified'].toString(),
    createdAt:jsonData['createdAt'].toString(),
    Did:jsonData['Did'].toString(),
    DropoffAddress:jsonData['DropoffAddress'].toString(),
    Dropofflatitude:jsonData['Dropofflatitude'].toString(),
    Dropofflongitude:jsonData['Dropofflongitude'].toString(),
    passengerId:jsonData['passengerId'].toString(),
    requestId:jsonData['requestId'].toString(),
    PickupAddress:jsonData['PickupAddress'].toString(),
    Pickuplatitude:jsonData['Pickuplatitude'].toString(),
    Pickuplongitude:jsonData['Pickuplongitude'].toString(),
    statusId:jsonData['statusId'].toString(),
    RouteId:jsonData['RouteId'].toString(),
    FullName:jsonData['FullName'].toString(),
    Phone:jsonData['Phone'].toString(),
    RouteStatusId:jsonData['RouteStatusId'].toString(),
    DriverConfirmTime:jsonData['DriverConfirmTime'].toString(),
    ArrivalTime:jsonData['ArrivalTime'].toString(),
    DropOffTime:jsonData['DropOffTime'].toString(),
    ReasonId:jsonData['ReasonId'].toString(),
    Killometers:jsonData['Killometers'].toString(),
    AmountPaid:jsonData['AmountPaid'].toString(),
    MilesPaid:jsonData['MilesPaid'].toString(),
    IsPaid:jsonData['IsPaid'].toString(),
    //extraRateValue:jsonData['extraRateValue'].toString(),
    ExtraRates:jsonData['ExtraRates'].toString(),
    scheduleddate:jsonData["scheduleddate"],
    scheduledtime:jsonData["scheduledtime"].toString(),

  // chinetrequest:ChinetRequest.parseFromJsonArray(jsonData['chinetrequest']),

  );
  Map<String, dynamic> toJson() =>{
    'userName': userName,
    'password': password,
   // 'imei': imei,
    'isSuccess':isSuccess,
    'lastModified':lastModified,
    'createdAt':createdAt,
    'Did':Did,
    'Dropofflatitude':Dropofflatitude,
    'Dropofflongitude':Dropofflongitude,
    'Pickuplatitude':Pickuplatitude,
    'Pickuplongitude':Pickuplongitude,
    'DropoffAddress':DropoffAddress,
    'PickupAddress':PickupAddress,
    'passengerId':passengerId,
    'requestId':requestId,
    'statusId':statusId,
    'RouteId':RouteId,
    'FullName':FullName,
    'Phone':Phone,
    'RouteStatusId':RouteStatusId,
    'DriverConfirmTime':DriverConfirmTime,
    'ArrivalTime':ArrivalTime,
    'DropOffTime':DropOffTime,
    'ReasonId':ReasonId,
    'Killometers':Killometers,
    'AmountPaid':AmountPaid,
    'MilesPaid':MilesPaid,
    'IsPaid': IsPaid,
  //  'extraRateValue':extraRateValue,
    'ExtraRates':ExtraRates,
    "scheduleddate":scheduleddate,
    "scheduledtime":scheduledtime,

  };
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'password': password,
      //'imei': imei,
      'isSuccess':isSuccess,
      'lastModified':lastModified,
      'createdAt':createdAt,
      'Did':Did,
      'Dropofflatitude':Dropofflatitude,
      'Dropofflongitude':Dropofflongitude,
      'Pickuplatitude':Pickuplatitude,
      'Pickuplongitude':Pickuplongitude,
      'DropoffAddress':DropoffAddress,
      'PickupAddress':PickupAddress,
      'passengerId':passengerId,
      'requestId':requestId,
      'statusId':statusId,
      'RouteId':RouteId,
      'FullName':FullName,
      'Phone':Phone,
      'RouteStatusId':RouteStatusId,
      'DriverConfirmTime':DriverConfirmTime,
      'ArrivalTime':ArrivalTime,
      'DropOffTime':DropOffTime,
      'ReasonId':ReasonId,
      'Killometers':Killometers,
      'AmountPaid':AmountPaid,
      'MilesPaid':MilesPaid,
      'IsPaid': IsPaid,
      //'extraRateValue':extraRateValue,
      'ExtraRates':ExtraRates,
      "scheduleddate":scheduleddate,
      "scheduledtime":scheduledtime,

    };
  }
}