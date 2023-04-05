

import 'package:taxi_booking/repository/repository.dart';

import '../models/Rates.dart';
import '../models/extraRateTypes.dart';
import '../models/extraRates.dart';
import '../models/rentalhistorydata.dart';

class DBService {
  List<String> imageList = [];
 late Repository _repository;

  DBService() {
    _repository = Repository();
  }
  /// CancelationReasons Query
  insertCancelationReasons( cancelationReasons) async
  {
    return await _repository.insertData("cancelationReasons", cancelationReasons.toMap());
  }

  getAllCancelationReasons() async
  {
    return await _repository.readData("cancelationReasons");
  }

  getActiveCancelationReasons() async
  {
    return await _repository.readDataWithCondition("cancelationReasons", "isDeleted=0");
  }
  /// extraRateTypes Query
  insertExtraRates( extraRates) async
  {
    return await _repository.insertData("extraRates", extraRates.toMap());
  }

  getAllExtraRates(String regionid) async
  {
    return await _repository.readDataWithCondition("extraRates", "extraRateTypeId="+regionid);

  }

  getActiveExtraRates() async
  {
    return await _repository.readDataWithCondition("extraRates", "isDeleted=0");
  }

  getExtraRatesValue(String Id) async
  {
   final List<Map<String, dynamic>> maps = await _repository.readDataWithQuery('''
   SELECT *
    FROM extraRates
    Where     Id=$Id
    ''');
    return List.generate(maps.length, (i) {
      return ExtraRates.toDisplay(
        Id:maps[i]["Id"].toString(),
        extraRateTypeId:maps[i]["extraRateTypeId"],
        rateName:maps[i]["rateName"],
        rateValue:maps[i]["rateValue"],
        isFixed:maps[i]["isFixed"],
        formula:maps[i]["formula"],
        lastUpdatedDate:maps[i]["lastUpdatedDate"],
        isDeleted:maps[i]["isDeleted"],

      );
    });
  }

  ///registerDriver
  insertRegisterPassenger( registerPassenger) async
  {
    return await _repository.insertData("registerPassenger", registerPassenger.toMap());
  }

  getAllRegisterPassenger() async
  {
    return await _repository.readData("registerPassenger");
  }

  getActiveRegisterPassenger() async
  {
    return await _repository.readDataWithCondition("registerPassenger", "status=1");
  }
  /// extraRateTypes Query
  insertExtraRateTypes( extraRateTypes) async
  {
    return await _repository.insertData("extraRateTypes", extraRateTypes.toMap());
  }

  getAllExtraRateTypes() async
  {
    return await _repository.readData("extraRateTypes");
  }
  getExtraRateTypes(String Id) async
  {
    final List<Map<String, dynamic>> maps = await _repository.readDataWithQuery('''
   SELECT *
    FROM extraRateTypes
    Where     Id=$Id
    ''');
    return List.generate(maps.length, (i) {
      return ExtraRateTypes.toDisplay(
        Id:maps[i]["Id"].toString(),
        rateName:maps[i]["rateName"],
        isDeleted:maps[i]["isDeleted"], lastUpdateDate: '',

      );
    });

  }
  getActiveExtraRateTypes() async
  {
    return await _repository.readDataWithCondition("extraRateTypes", "isDeleted=0");
  }
  /// vehicleModels Query
  insertVehicleModels( vehicleModels) async
  {
    return await _repository.insertData("vehicleModels", vehicleModels.toMap());
  }

  getAllVehicleModels() async
  {
    return await _repository.readData("vehicleModels");
  }

  getActiveVehicleModels() async
  {
    return await _repository.readDataWithCondition("vehicleModels", "isDeleted=0");
  }

  /// Service Query
  insertService( Service) async
  {
    return await _repository.insertData("services", Service.toMap());
  }

  getAllService() async
  {
    return await _repository.readData("Service");
  }

  getActiveService() async
  {
    return await _repository.readDataWithCondition("services", "isDeleted=0");
  }
  /// RouteStatuses Query
  insertRouteStatuses( RouteStatuses) async
  {
    return await _repository.insertData("routeStatuses", RouteStatuses.toMap());
  }

  getAllRouteStatuses() async
  {
    return await _repository.readData("routeStatuses");
  }

  getActiveRouteStatuses() async
  {
    return await _repository.readDataWithCondition("routeStatuses", "isDeleted=0");
  }

  /// Regions Query
  insertRegions( Regions) async
  {
    return await _repository.insertData("Regions", Regions.toMap());
  }

  getAllRegions() async
  {
    return await _repository.readData("Regions");
  }

  getActiveRegions() async
  {
    return await _repository.readDataWithCondition("Regions", "isDeleted=0");
  }

  /// Subcity Query
  insertSubcity( Subcity) async
  {
    return await _repository.insertData("Subcity", Subcity.toMap());
  }

  getAllSubcity() async
  {
    return await _repository.readData("Subcity");
  }

  getActiveSubcity(String regionid) async
  {
    return await _repository.readDataWithCondition("Subcity", "Region_Id="+regionid);
  }
  /// Subcity Query
  insertWereda( Wereda) async
  {
    return await _repository.insertData("Wereda", Wereda.toMap());
  }

  getAllWereda() async
  {
    return await _repository.readData("Wereda");
  }

  getActiveWereda(String weredaid) async
  {
    return await _repository.readDataWithCondition("Wereda", "Subcity_Id="+weredaid);
  }

  /// Roles Query
  insertRoles( roles) async
  {
    return await _repository.insertData("Roles", roles.toMap());
  }

  getAllRoles() async
  {
    return await _repository.readData("Roles");
  }

  getActiveroles() async
  {
    return await _repository.readDataWithCondition("Roles", "isDeleted=0");
  }

  /// Passengers Query
  insertPassengers( passengers) async
  {
    return await _repository.insertData("Roles", passengers.toMap());
  }

  getAllrassengers() async
  {
    return await _repository.readData("passengers");
  }

  getActivepassengers() async
  {
    return await _repository.readDataWithCondition("Passengers", "isDeleted=0");
  }
  /// Notifications Query
  insertNotifications( Notifications) async
  {
    return await _repository.insertData("Notifications", Notifications.toMap());
  }

  getAllNotifications() async
  {
    return await _repository.readData("Notifications");
  }

  getActiveNotifications() async
  {
    return await _repository.readDataWithCondition("Notifications", "isDeleted=0");
  }

  /// ContactUs Query
  insertContactUs( ContactUs) async
  {
    return await _repository.insertData("Notifications", ContactUs.toMap());
  }

  getAllContactUs() async
  {
    return await _repository.readData("ContactUs");
  }

  getActiveContactUs() async
  {
    return await _repository.readDataWithCondition("ContactUs", "isDeleted=0");
  }

  /// Attachements Query
  insertAttachements( Attachements) async
  {
    return await _repository.insertData("Notifications", Attachements.toMap());
  }

  getAllAttachements() async
  {
    return await _repository.readData("Attachements");
  }

  getActiveAttachements() async
  {
    return await _repository.readDataWithCondition("Attachements", "isDeleted=0");
  }

  /// Drivers Query
  insertDrivers( Attachements) async
  {
    return await _repository.insertData("Notifications", Attachements.toMap());
  }

  getAllDrivers() async
  {
    return await _repository.readData("Attachements");
  }

  getActiveDrivers() async
  {
    return await _repository.readDataWithCondition("Drivers", "isDeleted=0");
  }

  /// Drivers Query
  insertAccounts( Accounts) async
  {
    return await _repository.insertData("Accounts", Accounts.toMap());
  }

  getAllAccounts() async
  {
    return await _repository.readData("Accounts");
  }

  getActiveAccounts() async
  {
    return await _repository.readDataWithCondition("Accounts", "isDeleted=0");
  }

  /// Currentlocations Query
  insertCurrentlocations( Accounts) async
  {
    return await _repository.insertData("Accounts", Accounts.toMap());
  }

  getAllCurrentlocations() async
  {
    return await _repository.readData("Currentlocations");
  }

  getActiveCurrentlocations() async
  {
    return await _repository.readDataWithCondition("Currentlocations", "isDeleted=0");
  }

  /// Currentlocations Query
  List<String> getImageCardata(String id)  {
    List<String> list = [];
    switch (id)
    {
      case '0':

        list.add("assets/images/sedanCarIcon.png");
        break;
      case '1':
        list.add("assets/images/affordableCarIcon.png");
        break;
      case '2':
        list.add("assets/images/sedanCarIcon.png");
        break;
      case '3':
        list.add("assets/images/Crane.png");

        break;
      case '4':
        list.add("assets/images/TowTruck.png");
        break;
      case '5':
        list.add("assets/images/FlatbedTrailer.png");
        break;
      case '6':
        list.add("assets/images/HighwayMaintenanceTrucks.png");
        break;
      case '7':
        list.add("assets/images/LivestockTrucks.png");
        break;
      case '8':
        list.add("assets/images/LoggingTrucks.png");
        break;
      case '9':
        list.add("assets/images/sedanCarIcon.png");
        break;
      case '10':
        list.add("assets/images/TipperTrucks.png");
        break;
      case '11':
        list.add("assets/images/BoxTruck.png");
        break;
      case '12':
        list.add("assets/images/luxuryCarIcon.png");
        break;
        case '13':
      list.add("assets/images/suvCarIcon.png");
      break;
      default:
        list.add("assets/images/land_rover_0.png");
        break;
    }

    return list;
  }

  getUpComing() async
  {
    try {
      final List<Map<String, dynamic>> maps = await _repository
          .readDataWithQuery('''
    SELECT        Id, 'Truck Type Furniture' AS brand, 'Isuzu' AS model, '200' AS price, '' AS condition, lastModifiedDate as check_out_date
    FROM           Routers
    where ArrivalTime='0'
    ''');
      return List.generate(maps.length, (i) {
        return RentalHistoryData.toDisplay(
            id: maps[i]['Id'].toString(),
            brand: maps[i]['brand'],
            model: maps[i]['model'],
            price: double.parse(maps[i]['price'].toString()),
            condition: maps[i]['condition'],
            images: getImageCardata(maps[i]['Id'].toString()),
            check_in_date:maps[i]['check_in_date'],
            check_out_date:maps[i]['check_out_date']


        );
      });
    }
    catch(e)
    {}
  }
  getCompleted() async
  {
    try {
      final List<Map<String, dynamic>> maps = await _repository
          .readDataWithQuery('''
 
    SELECT         Id, 'Truck Type Furniture' AS brand, 'Isuzu' AS model, '200' AS price, '' AS condition, lastModifiedDate as check_out_date
    FROM           Routers
    where ArrivalTime='6'
  
    ''');
      return List.generate(maps.length, (i) {
        return RentalHistoryData.toDisplay(
            id: maps[i]['Id'].toString(),
            brand: maps[i]['brand'],
            model: maps[i]['model'],
            price: double.parse(maps[i]['price'].toString()),
            condition: maps[i]['condition'],
            check_in_date:maps[i]['check_in_date'],
            check_out_date:maps[i]['check_out_date'], images: []


        );
      });
    }
    catch(e)
    {}
  }
  getCanceled() async
  {
    try {
      //
      final List<Map<String, dynamic>> maps = await _repository
          .readDataWithQuery('''
              SELECT         Id,
               CASE phone 
           WHEN '0' THEN 'Pickup Trucks' 
		   WHEN '1' THEN 'Furniture Trucks'
		   WHEN '2' THEN 'Car Transporter Car Carrier Trucks' 
		   WHEN '3' THEN 'Cement Trucks'
		   WHEN '4' THEN 'Crane/Mobile Cranes Trucks'
		   WHEN '5' THEN 'Tow Trucks' 
		   WHEN '6' THEN 'Flat-bed Trucks'
		   WHEN '7' THEN 'Highway Maintenance Trucks' 
		   WHEN '8' THEN 'Livestock Trucks'
		   WHEN '9' THEN 'Logging Trucks' 
		   WHEN '10' THEN 'Tipper Trucks'
		   WHEN '11' THEN 'Box Trucks' 
		   WHEN '12' THEN 'Dump/Tripper Trucks'
		   WHEN '13' THEN 'Motorcycles'
           ELSE ifnull(phone,'') 
       END  AS brand, 
              phone AS model, CASE WHEN AmountPaid = 'null' THEN '0' ELSE AmountPaid END AS price, SUBSTR(PickupAddress || '/' || DropoffAddress,1,45)  AS condition, strftime('%d/%m/%Y', createdAt) as check_out_date , strftime('%d/%m/%Y', createdAt) as check_in_date
              FROM           Routers  
              where statusId='3'
    ''');
      return List.generate(maps.length, (i) {
        return RentalHistoryData.toDisplay(
            id: maps[i]['Id'].toString(),
            brand: maps[i]['brand'],
            model: maps[i]['model'],
            price: double.parse(maps[i]['price'].toString()),
            condition: maps[i]['condition'],
            images: getImageCardata(maps[i]['model'].toString()),
            check_in_date:maps[i]['check_in_date'].toString(),
            check_out_date:maps[i]['check_out_date'].toString()



        );
      });
    }
    catch(e)
    {}
  }
  insertRouters( ChinetRequestDto) async
  {
    return await _repository.insertData("Routers", ChinetRequestDto.toMap());
  }

  getAllRouters() async
  {
    return await _repository.readData("Routers");
  }

  getActiveRouters() async
  {
    return await _repository.readDataWithCondition("Routers", "isDeleted=0");
  }

  insertRates( Rates) async
  {
    return await _repository.insertData("Rates", Rates.toMap());
  }

  getAllRates() async
  {
    return await _repository.readData("Rates");
  }

  getActiveRates() async
  {
    return await _repository.readDataWithCondition("Rates", "isDeleted=0");
  }
  getRatesValue(String Id) async
  {
    final List<Map<String, dynamic>> maps = await _repository.readDataWithQuery('''
   SELECT *
    FROM rates
    Where     Rid=$Id
    ''');
    return List.generate(maps.length, (i) {
      return Rates.toDisplay(
        Rid:maps[i]["Rid"].toString(),
        ratetypes:maps[i]["ratetypes"],
        rateWaitingTimePrice:maps[i]["rateWaitingTimePrice"],
        ratePerKilloMeterPrice:maps[i]["ratePerKilloMeterPrice"],
        rateNightWaitingTimePrice:maps[i]["rateNightWaitingTimePrice"],
        rateFormula:maps[i]["rateFormula"],
        isDirect:maps[i]["isDirect"],
        lastUpdatedDate:maps[i]["lastUpdatedDate"],
        isDeleted:maps[i]["isDeleted"],

      );
    });
  }

  /// Reasons Query
  insertReasons( Reasons) async
  {
    return await _repository.insertData("Reasons", Reasons.toMap());
  }

  getAllReasons() async
  {
    return await _repository.readData("Reasons");
  }

  getActiveReasons() async
  {
    return await _repository.readDataWithCondition("Reasons", "isDeleted=0");
  }

  /// Vehicles Query
  insertVehicles( Vehicles) async
  {
    return await _repository.insertData("Vehicles", Vehicles.toMap());
  }

  getAllVehicles() async
  {
    return await _repository.readData("Vehicles");
  }

  getActiveVehicles() async
  {
    return await _repository.readDataWithCondition("Vehicles", "isDeleted=0");
  }
}



