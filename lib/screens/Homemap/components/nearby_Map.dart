import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:taxi_booking/models/nearbyAvailableDrivers.dart';
import 'package:taxi_booking/screens/Assitants/geoFireAssistance.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/widgets/progress_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:taxi_booking/screens/Assitants/assitantMethods.dart';
import 'package:location/location.dart';
import 'package:easy_localization/easy_localization.dart';
class NearByMap extends StatefulWidget {

  @override

  _NearByMapState createState() => _NearByMapState();
}

class _NearByMapState extends State<NearByMap> {

  var buttomPaddingOfMap = 0.0;
  late LatLng myLocation;
  late Position currentPosition;
  bool nearbyAvailableDriverKeyLoaded=false;
  Set<Marker> markersSet = {};
  Set<Circle> _circles = HashSet<Circle>();
  Location location = new Location();
  late LocationData currentLocation;
  late BitmapDescriptor homeLocationIcon;
  late BitmapDescriptor currentLocationIcon;
  late GoogleMapController newGoogleMapController;
  @override
  void initState() {
    loading = false;
    getMyLocation();
    super.initState();
    // create an instance of Location
    location = new Location();    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc)   {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;
      if (mounted) {
        setState(() {
          _circles.clear();
          _circles.add(createCircle(LatLng(cLoc.latitude!, cLoc.longitude!)));
        }

        );
      }
      //  updatePinOnMap();
    });

     loadIcons();
     setInitialLocation();

  }
  @override
  void dispose() {
    _circles.clear();
    super.dispose();
  }
  void setInitialLocation() async {
    currentLocation = await location.getLocation();
  }
  Future<void> loadIcons() async {
    homeLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'images/outline_home_black_24dp.png');
  }
  Circle createCircle(LatLng latLng) {
    final String circleId = 'circle_id_${latLng.latitude}_${latLng.longitude}';
    return Circle(
        circleId: CircleId(circleId),
        center: latLng,
        radius: 300,
        fillColor:  Colors.blue.shade100.withOpacity(0.5),
        strokeWidth: 50,
        strokeColor: Colors.blue.shade100.withOpacity(0.1),
    );
  }


  late bool loading;
  // void initGeoFireListner()
  // {
  //   Geofire.initialize("availableDrivers");
  //   //comment
  //   Geofire.queryAtLocation(currentPosition.latitude, currentPosition.longitude, 5).listen((map) {
  //     print(map);
  //     if (map != null) {
  //       var callBack = map['callBack'];
  //       //latitude will be retrieved from map['latitude']
  //       //longitude will be retrieved from map['longitude']
  //       switch (callBack) {
  //         case Geofire.onKeyEntered:
  //           NearbyAvailableDrivers nearbyAvailableDrivers=NearbyAvailableDrivers();
  //           nearbyAvailableDrivers.key=map['key'];
  //           nearbyAvailableDrivers.latitude=map['latitude'];
  //           nearbyAvailableDrivers.longitude=map['longitude'];
  //           GeoFireAssistance.nearbyAvailableDriversList.add(nearbyAvailableDrivers);
  //           if(nearbyAvailableDriverKeyLoaded==true)
  //           {
  //             updateAvailableDriversOnMap();
  //           }
  //           break;
  //
  //         case Geofire.onKeyExited:
  //           GeoFireAssistance.removeDriverFormList(map['key']);
  //           updateAvailableDriversOnMap();
  //           break;
  //
  //         case Geofire.onKeyMoved:
  //         // Update your key's location
  //           NearbyAvailableDrivers nearbyAvailableDrivers=NearbyAvailableDrivers();
  //           nearbyAvailableDrivers.key=map['key'];
  //           nearbyAvailableDrivers.latitude=map['latitude'];
  //           nearbyAvailableDrivers.longitude=map['longitude'];
  //           GeoFireAssistance.updateDriverNearbyLocation(nearbyAvailableDrivers);
  //           updateAvailableDriversOnMap();
  //           break;
  //
  //         case Geofire.onGeoQueryReady:
  //
  //         // All Intial Data is loaded
  //           updateAvailableDriversOnMap();
  //
  //
  //           break;
  //       }
  //     }
  //
  //     setState(() {});
  //   });
  //   //comment
  // }
  void updateAvailableDriversOnMap() async
  {
    if (mounted) {
      setState(() {
        markersSet.clear();
      });
    }
    Set<Marker> tMarkers= Set<Marker>();
    int i=0;
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(2, 2)), 'assets/images/carnearby.png');
    for(NearbyAvailableDrivers driver in GeoFireAssistance.nearbyAvailableDriversList)
    {
      LatLng driverAvailablePosition=LatLng(driver.latitude, driver.longitude);
      String markId='Marker'+i.toString();
      Marker marker=Marker(
        markerId: MarkerId(markId),
        position: driverAvailablePosition,
        infoWindow: InfoWindow(title: 'Drivers'),
        icon: icon,
        //key: driver.key,
        // width: 60.0,
        // height: 60.0,
        // point:driverAvailablePosition,
        // rotate:true ,
        // builder: (ctx) => Container(
        //   child: Row(
        //     children: <Widget>[
        //       Container(
        //         width: 30.0,
        //         child:  Image.asset(
        //           "assets/images/carnearby.png",
        //           width: 60.0,
        //           height: 60.0,
        //         ),
        //       ),
        //       // Container(
        //       //   child: Text("Pick"),
        //       // )
        //     ],
        //   ),
        // ),
        // markerId: MarkerId('driver${driver.key}'),
        // position: driverAvailablePosition,
        // icon: nearByIcon,
        // rotation: AssistantMethods.creatRandomNumber(360),
      );
      tMarkers.add(marker);
    }
    if (mounted) {
      setState(() {
        markersSet = tMarkers;
      });
    }
    i++;
  }
  requestCab( LatLng pickUpLocation, LatLng dropLocation) async {

    var randomOperatorForLat = Random().nextInt(1);
    var randomOperatorForLng = Random(1).nextInt(1);

    var randomDeltaForLat = ((10+Random().nextInt(40)) /10000.00).toDouble();
    var randomDeltaForLng = ((10+Random().nextInt(40)) /10000.00).toDouble();

    if (randomOperatorForLat == 1) {
      randomDeltaForLat *= -1;
    }
    if (randomOperatorForLng == 1) {
      randomDeltaForLng *= -1;
    }

    var latFakeNearby =  pickUpLocation.latitude + randomDeltaForLat;
    var lngFakeNearby = pickUpLocation.longitude + randomDeltaForLng;

    var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(3, 3)), 'assets/images/carnearby.png');
    if (mounted) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('Marker200'),
            position: bookedCabCurrentLocation,
            infoWindow: InfoWindow(title: 'Drivers'),
            icon: icon,
          ),
        );
      });
    }
  }
  Future<void> getMyLocation() async {
    var rn = new Random();
    int num= 1 + rn.nextInt(5 - 1);
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(6, 6)), 'assets/images/StartL.png');
    try
    {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      // myLocation = LatLng(position.latitude, position.longitude);
      String address =
      await AssistantMethods().searchCordinateAddress(position, context);
      print("this is your address" + address);
      //placeAddress=
      if (mounted) {
         this.setState(() {
          myLocation = LatLng(position.latitude, position.longitude);
         List<Marker> list = [
            Marker(
              markerId: MarkerId('Marker1'),
              position: LatLng(
                  currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(title: 'Pick Up Location'),
              icon: icon,
            )
          ];
          setState(() {
            _markers.addAll(list);
          });


          loading = true;
        });
      }
      for (int i=0;i<num;i++)
      {
        var randomDeltaForLat = ((10+Random().nextInt(40)) /10000.00).toDouble();
        var randomDeltaForLng = ((10+Random().nextInt(40)) /10000.00).toDouble();
        var lngFakeNearby = position.longitude + randomDeltaForLng;
        var latFakeNearby =  position.latitude + randomDeltaForLat;


        var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);
        requestCab(myLocation,bookedCabCurrentLocation);
      }
    }
    catch(ex)
    {}


    // print(position);
  }
  List<Marker> _markers = [
    // Marker(
    //   markerId: MarkerId('Marker100'),
    //   position: LatLng(9.00946, 38.78090),
    //   infoWindow: InfoWindow(title: 'Business 2'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    //   // width: 30.0,
    //   // height: 30.0,
    //   // point: LatLng(9.00946, 38.78090),
    //   // builder: (ctx) => Container(
    //   //   child: Image.asset(
    //   //     "assets/images/carnearby.png",
    //   //     width: 60.0,
    //   //     height: 60.0,
    //   //   ),
    //   // ),
    // ),
  ];
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: geolocator.LocationAccuracy.high);
    currentPosition = position;
    LatLng latlangPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latlangPosition, zoom: 16);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await AssistantMethods().searchCordinateAddress(position, context);
    print("this is your address" + address);
     // ColorizeAnimatedTextKit();
  }
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Future<bool?> _waitNetwork() async {
    try
    {
     showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return ProgressDialog(message: LocaleKeys.Please_wait_for_the_network.tr(),);
          }
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
              LocaleKeys.internet_connection_problem.tr()),
        ),
      );
      return false;
    }
  }


  @override
  Widget build(BuildContext context) {


return  loading ? Container(
  //height: getProportionateScreenHeight(MediaQuery.of(context).size.height+200 ),
height:MediaQuery.of(context).size.height,
    child:
    GoogleMap(
      padding: EdgeInsets.only(
          bottom:MediaQuery.of(context).size.height*0.18),
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      myLocationEnabled: true ,
      scrollGesturesEnabled: true,
      compassEnabled: true,

      markers: Set<Marker>.of(_markers),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
        newGoogleMapController = controller;
        locatePosition();
        // setState(() {
        //   buttomPaddingOfMap = 200.0;
        // });
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(myLocation.latitude, myLocation.longitude),
        zoom: 16.0,
      ),
      // onCameraMove: null,
      circles: _circles,
    ),



):Container(
  padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(280)),
  child: Center(

    child: ProgressDialog(message: LocaleKeys.Please_wait_for_the_network.tr()),
  ),
);


  }

}

