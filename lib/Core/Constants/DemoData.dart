import 'package:taxi_booking/Core/Enums/Enums.dart';
import 'package:taxi_booking/Core/Models/CarTypeMenu.dart';
import 'package:taxi_booking/Core/Models/Drivers.dart';
import 'package:taxi_booking/Core/Models/UserDetails.dart';
import 'package:taxi_booking/Core/Models/UserPlaces.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DemoData {
  static List<Driver> nearbyDrivers = [
    Driver(
        "First",
        "https://cbsnews2.cbsistatic.com/hub/i/r/2017/12/20/205852a8-1105-48b5-98d4-d9ec18a577e0/thumbnail/1200x630/8cb0b627b158660d1e0a681a76fb012c/uber-europe-uk-851372958.jpg",
        4,
        "FirstId",
        CarDetail(
            "firstCarId", "firstCarCompany", "firstCarModel", " firstCarName"),
        LatLng(28.625511, 77.374204)),
    Driver(
        "Second",
        "https://cbsnews2.cbsistatic.com/hub/i/r/2017/12/20/205852a8-1105-48b5-98d4-d9ec18a577e0/thumbnail/1200x630/8cb0b627b158660d1e0a681a76fb012c/uber-europe-uk-851372958.jpg",
        3,
        "Second",
        CarDetail("secondCarId", "secondCarCompany", "secondCarModel",
            " secondCarName"),
        LatLng(28.623948, 77.373394)),
    Driver(
        "Third",
        "https://cbsnews2.cbsistatic.com/hub/i/r/2017/12/20/205852a8-1105-48b5-98d4-d9ec18a577e0/thumbnail/1200x630/8cb0b627b158660d1e0a681a76fb012c/uber-europe-uk-851372958.jpg",
        4,
        "ThirdId",
        CarDetail(
            "thirdCarId", "thirdCarCompany", "thirdCarModel", " thridCarName"),
        LatLng(28.624372, 77.374220)),
  ];
  static List<String> previousRides = [
    "dsgffdsgdsagfds",
    "fdsafdsafas",
    "fdsafasffasd"
  ];

  static List<UserPlaces> favPlaces = [
    UserPlaces(
        "India Gate", "India Gate, New Delhi", LatLng(28.612912, 77.227321)),
    UserPlaces(
        "fdsagdsa rewfw", "nfdsbf, New Delhi", LatLng(29.612912, 70.227321)),
    UserPlaces(
        "dsagasdsa", "kldnwkvn, New Delhi", LatLng(22.612912, 70.227321)),
    UserPlaces(
        "dsafagdgg", "wqkjegcq, New Delhi", LatLng(38.612912, 67.227321)),
    UserPlaces(
        "jdskdsaksasaf", "cqucqjuwq, New Delhi", LatLng(28.012912, 77.297321)),
  ];

  static UserDetails currentUserDetails = UserDetails(
      "FDSfdfdsafFtt324sdf",
      "https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fimages%2Fsearch%2Fflower%2F&psig=AOvVaw2a8tZc-fb3rxo-OkohLj-G&ust=1665586600555000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCIjP5M232PoCFQAAAAAdAAAAABAE",
      "Sahdeep Singh",
      "ahmed.comp10@gmail.com",
      "0123456789",
      "",
      previousRides,
      favPlaces);
  static List<CarTypeMenu> typesOfCar = [
    CarTypeMenu("assets/images/classicCarIcon.png",
      "Pickup Trucks", TruckType.Pickup,""),
    CarTypeMenu("assets/images/sedanCarIcon.png",
        "Furniture Trucks", TruckType.Furniture,""),
    CarTypeMenu("assets/images/affordableCarIcon.png", "Car Transporter/Car Carrier Trucks",
        TruckType.CarCarrier," "),
    CarTypeMenu("assets/images/sedanCarIcon.png",
        "Cement Trucks", TruckType.CementTruck,""),
    CarTypeMenu("assets/images/Crane.png",
        "Crane/Mobile Cranes Trucks", TruckType.CraneMobile,""),
    CarTypeMenu("assets/images/TowTruck.png",
        "Tow Trucks", TruckType.TowTruck,""),
    CarTypeMenu("assets/images/FlatbedTrailer.png",
        "Flat-bed Trucks", TruckType.FlatbedTrailer,""),
    CarTypeMenu("assets/images/HighwayMaintenanceTrucks.png",
        "Highway Maintenance Trucks", TruckType.HighwayMaintenanceTrucks,""),
    CarTypeMenu("assets/images/LivestockTrucks.png",
        "Livestock Trucks", TruckType.LivestockTrucks,""),
    CarTypeMenu("assets/images/LoggingTrucks.png",
        "Logging Trucks", TruckType.LoggingTrucks,""),
    CarTypeMenu("assets/images/TipperTrucks.png",
        "Tipper Trucks", TruckType.TipperTrucks,""),
    CarTypeMenu("assets/images/BoxTruck.png",
        "Box Trucks", TruckType.BoxTruck,""),
    CarTypeMenu("assets/images/luxuryCarIcon.png",
        "Dump/Tripper Trucks",
        TruckType.Tipper,""),
    CarTypeMenu("assets/images/suvCarIcon.png",
        " Motorcycles", TruckType.MOTOR,""),
  ];
}
