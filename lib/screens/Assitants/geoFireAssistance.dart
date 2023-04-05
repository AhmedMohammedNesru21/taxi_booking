import 'package:taxi_booking/models/nearbyAvailableDrivers.dart';


class GeoFireAssistance
{
  static List<NearbyAvailableDrivers> nearbyAvailableDriversList=[];
  static void removeDriverFormList(String key)
  {
    int index=nearbyAvailableDriversList.indexWhere((element) => element.key==key);
    nearbyAvailableDriversList.remove(index);
  }
  static void updateDriverNearbyLocation(NearbyAvailableDrivers drivers)
  {
    int index=nearbyAvailableDriversList.indexWhere((element) => element.key==drivers.key);
    nearbyAvailableDriversList[index].longitude=drivers.longitude;
    nearbyAvailableDriversList[index].latitude=drivers.latitude;
  }
}