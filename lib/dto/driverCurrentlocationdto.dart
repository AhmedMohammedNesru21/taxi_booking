
import 'dart:convert';

class DriverCurrentLocation
{
  String userName;
  String passWord;
  String RouteId;
  String passengerId;
  String? Did;
  String? CurrentLatitude;
  String? CurrentLongitude;
  String? FullName;
  String? NewRouteId;
  String? RouteStatusId;
  DriverCurrentLocation({required this.userName, required this.passWord, required this.RouteId,
    required this.passengerId,this.Did,this.CurrentLatitude,this.CurrentLongitude,this.FullName,this.NewRouteId,this.RouteStatusId});
  DriverCurrentLocation.toRequest({required this.userName, required this.passWord, required this.RouteId,
    required this.passengerId, required this.Did,required this.CurrentLatitude,required this.CurrentLongitude,required this.FullName,required this.NewRouteId,required this.RouteStatusId});
  DriverCurrentLocation mapFromJson(String jsonData)=> DriverCurrentLocation.fromJson(jsonDecode(jsonData));
  String mapToJson(DriverCurrentLocation DriverCurrentLocation)=> jsonEncode(DriverCurrentLocation.toJson);

  factory DriverCurrentLocation.fromJson(Map<String, dynamic> jsonData)=>DriverCurrentLocation
    (
    userName:jsonData['userName'],
    passWord: jsonData['passWord'],
    RouteId: jsonData['RouteId'],
    passengerId: jsonData['passengerId'],
    Did:jsonData['Did'].toString(),
    CurrentLatitude:jsonData['CurrentLatitude'].toString(),
    CurrentLongitude:jsonData['CurrentLongitude'].toString(),
    FullName:jsonData['FullName'].toString(),
    NewRouteId:jsonData['NewRouteId'].toString(),
    RouteStatusId:jsonData['RouteStatusId'].toString(),
  );
  Map<String, dynamic> toJson() =>{
    "userName":userName,
    "passWord":passWord,
    "RouteId":RouteId,
    "passengerId":passengerId,
    "Did":Did,
    "CurrentLatitude":CurrentLatitude,
    "CurrentLongitude":CurrentLongitude,
    "FullName":FullName,
    "NewRouteId":NewRouteId,
    "RouteStatusId":RouteStatusId
  };
}
