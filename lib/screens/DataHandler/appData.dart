import 'package:taxi_booking/models/address.dart';
import 'package:flutter/cupertino.dart';


class AppData extends ChangeNotifier {

   Address?  pickUpLocation , dropOffLocation;

  void upadatePickUpLocationAddress(Address address){
    pickUpLocation = address;
    notifyListeners();
  }


  void updateDropOffLocationAddress(Address dropOfAddress){
    dropOffLocation = dropOfAddress;
    notifyListeners();
  }

}