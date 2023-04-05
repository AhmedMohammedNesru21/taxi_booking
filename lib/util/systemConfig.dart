

import 'package:taxi_booking/dto/GetAllConfigDTO.dart';
import 'package:taxi_booking/dto/SetConfigDriverDto.dart';
import 'package:taxi_booking/dto/SetConfigRequestDto.dart';
import 'package:taxi_booking/dto/SetRegisterPassangerDto.dart';
import 'package:taxi_booking/dto/userCredentialDto.dart';
import 'package:taxi_booking/models/Drivers.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SystemConfig {

  static Future<double?> getDoubleValuesSF(String itemName) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? stringValue = prefs.getDouble(itemName);
    return stringValue;
  }

  static Future<String?> getStringValuesSF(String itemName) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue = prefs.getString(itemName);
    return stringValue;
  }
  static Future<bool?> getBoolValuesSF(String itemName) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? stringValue = prefs.getBool(itemName);
    return stringValue;
  }
  static Future<bool> setSDoubleToSF(String itemName,double itemValue) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(itemName, itemValue);
    return true;
  }
  static Future<bool> setSBoolToSF(String itemName,bool itemValue) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(itemName, itemValue);
    return true;
  }
  static Future<bool> setStringToSF(String itemName,String itemValue) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(itemName, itemValue);
    return true;
  }
  static Future<bool> initializeSystemConfig() async
  {
    try {
      if (await getDoubleValuesSF("currentSliderValue") == null ||
          await getDoubleValuesSF("currentSliderValue") == 0) setSDoubleToSF(
          "currentSliderValue", 0);
      if (await getDoubleValuesSF("tracedSlideristance") == null ||
          await getDoubleValuesSF("tracedSlideristance") == 0) setSDoubleToSF(
          "tracedSlideristance", 0);
      if (await getDoubleValuesSF("gpsAccuracyValue") == null ||
          await getDoubleValuesSF("gpsAccuracyValue") == 0) setSDoubleToSF("gpsAccuracyValue", 0);
      if (await getStringValuesSF("languageValue") == null ||
          await getStringValuesSF("languageValue") == "languageValue") setStringToSF(
          "languageValue", "");
      if (await getStringValuesSF("themValue") == null ||
          await getStringValuesSF("themValue") == "themValue") setStringToSF(
          "themValue", "");
      if (await getStringValuesSF("baseUrl_prod") == null ||
          await getStringValuesSF("baseUrl_prod") == "") setStringToSF(
          "baseUrl_prod", "http://sales.dashenbeer.et");
      if (await getStringValuesSF("sync_date") == null ||
          await getStringValuesSF("sync_date") == "") setStringToSF(
          "sync_date", "");
      return true;
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return false;
    }
  }
  static void setLogout()
  {
    setStringToSF("userName","");
    setStringToSF("passWord","");
    setStringToSF("imei","");
    setStringToSF("fullName","");
    setStringToSF("phoneNumber","");
    setStringToSF("role","3");
    setStringToSF("profileImage","");
  }

  static Future<bool> setLogin(UserCredentialDTO loggedInUser) async
  {
    try
    {
      if(loggedInUser.userName!=null)await setStringToSF("userName",loggedInUser.userName);
      if(loggedInUser.passWord!=null)await setStringToSF("passWord",loggedInUser.passWord);
      if(loggedInUser.email!=null)await setStringToSF("email",loggedInUser.email);
      if(loggedInUser.fullName!=null)await setStringToSF("fullName",loggedInUser.fullName);
      if(loggedInUser.phoneNumber!=null)await setStringToSF("phoneNumber",loggedInUser.phoneNumber);
      if(loggedInUser.role!=null)await setStringToSF("role",loggedInUser.role);
      if(loggedInUser.OTP!=null)await setStringToSF("OTP",loggedInUser.OTP);
      if(loggedInUser.profileImage!=null)await setStringToSF("profileImage",loggedInUser.profileImage);
      return true;
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return false;
    }

  }
  static Future<bool> setPassengerId(SetRegisterPassengerDto passengerId) async
  {

      try
      {
        if(passengerId.PassengerId!=null)await setStringToSF("passengerId",passengerId.PassengerId);
        if(passengerId.Phone!=null)await setStringToSF("Phone",passengerId.Phone);
        if(passengerId.otp!=null)await setStringToSF("OTP",passengerId.otp);
        if(passengerId.Email!=null)await setStringToSF("Email",passengerId.Email);
        if(passengerId.FullName!=null)await setStringToSF("fullName",passengerId.FullName);
        if(passengerId.userName!=null)await setStringToSF("userName",passengerId.userName);
        return true;
      }
      catch(ex)
      {
        debugPrint(ex.toString());
        return false;
      }


  }
  static Future<bool> setConfigAll(GetAllConfigDTO condigAll) async
  {
    try
    {
      if(condigAll.ratesLastUpdated!=null)await setStringToSF("ratesLastUpdated",condigAll.ratesLastUpdated);
      if(condigAll.regionsLastUpdated!=null)await setStringToSF("regionsLastUpdated",condigAll.regionsLastUpdated);
      if(condigAll.subCityModelLastUpdated!=null)await setStringToSF("subCityModelLastUpdated",condigAll.subCityModelLastUpdated);
      if(condigAll.woredaLastUpdated!=null)await setStringToSF("woredaLastUpdated",condigAll.woredaLastUpdated);
      if(condigAll.serviceLastUpdated!=null)await setStringToSF("serviceLastUpdated",condigAll.serviceLastUpdated);
      if(condigAll.routeStatusLastUpdated!=null)await setStringToSF("routeStatusLastUpdated",condigAll.routeStatusLastUpdated);
      if(condigAll.vehicleModelLastUpdated!=null)await setStringToSF("vehicleModelLastUpdated",condigAll.vehicleModelLastUpdated);
      if(condigAll.extraRateTypesLastUpdated!=null)await setStringToSF("extraRateTypesLastUpdated",condigAll.extraRateTypesLastUpdated);
      if(condigAll.extraRatesLastUpdated!=null)await setStringToSF("extraRatesLastUpdated",condigAll.extraRatesLastUpdated);
      if(condigAll.cancelationReasonsLastUpdated!=null)await setStringToSF("cancelationReasonsLastUpdated",condigAll.cancelationReasonsLastUpdated);
      return true;
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return false;
    }
  }

  static Future<bool> getSetOfflineOrOnlineAuth(DriversDto condigAll) async
  {
    try
    {
      if(condigAll.userName!=null)await setStringToSF("userName",condigAll.userName);
      if(condigAll.passWord!=null)await setStringToSF("passWord",condigAll.passWord);
      if(condigAll.imei!=null)await setStringToSF("imei",condigAll.imei);
      return true;
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return false;
    }
  }

  static Future<bool> getSetOfflineOrOnline(Drivers condigAll) async
  {
    try
    {
      if(condigAll.Balance!=null)await setStringToSF("Balance",condigAll.Balance);
      if(condigAll.isOnline!=null)await setStringToSF("isOnline",condigAll.isOnline);
      if(condigAll.AverageRating!=null)await setStringToSF("AverageRating",condigAll.AverageRating);
      if(condigAll.Did!=null)await setStringToSF("Did",condigAll.Did);
      if(condigAll.AccountId!=null)await setStringToSF("AccountId",condigAll.AccountId);
      if(condigAll.status!=null)await setStringToSF("status",condigAll.status);
      return true;
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return false;
    }
  }
  static Future<bool> SetRequest(ChinetRequestDto request) async
  {
    try
    {
      if(request.requestId!=null)await setStringToSF("Request",request.requestId);
      if(request.lastModified!=null)await setStringToSF("createdAt",request.lastModified);
      if(request.Pickuplatitude!=null)await setStringToSF("Pickuplatitude",request.Pickuplatitude);
      if(request.Pickuplongitude!=null)await setStringToSF("Pickuplongitude",request.Pickuplongitude);
      if(request.Dropofflatitude!=null)await setStringToSF("Dropofflatitude",request.Dropofflatitude);
      if(request.Dropofflongitude!=null)await setStringToSF("Dropofflongitude",request.Dropofflongitude);
      return true;
    }
    catch(Exception)
    {
      debugPrint(Exception.toString());
      return false;
    }
  }

}