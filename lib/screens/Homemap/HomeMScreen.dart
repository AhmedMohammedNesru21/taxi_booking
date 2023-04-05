import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:taxi_booking/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vector_math/vector_math.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';
import '../../size_config.dart';
import '../../wellcome.dart';
import 'package:flutter/rendering.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/constants.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../search_screen.dart';
class HomeMScreen extends StatefulWidget {
  static const id = "HOME_SCREEN";
  static String routeName = "/HOME_SCREEN";
  const HomeMScreen() ;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeMScreen> with TickerProviderStateMixin {
  final List<Marker> _markers = <Marker>[];
   Animation<double>? _animation;
   late GoogleMapController _controller;

  final _mapMarkerSC = StreamController<List<Marker>>();

  StreamSink<List<Marker>> get _mapMarkerSink => _mapMarkerSC.sink;

  Stream<List<Marker>> get mapMarkerStream => _mapMarkerSC.stream;
  Location? location;
  LocationData? currentLocation;
  LatLng? myLocation;
  bool loading = false;
  Set<Circle> _circles = HashSet<Circle>();
  MapType _currentMapType = MapType.normal;
  Location _location = Location();
  bool drawerOpen = true;
  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
  @override
  void initState() {
    // Timer(Duration(seconds: 15), () {
    //   if ( loading==false)
    //   {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //             builder: (context) => WellCome()));
    //   }
    // });
    super.initState();
    getMyLocation();
     getUpdateLocation();
    getUpdateLocation1();

    //getMyLocation();



    //Starting the animation after 1 second.
    location = new Location();
    // polylinePoints = PolylinePoints();

    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location?.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;

      if (mounted) {
        setState(() {
          _circles.clear();
          _circles.add(createCircle(LatLng(cLoc.latitude!, cLoc.longitude!)));
          // cabCurrentLocation=LatLng(cLoc.latitude, cLoc.longitude);

        });
      }

    });

  }
  @override
  void dispose() {
    _circles.clear();
    super.dispose();
  }
  Circle createCircle(LatLng latLng) {
    final String circleId = 'circle_id_${latLng.latitude}_${latLng.longitude}';
    return Circle(
      circleId: CircleId(circleId),
      center: latLng,
      radius: 300,
      fillColor:Color(0xffd3f3f8),
      // Color(0xFF87CEFA),
      //Color.fromARGB(255,0,194,255),
      strokeWidth: 0,
      strokeColor: Color(0xFFE0FFFF),
    );
  }
  Future<void> getUpdateLocation() async {

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);

      Future.delayed(const Duration(seconds: 1)).then((value) {
        animateCar(
          position.latitude,
          position.longitude,
          position.latitude+0.00075266419336,
          position.longitude+0.007448655962,
          _mapMarkerSink,
          this,
          _controller,
        );
      });
     } catch (ex) {}

    // print(position);
  }

  Future<void> getUpdateLocation1() async {

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      var randomDeltaForLat = ((10 + Random().nextInt(40)) / 10000.00).toDouble();
      var randomDeltaForLng = ((10 + Random().nextInt(40)) / 10000.00).toDouble();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        animateCar1(
          position.latitude,
          position.longitude,
          position.latitude-randomDeltaForLat,
          position.longitude-randomDeltaForLng,
          _mapMarkerSink,
          this,
          _controller,
        );
      });
    } catch (ex) {}

    // print(position);
  }
  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {

    final googleMap = StreamBuilder<List<Marker>>(
        stream: mapMarkerStream,
        builder: (context, snapshot) {
          return GoogleMap(
            padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.40,
            top: MediaQuery.of(context).size.height * 0.38),
            mapType: _currentMapType,
            initialCameraPosition: CameraPosition(
              target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              zoom: 14.4746,
            ),
            rotateGesturesEnabled: false,
            tiltGesturesEnabled: false,
            mapToolbarEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(_markers),
            circles: _circles,
          );
        });
    Widget mapButton(VoidCallback function, Icon icon, Color color) {
      return RawMaterialButton(
        onPressed: function,
        child: icon,
        shape: new CircleBorder(),
        elevation: 2.0,
        fillColor: color,
        padding: const EdgeInsets.all(7.0),
      );
    }
    return Scaffold(
      body:loading
          ? Stack(
        children: [
          googleMap,
          Positioned(
            top: 50.0,
            left: 22.0,
            child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(22.0),
                  boxShadow: [
                    BoxShadow(
                        color: black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        ))
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor:kPrimaryColor,
                  child: Icon(
                    (drawerOpen) ? Icons.menu : Icons.close,
                    color: lbackgroundColor,
                  ),
                  radius: 20.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
                margin: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                child: Column(
                  children: <Widget>[
                    mapButton(
                        _onMapTypeButtonPressed,
                        Icon(
                          Icons.landscape_rounded,
                          color: lbackgroundColor,
                        ),
                        kPrimaryColor),
                  ],
                )),
          ),

          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 20),
              height: getProportionateScreenHeight(170),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ), //width: width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InkWell(
                        onTap: () async {
                          var res = Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()),
                          );
                          if (res == "obtainDirection") {}
                        },



                            child:SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: getProportionateScreenHeight(70),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                  //side: BorderSide(width: 5, color: Colors.green)
                                ),
                                elevation:
                                getProportionateScreenHeight(10),
                                // padding: const EdgeInsets.all(4.0),
                                margin:
                                   const EdgeInsets.only(
                                    top: 10.0,
                                    bottom: 10.0,

                                    ),

                                child: Text(
                                  LocaleKeys.where_to.tr(),
                                  style: TextStyle(
                                    // fontFamily: 'Arial',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                    getProportionateScreenWidth(14),
                                    color: lbackgroundColor,
                                    height:
                                    getProportionateScreenHeight(2.5),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                color: dbackgroundColor,
                              ),
                            ),


                        ),

                    // ),
                    SizedBox(
                      height: getProportionateScreenHeight(16),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(15),
                        ),

                        Image.asset(
                          "assets/icons/mylocation_ios.png",
                          width: 25.0,
                          height: 25,
                          color: kPrimaryColor,
                        ),
                        //Icon(Icons.my_location_sharp, color: kPrimaryColor,),
                        SizedBox(
                          width: getProportionateScreenWidth(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: getProportionateScreenWidth(250),
                            child:Text(
                              "${Provider.of<AppData>(context).pickUpLocation != null ? Provider.of<AppData>(context).pickUpLocation?.placeFormattedAddress : ""}",
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(10),
                              ),
                              // textAlign: TextAlign.center,
                              //  softWrap: true,

                              // maxLines: 1,
                            ),)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ) : Container(
        padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenHeight(250)),
        child: ProgressDialog(
            message: "Loading..."),

      ),
    );
  }



  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        !.buffer
        .asUint8List();
  }
  Future<void> getMyLocation() async {
    // var rn = new Random();
    // int num = 1 + rn.nextInt(6 - 1);
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(6, 6)), 'assets/images/StartL.png');
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      // myLocation = LatLng(position.latitude, position.longitude);

      //print("this is your address" + address);
      loading = true;
      //placeAddress=
      if (mounted) {
        this.setState(() {
          myLocation = LatLng(position.latitude, position.longitude);
          List<Marker> list = [
            Marker(
              markerId: MarkerId('Marker7'),
              position:
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              infoWindow: InfoWindow(title: 'Pick Up Location'),
              icon: icon,
            ),
          ];
          setState(() {
            _markers.addAll(list);
          });
        });
      }

    } catch (ex) {}

    // print(position);
  }
  animateCar1(
      double fromLat, //Starting latitude
      double fromLong, //Starting longitude
      double toLat, //Ending latitude
      double toLong, //Ending longitude
      StreamSink<List<Marker>>
      mapMarkerSink, //Stream build of map to update the UI
      TickerProvider
      provider, //Ticker provider of the widget. This is used for animation
      GoogleMapController controller, //Google map controller of our widget
      ) async {
    final double bearing =
    getBearing(LatLng(fromLat, fromLong), LatLng(toLat, toLong));

   // _markers.clear();

    var carMarker1 = Marker(
        markerId: const MarkerId("driverMarker1"),
        position: LatLng(fromLat, fromLong),
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/images/carnearby5.png', 60)),
        anchor: const Offset(0.5, 0.5),
        flat: true,
        rotation: bearing,
        draggable: false);

    //Adding initial marker to the start location.
    _markers.add(carMarker1);
    mapMarkerSink.add(_markers);

    final animationController = AnimationController(
      duration: const Duration(seconds: 5), //Animation duration of marker
      vsync: provider, //From the widget
    );

    Tween<double> tween = Tween(begin: 0, end: 1);

    _animation = tween.animate(animationController)
      ..addListener(() async {
        //We are calculating new latitude and logitude for our marker
        final v = _animation!.value;
        double lng = v * toLong + (1 - v) * fromLong;
        double lat = v * toLat + (1 - v) * fromLat;
        LatLng newPos = LatLng(lat, lng);

        //Removing old marker if present in the marker array
        if (_markers.contains(carMarker1)) _markers.remove(carMarker1);

        //New marker location
        carMarker1 = Marker(
            markerId: const MarkerId("driverMarker1"),
            position: newPos,
            icon: BitmapDescriptor.fromBytes(
                await getBytesFromAsset('assets/images/carnearby5.png', 50)),
            anchor: const Offset(0.5, 0.5),
            flat: true,
            rotation: bearing,
            draggable: false);

        //Adding new marker to our list and updating the google map UI.
        _markers.add(carMarker1);
        mapMarkerSink.add(_markers);

        //Moving the google camera to the new animated location.
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: newPos, zoom: 15.5)));
      });

    //Starting the animation
    animationController.forward();
  }
  animateCar(
      double fromLat, //Starting latitude
      double fromLong, //Starting longitude
      double toLat, //Ending latitude
      double toLong, //Ending longitude
      StreamSink<List<Marker>>
      mapMarkerSink, //Stream build of map to update the UI
      TickerProvider
      provider, //Ticker provider of the widget. This is used for animation
      GoogleMapController controller, //Google map controller of our widget
      ) async {
    final double bearing =
    getBearing(LatLng(fromLat, fromLong), LatLng(toLat, toLong));
    var rn = new Random();
    int num = 1 + rn.nextInt(6 - 1);
    _markers.clear();

    var locationMarker = Marker(
      markerId: MarkerId('Marker1'),
      position:
      LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      infoWindow: InfoWindow(title: 'Pick Up Location'),
      icon: BitmapDescriptor.fromBytes(
          await getBytesFromAsset('assets/images/StartL.png',90)),
    );

    var carMarker = Marker(
        markerId: const MarkerId("driverMarker"),
        position: LatLng(fromLat, fromLong),
        icon: BitmapDescriptor.fromBytes(
            await getBytesFromAsset('assets/images/carnearby5.png', 60)),
        anchor: const Offset(0.5, 0.5),
        flat: true,
        rotation: bearing,
        draggable: false);

    //Adding initial marker to the start location.
    _markers.add(carMarker);
    mapMarkerSink.add(_markers);
    _markers.add(locationMarker);

    final animationController = AnimationController(
      duration: const Duration(seconds: 5), //Animation duration of marker
      vsync: provider, //From the widget
    );

    Tween<double> tween = Tween(begin: 0, end: 1);

    _animation = tween.animate(animationController)
      ..addListener(() async {
        //We are calculating new latitude and logitude for our marker
        final v = _animation!.value;
        double lng = v * toLong + (1 - v) * fromLong;
        double lat = v * toLat + (1 - v) * fromLat;
        LatLng newPos = LatLng(lat, lng);

        //Removing old marker if present in the marker array
        if (_markers.contains(carMarker)) _markers.remove(carMarker);

        //New marker location
        carMarker = Marker(
            markerId: const MarkerId("driverMarker"),
            position: newPos,
            icon: BitmapDescriptor.fromBytes(
                await getBytesFromAsset('assets/images/carnearby5.png', 50)),
            anchor: const Offset(0.5, 0.5),
            flat: true,
            rotation: bearing,
            draggable: false);

        //Adding new marker to our list and updating the google map UI.
        _markers.add(carMarker);
        mapMarkerSink.add(_markers);

        //Moving the google camera to the new animated location.
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: newPos, zoom: 15.5)));
      });
    for (int i = 1; i < num; i++) {
      var randomDeltaForLat =
      ((10 + Random().nextInt(40)) / 10000.00).toDouble();
      var randomDeltaForLng =
      ((10 + Random().nextInt(40)) / 10000.00).toDouble();
      var lngFakeNearby = currentLocation!.longitude! + randomDeltaForLng;
      var latFakeNearby = currentLocation!.latitude! + randomDeltaForLat;

      var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);
      requestCab(myLocation, bookedCabCurrentLocation,i);
    }
    //Starting the animation
    animationController.forward();
  }
  requestCab(LatLng? pickUpLocation, LatLng? dropLocation,int i) async {
    var randomOperatorForLat = Random().nextInt(1);
    var randomOperatorForLng = Random(1).nextInt(1);

    var randomDeltaForLat = ((10 + Random().nextInt(40)) / 10000.00).toDouble();
    var randomDeltaForLng = ((10 + Random().nextInt(40)) / 10000.00).toDouble();

    if (randomOperatorForLat == 1) {
      randomDeltaForLat *= -1;
    }
    if (randomOperatorForLng == 1) {
      randomDeltaForLng *= -1;
    }

    var latFakeNearby = pickUpLocation!.latitude + randomDeltaForLat;
    var lngFakeNearby = pickUpLocation!.longitude + randomDeltaForLng;

    var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);
    Uint8List markerIcon =
    await getBytesFromAsset('assets/images/carnearby5.png', 50);
    //final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon));
    // var config = createLocalImageConfiguration(context, size: Size(6, 6));
    final icon = await BitmapDescriptor.fromBytes(markerIcon);

    if (mounted) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('Marker'+ i.toString()),
            position: bookedCabCurrentLocation,
            infoWindow: InfoWindow(title: 'Drivers'),
            icon: icon,
          ),
        );
      });
    }
  }
  double getBearing(LatLng begin, LatLng end) {
    double lat = (begin.latitude - end.latitude).abs();
    double lng = (begin.longitude - end.longitude).abs();

    if (begin.latitude < end.latitude && begin.longitude < end.longitude) {
      return degrees(atan(lng / lat));
    } else if (begin.latitude >= end.latitude &&
        begin.longitude < end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 90;
    } else if (begin.latitude >= end.latitude &&
        begin.longitude >= end.longitude) {
      return degrees(atan(lng / lat)) + 180;
    } else if (begin.latitude < end.latitude &&
        begin.longitude >= end.longitude) {
      return (90 - degrees(atan(lng / lat))) + 270;
    }
    return -1;
  }
}