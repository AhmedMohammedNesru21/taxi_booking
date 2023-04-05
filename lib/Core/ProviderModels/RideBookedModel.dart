import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:taxi_booking/Core/Constants/DemoData.dart';

import 'package:taxi_booking/Core/Enums/Enums.dart';
import 'package:taxi_booking/Core/Models/Drivers.dart';

import 'package:taxi_booking/Core/Utils/LogUtils.dart';
import 'package:taxi_booking/Core/Utils/Utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../constants.dart';

class RideBookedModel extends ChangeNotifier {
  /// Tag for Logs
  static const TAG = "MapModel";

  late GoogleMapController _mapController;

  // MapRepository mapRepository = MapRepository();

  /// Origin Latitude and Longitude
  late LatLng originLatLng;

  /// Destination Latitude and Longitude
  late LatLng destinationLatLng;

  /// Default Camera Zoom
  double currentZoom = 15;

  Driver currentDriver = DemoData.nearbyDrivers[1];

  DriverStatus driverStatus = DriverStatus.OnWay;

  LatLng driverLatLng = DemoData.nearbyDrivers[1].currentLocation;

  /// Set of all the markers on the map
  final Set<Marker> _markers = Set();

  /// Set of all the polyLines/routes on the map
  final Set<Polyline> _polyLines = Set();

  /// Markers Getter
  get markers => _markers;

  /// PolyLines Getter.
  get polyLines => _polyLines;

  String rideStatusAsText = "Driver enRoute";

  int timeLeftToReach = 10;

  /// OnGoing Map
  onMapCreated(GoogleMapController controller) {
    ProjectLog.logIt(TAG, "onMapCreated", "null");
    _mapController = controller;
    rootBundle.loadString('assets/images/mapStyle.txt').then((string) {
      _mapController.setMapStyle(string);
    });
    // listenToRideLocationUpdate();
    addAllMarkers();
    // createOriginDestinationRoute();
    // createOriginDriverLocationRoute();
    notifyListeners();
  }

  /// On Camera Moved
  onCameraMove(CameraPosition position) {}
  ///Creating a Route
  void createCurrentRoute(String encodedPoly, String polyId, Color color,
      int width) {
    ProjectLog.logIt(TAG, "createCurrentRoute", encodedPoly);
    _polyLines.add(Polyline(
        polylineId: PolylineId(polyId),
        width: width,
        geodesic: true,
        points: Utils.convertToLatLng(Utils.decodePoly(encodedPoly)),
        color: color));
    notifyListeners();
  }

  void addAllMarkers() async {
    _markers.add(Marker(
      markerId: MarkerId("20287266"),
        position: originLatLng,
        flat: true,
        icon: BitmapDescriptor.fromBytes(
          await Utils.getBytesFromAsset("assets/images/pickupIcon.png", 70),
        )));
    // _markers.add(Marker(
    //     markerId: MarkerId(Constants.destinationMarkerId),
    //     position: destinationLatLng,
    //     flat: true,
    //     icon: BitmapDescriptor.fromBytes(
    //       await Utils.getBytesFromAsset("assets/images/destinationIcon.png", 70),
    //     )));

    /// for now we have added the single marker
    //   _markers.add(Marker(
    //       markerId: MarkerId(Constants.driverMarkerId),
    //       position: DemoData.nearbyDrivers[2].currentLocation, //taking demo data
    //       flat: true,
    //       icon: BitmapDescriptor.fromBytes(
    //         await Utils.getBytesFromAsset("assets/images/carIcon.png", 60),
    //       )));
    //   notifyListeners();
    // }

    // void listenToRideLocationUpdate() {
    //   /// We will be listening to drivers location update and update here accordingly,
    //   /// like we did in the users current location update.
    //   Future.delayed(Duration(seconds: 20), () {
    //     driverStatus = DriverStatus.Reached;
    //     notifyListeners();
    //   });
    // }
  }
}
