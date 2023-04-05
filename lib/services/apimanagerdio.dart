
import 'dart:convert';
import 'dart:io';
import 'package:taxi_booking/dto/GetAllConfigDTO.dart';
import 'package:taxi_booking/dto/SendEmailpassDot.dart';
import 'package:taxi_booking/dto/SetConfigDriverDto.dart';
import 'package:taxi_booking/dto/SetConfigRequestDto.dart';
import 'package:taxi_booking/dto/SetDriverRequestDetailsDto.dart';
import 'package:taxi_booking/dto/SetRegisterPassangerDto.dart';
import 'package:taxi_booking/dto/driverCurrentlocationdto.dart';
import 'package:taxi_booking/repository/db_service.dart';
import 'package:taxi_booking/dto/userCredentialDto.dart';
import 'package:dio/dio.dart';

import '../constants.dart';

class APIManagerDio {
  var _dbService=DBService();

  String baseUrl=APIUrls.domainname;

  Future<SendEmailPassDto> setSendEmailPassDto(SendEmailPassDto emailData) async
  {
    SendEmailPassDto setEmailConfigs;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/forgetPassword',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(emailData),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        setEmailConfigs=SendEmailPassDto.fromJson(parsedData);

      }
      else
      {
        throw Exception(response.statusMessage);
      }

    }
    catch(e)
    {
      throw e.toString();
    }
    return setEmailConfigs;

  }

  Future<SetRegisterPassengerDto> setRegisterPassengerDto(SetRegisterPassengerDto driverData) async
  {
    SetRegisterPassengerDto setDriverConfigs;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/registerPassenger',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(driverData),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        setDriverConfigs=SetRegisterPassengerDto.fromJson(parsedData);

      }
      else
      {
        throw Exception(response.statusMessage);
      }

    }
    catch(e)
    {
      throw e.toString();
    }
    return setDriverConfigs;

  }
  Future<SetRegisterPassengerDto> updateRegisterPassengerDto(SetRegisterPassengerDto driverData) async
  {
    SetRegisterPassengerDto setDriverConfigs;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/updateAccount',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(driverData),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        setDriverConfigs=SetRegisterPassengerDto.fromJson(parsedData);

      }
      else
      {
        throw Exception(response.statusMessage);
      }

    }
    catch(e)
    {
      throw e.toString();
    }
    return setDriverConfigs;

  }
  Future<DriverCurrentLocation> getDriverCurrentLocation(DriverCurrentLocation driverData) async
  {
    DriverCurrentLocation getDriverConfigs;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/getDriverInfo',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(driverData),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        getDriverConfigs=DriverCurrentLocation.fromJson(parsedData);

      }
      else
      {
        throw Exception(response.statusMessage);
      }

    }
    catch(e)
    {
      throw e.toString();
    }
    return getDriverConfigs;

  }

  Future<UserCredentialDTO> login(List<UserCredentialDTO> userCredentials) async
  {
    late UserCredentialDTO receivedUser;
    //var client=new http.Client();
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/login',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),

        data: jsonEncode(userCredentials),

      );
      if(response.statusCode==200 || response.statusCode==201)
      {
        List<dynamic> list = [];
        list = response.data.map((result) => new UserCredentialDTO.fromJson(result))
            .toList();
        if(list.length!=0) {
          for (int b = 0; b < list.length; b++) {
            receivedUser = list[b] as UserCredentialDTO;
          }
        }
        else
          {
            throw Exception("empty Data ");
          }
      }
      else
      {
        throw Exception(response.statusMessage);
      }
    }
    catch(e)
    {
      throw e.toString();
    }
    return receivedUser;

  }

  Future<GetAllConfigDTO> getConfig(GetAllConfigDTO configData) async
  {
    GetAllConfigDTO getAllConfigs;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/GetConfig',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(configData),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        List<GetAllConfigDTO> list = [];
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        getAllConfigs=GetAllConfigDTO.fromJson(parsedData);

      }
      else
      {
        throw Exception('Internet connection appear slow. please contact with administrator ');
      }

    }
    catch(e)
    {
      throw Exception('Internet connection appear slow. please contact with administrator ');
    }
    return getAllConfigs;

  }

  Future<DriversDto> setconfigDriver(DriversDto driverData) async
  {
    DriversDto setDriverConfigs;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/setDriver',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(driverData),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        setDriverConfigs=DriversDto.fromJson(parsedData);

      }
      else
      {
        throw Exception(response.statusMessage);
      }

    }
    catch(e)
    {
      throw e.toString();
    }
    return setDriverConfigs;

  }

  Future<DriverRequestDetailsDto> setDriverRequestAcceptDto(DriverRequestDetailsDto driverrequestData) async
  {
    DriverRequestDetailsDto setDriverrequestAccept=driverrequestData;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/setRequestAccept',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(setDriverrequestAccept),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        setDriverrequestAccept=DriverRequestDetailsDto.fromJson(parsedData);

      }
      else
      {
        throw Exception(response.statusMessage);
      }

    }
    catch(e)
    {
      throw e.toString();
    }
    return setDriverrequestAccept;

  }

  Future<ChinetRequestDto> setConfigRequest(ChinetRequestDto requestData) async
  {
    ChinetRequestDto setRequestConfigs;
    try
    {
      Response response = await Dio().post(
        baseUrl+'/API/setRequest',
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(requestData),
      );

      if(response.statusCode==200 || response.statusCode==201)
      {
        final parsedData = json.decode(response.toString()).cast<String, dynamic>();
        setRequestConfigs=ChinetRequestDto.fromJson(parsedData);

      }
      else
      {
        throw Exception(response.statusMessage);
      }

    }
    catch(e)
    {
      throw e.toString();
    }
    return setRequestConfigs;

  }


}




  //
  // Future<List<Vehicles>> getVehicleDto(GetVehiclesDTO vehicleData) async
  // {
  //   List<Vehicles> getvehicles=[];
  //   try
  //   {
  //     Response response = await Dio().post(
  //       baseUrl+'/API/getVehicles',
  //       options: Options(headers: {
  //         HttpHeaders.contentTypeHeader: "application/json",
  //       }),
  //       data: jsonEncode(vehicleData),
  //     );
  //
  //     if(response.statusCode==200 || response.statusCode==201)
  //     {
  //         List<dynamic> list = List();
  //         list = response.data.map((result) => new Vehicles.fromJson(result))
  //             .toList();
  //         if(list.length!=0) {
  //         for (int b = 0; b < list.length; b++) {
  //           Vehicles vehicles=list[b] as Vehicles;
  //          // await _dbService.insertvehicles(vehicles);
  //           getvehicles.add(vehicles);
  //         }
  //         }
  //         else
  //         {
  //         throw Exception("empty Data ");
  //         }
  //       // final parsedData = json.decode(response.toString()).cast<String, dynamic>();
  //       // getvehicles=GetVehiclesDTO.fromJson(parsedData);
  //
  //     }
  //     else
  //     {
  //       throw Exception(response.statusMessage);
  //     }
  //
  //
  //   }
  //   catch(e)
  //   {
  //     throw e.toString();
  //   }
  //   return getvehicles;
  //
  // }

