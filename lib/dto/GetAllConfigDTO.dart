

import 'dart:convert';

import 'package:taxi_booking/models/Rates.dart';
import 'package:taxi_booking/models/Region.dart';
import 'package:taxi_booking/models/Service.dart';
import 'package:taxi_booking/models/Subcity.dart';
import 'package:taxi_booking/models/Wereda.dart';
import 'package:taxi_booking/models/routeStatuses.dart';
import 'package:taxi_booking/models/extraRateTypes.dart';
import 'package:taxi_booking/models/extraRates.dart';
import 'package:taxi_booking/models/vehicleModels.dart';
import 'package:taxi_booking/models/cancelationReasons.dart';


class GetAllConfigDTO {
  String userName;
  String passWord;
  String imei;
  String ratesLastUpdated;
  String regionsLastUpdated;
  String subCityModelLastUpdated;
  String woredaLastUpdated;
  String serviceLastUpdated;
  String routeStatusLastUpdated;
  String vehicleModelLastUpdated;
  String extraRateTypesLastUpdated;
  String extraRatesLastUpdated;
  String cancelationReasonsLastUpdated;
  late List<Rates> rates;
  late List<Region> regions;
  late List<SubCity> subCitys;
  late List<Wereda> woredas;
  late List<Service> services;
  late List<RouteStatuses> routeStatuses;
  late List<ExtraRateTypes> extraRateTypes;
  late List<ExtraRates>   extraRates;
  late List<VehicleModels> vehicleModels;
  late List<CancelationReasons> cancelationReasons;

  GetAllConfigDTO({required this.userName, required this.passWord, required this.imei,
    required this.ratesLastUpdated, required this.regionsLastUpdated,required this.subCityModelLastUpdated,required this.woredaLastUpdated,required this.serviceLastUpdated,
    required this.routeStatusLastUpdated,required this.vehicleModelLastUpdated,required this.extraRateTypesLastUpdated,required this.extraRatesLastUpdated,
    required this.cancelationReasonsLastUpdated,
    required this.rates, required this.regions, required this.subCitys,required this.woredas,required this.services,required this.routeStatuses,
    required this.cancelationReasons,required this.extraRates,required this.extraRateTypes,required this.vehicleModels});

  GetAllConfigDTO.toSend({required this.userName, required this.passWord, required this.imei,
    required this.ratesLastUpdated, required this.regionsLastUpdated,required this.subCityModelLastUpdated,required this.woredaLastUpdated,required this.serviceLastUpdated,
    required this.routeStatusLastUpdated,required this.vehicleModelLastUpdated,required this.extraRateTypes, required this.extraRateTypesLastUpdated, required this.extraRatesLastUpdated,
    required this.cancelationReasonsLastUpdated,
    // required this.rates, required this.regions, required this.subCitys,required this.woredas,required this.services,required this.routeStatuses,
    // required this.cancelationReasons,required this.extraRates,required this.extraRateTypes,required this.vehicleModels
  });
  GetAllConfigDTO mapFromJson(String jsonData)=> GetAllConfigDTO.fromJson(jsonDecode(jsonData));
  String mapToJson(GetAllConfigDTO getAllConfigDTO)=> jsonEncode(getAllConfigDTO.toJson);





  factory GetAllConfigDTO.fromJson(Map<String, dynamic> jsonData)=>GetAllConfigDTO
    (

    userName:jsonData['userName'],
    passWord: jsonData['passWord'],
    imei: jsonData['imei'],
    ratesLastUpdated:jsonData['ratesLastUpdated'],
    regionsLastUpdated:jsonData['regionsLastUpdated'],
    subCityModelLastUpdated:jsonData['subCityModelLastUpdated'],
    woredaLastUpdated:jsonData['woredaLastUpdated'],
    serviceLastUpdated:jsonData['serviceLastUpdated'],
    routeStatusLastUpdated:jsonData['routeStatusLastUpdated'],
    vehicleModelLastUpdated:jsonData['vehicleModelLastUpdated'],
    extraRateTypesLastUpdated:jsonData['extraRateTypesLastUpdated'],
    extraRatesLastUpdated:jsonData['extraRatesLastUpdated'],
    cancelationReasonsLastUpdated:jsonData['cancelationReasonsLastUpdated'],
    rates:Rates.parseFromJsonArray(jsonData['rates'])!,
    regions:Region.parseFromJsonArray(jsonData['regions'])!,
    subCitys:SubCity.parseFromJsonArray(jsonData['subCitys'])!,
    woredas:Wereda.parseFromJsonArray(jsonData['woredas'])!,
    services:Service.parseFromJsonArray(jsonData['services'])!,
    routeStatuses:RouteStatuses.parseFromJsonArray(jsonData['routeStatuses'])!,
    extraRateTypes:ExtraRateTypes.parseFromJsonArray(jsonData['extraRateTypes'])!,
    extraRates:ExtraRates.parseFromJsonArray(jsonData['extraRates'])!,
    vehicleModels:VehicleModels.parseFromJsonArray(jsonData['vehicleModels'])!,
    cancelationReasons:CancelationReasons.parseFromJsonArray(jsonData['cancelationReasons'])!


  );
  Map<String, dynamic> toJson() =>{
    'userName': userName,
    'passWord': passWord,
    'imei': imei,
    'ratesLastUpdated':ratesLastUpdated,
    'regionsLastUpdated':regionsLastUpdated,
    'subCityModelLastUpdated':subCityModelLastUpdated,
    'woredaLastUpdated':woredaLastUpdated,
    'serviceLastUpdated':serviceLastUpdated,
    'routeStatusLastUpdated':routeStatusLastUpdated,
    'vehicleModelLastUpdated':vehicleModelLastUpdated,
    'extraRateTypesLastUpdated':extraRateTypesLastUpdated,
    'extraRatesLastUpdated':extraRatesLastUpdated,
    'cancelationReasonsLastUpdated':cancelationReasonsLastUpdated,
  };
}