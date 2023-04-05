import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'dart:typed_data';
import 'package:taxi_booking/dto/SetConfigDriverDto.dart';
import 'package:taxi_booking/dto/SetDriverRequestDetailsDto.dart';
import 'package:taxi_booking/models/direction%20_details.dart';
import 'package:taxi_booking/screens/Assitants/assitantMethods.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_booking/constants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'dart:ui' as ui;
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import '../../wellcome.dart';
import '../search_screen.dart';
import 'package:flutter/cupertino.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomeMapPage extends StatefulWidget {
  static String routeName = "/HomeMapPage";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeMapPage> with WidgetsBindingObserver {
  _MyHomePageState();
  LatLng? destinationLatLng;
  LatLng? destLatLng;
  late LatLng sourceLatLng;
  LatLng? pickUpLatLng;
  late LatLng originLatlong;
  LatLng? destLatlong;
  late LocationData currentLocation;
  late LocationData destinationLocation;
  late Location location;
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  late bool loading = false;

  Circle createCircle(LatLng latLng) {
    final String circleId = 'circle_id_${latLng.latitude}_${latLng.longitude}';
    return Circle(
      circleId: CircleId(circleId),
      center: latLng,
      radius: 300,
      fillColor: Colors.blue.shade100.withOpacity(0.5),
      strokeWidth: 50,
      strokeColor: Colors.blue.shade100.withOpacity(0.1),
    );
  }

  @override
  void initState() {
    Timer(Duration(seconds: 15), () {
      if ( loading==false)
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WellCome()));
        }
    });
    super.initState();
    getMyLocation();
    WidgetsBinding.instance.addObserver(this);
    if(destLatLng!=null) {
      destLatlong = destLatLng!;
    }
    if(pickUpLatLng!=null) {
      originLatlong = pickUpLatLng!;
    }
    
    location = new Location();
    // polylinePoints = PolylinePoints();
    // subscribe to changes in the user's location
    // by "listening" to the location's onLocationChanged event
    location.onLocationChanged.listen((LocationData cLoc) {
      // cLoc contains the lat and long of the
      // current user's position in real time,
      // so we're holding on to it
      currentLocation = cLoc;

      if (mounted) {
        setState(() {
          _circles.clear();
          _circles.add(createCircle(LatLng(cLoc.latitude!, cLoc.longitude!)));
          cabCurrentLocation=LatLng(cLoc.latitude!, cLoc.longitude!);
        });
      }
      //  updatePinOnMap();
    });
    if(cabCurrentLocation!=null) {
      intTimer();
    }
  }

  @override
  void dispose() {
    _circles.clear();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  void intTimer()
  {
    const interval=Duration(seconds: 2);
    timer=Timer.periodic(interval, (timer) async{
      durationCounter=durationCounter+1;

      setState(() {

        getUpdateLocation();

      });
    });
  }
  List<LatLng> polylineCoordinates = [];
  late DirectionDetails tripDirectionDetails;

  late Timer timer;
  late Timer timerUpdate;
  int durationCounter = 0;
  String isDriverAvailable = "0";
  Color driverStatusColor = Colors.black;
  late DriversDto _getsetofflineoronline;
  late DriverRequestDetailsDto _getSetRequestAccept;
  late String driverStatusText;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};
  late PolylineId selectedPolyline;
  String status = "";
  String durationRide = "";
  bool isRequestingDirection = false;
  String btnTitle = "Wait.";
  Color btnColor = kPrimaryColor;
  late Position myPostion;
  late Position currentPosition;
  List<LatLng> polyLineCordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> markerSet = Set<Marker>();
  Set<Circle> circleSet = Set<Circle>();
  Set<Polyline> polylineSet = Set<Polyline>();
  late GoogleMapController newGoogleMapController;
  Map<MarkerId, Marker> markers = {};
  var cabCurrentLocation ;
  set rideStreamSubscription(
      StreamSubscription<Position> rideStreamSubscription) {}

//local notification

  // Values when toggling polyline color
  int colorsIndex = 0;
  List<Color> colors = <Color>[
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];

  // Values when toggling polyline width
  int widthsIndex = 0;
  List<int> widths = <int>[10, 20, 5];

  int jointTypesIndex = 0;
  List<JointType> jointTypes = <JointType>[
    JointType.mitered,
    JointType.bevel,
    JointType.round
  ];

  // Values when toggling polyline end cap type
  int endCapsIndex = 0;
  List<Cap> endCaps = <Cap>[Cap.buttCap, Cap.squareCap, Cap.roundCap];

  // Values when toggling polyline start cap type
  int startCapsIndex = 0;
  List<Cap> startCaps = <Cap>[Cap.buttCap, Cap.squareCap, Cap.roundCap];

  // Values when toggling polyline pattern
  int patternsIndex = 0;
  List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[],
    <PatternItem>[
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)],
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)],
  ];

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high);
    currentPosition = position;
    LatLng latlangPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latlangPosition, zoom: 14);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await AssistantMethods().searchCordinateAddress(position, context);
    print("this is your address" + address);
    // ColorizeAnimatedTextKit();
  }

  Future<void> getUpdateLocation() async {
    Uint8List markerIcon =
    await getBytesFromAsset('assets/images/carnearby5.png', 40);
    final icon = await BitmapDescriptor.fromBytes(markerIcon);

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);

      if (mounted) {
        this.setState(() {
          myLocation = LatLng(position.latitude, position.longitude);
          List<Marker> list = [
            Marker(
              markerId: MarkerId('Marker7'),
              position:
              cabCurrentLocation + cabCurrentLocation / 10000,
              infoWindow: InfoWindow(title: 'Pick Up Location'),
              icon: icon,
            )
          ];
          setState(() {
            _markers.addAll(list);
            cabCurrentLocation=cabCurrentLocation + cabCurrentLocation / 10000;
          });
        });
      }

    } catch (ex) {}

    // print(position);
  }
  Future<void> getMyLocation() async {
    var rn = new Random();
    int num = 1 + rn.nextInt(6 - 1);
    final icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(6, 6)), 'assets/images/StartL.png');
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      Geolocator.getCurrentPosition(
          desiredAccuracy: geolocator.LocationAccuracy.high);
      // myLocation = LatLng(position.latitude, position.longitude);
      String address =
          await AssistantMethods().searchCordinateAddress(position, context);
      print("this is your address" + address);
      loading = true;
      //placeAddress=
      if (mounted) {
        this.setState(() {
          myLocation = LatLng(position.latitude, position.longitude);
          List<Marker> list = [
            Marker(
              markerId: MarkerId('Marker1'),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(title: 'Pick Up Location'),
              icon: icon,
            )
          ];
          setState(() {
            _markers.addAll(list);
          });
        });
      }
      for (int i = 2; i < num; i++) {
        var randomDeltaForLat =
            ((10 + Random().nextInt(40)) / 10000.00).toDouble();
        var randomDeltaForLng =
            ((10 + Random().nextInt(40)) / 10000.00).toDouble();
        var lngFakeNearby = position.longitude + randomDeltaForLng;
        var latFakeNearby = position.latitude + randomDeltaForLat;

        var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);
        requestCab(myLocation, bookedCabCurrentLocation,i);
      }
    } catch (ex) {}

    // print(position);
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

  requestCab(LatLng pickUpLocation, LatLng dropLocation,int i) async {
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

    var latFakeNearby = pickUpLocation.latitude + randomDeltaForLat;
    var lngFakeNearby = pickUpLocation.longitude + randomDeltaForLng;

    var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);
    Uint8List markerIcon =
        await getBytesFromAsset('assets/images/carnearby.png', 40);
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

 late Completer<GoogleMapController> controller1;

  static LatLng? _initialPosition;
  final Set<Marker> _markers = {};
  static LatLng _lastMapPosition = _initialPosition!;
  MapType _currentMapType = MapType.normal;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }
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

  late LatLng myLocation;

  final marker = Marker(
    markerId: MarkerId('place_name'),
    position: LatLng(9.669111, 80.014007),
    // icon: BitmapDescriptor.,
    infoWindow: InfoWindow(
      title: 'title',
      snippet: 'address',
    ),
  );
  bool drawerOpen = true;

  late GoogleMapController _controller;
  Location _location = Location();

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

  Set<Circle> _circles = HashSet<Circle>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Stack(
              children: <Widget>[
                GoogleMap(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.40,
                      top: MediaQuery.of(context).size.height * 0.38),

                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  mapType: _currentMapType,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  compassEnabled: true,
                  markers: Set<Marker>.of(_markers),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(myLocation.latitude, myLocation.longitude),
                    zoom: 16.0,
                  ),
                  // onCameraMove: null,
                  circles: _circles,
                ),

                // GoogleMap(
                //   mapType: _currentMapType,
                //   initialCameraPosition: CameraPosition(
                //     //target: LatLng(myLocation.latitude, myLocation.longitude),
                //     target: LatLng(9.669111, 80.014007),
                //     zoom: 16.0,
                //   ),
                //   //onMapCreated: _onMapCreated,
                //   markers: markers.values.toSet(),
                //   zoomGesturesEnabled: true,
                //  // onCameraMove: _onCameraMove,
                //   myLocationEnabled: true,
                //   compassEnabled: true,
                //   myLocationButtonEnabled: false,
                //   circles: Set.from([Circle( circleId: CircleId('currentCircle'),
                //     center: originLatlong,
                //     radius: 1000,
                //     fillColor: Colors.blue.shade100.withOpacity(0.5),
                //     strokeColor:  Colors.blue.shade100.withOpacity(0.1),
                //   ),],),
                //
                // ),
                Positioned(
                  top: 50.0,
                  left: 22.0,
                  child: GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                0.7,
                                0.7,
                              ))
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          (drawerOpen) ? Icons.menu : Icons.close,
                          color: Colors.black,
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
                                color: Colors.white,
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
                      color: Colors.white70,
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


                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: getProportionateScreenWidth(MediaQuery.of(context).size.width),
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
                                      margin: const EdgeInsets.only(
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
                                          color: Colors.white,
                                          height:
                                              getProportionateScreenHeight(2.5),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              )),

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
                                  Text(
                                    "${Provider.of<AppData>(context).pickUpLocation != null ? Provider.of<AppData>(context).pickUpLocation!.placeFormattedAddress : ""}",
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      fontSize: getProportionateScreenWidth(12),
                                    ),

                                  ),
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
            )
          : Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(250)),
              child: ProgressDialog(
                  message: LocaleKeys.Please_wait_for_the_network.tr()),
            ),
    );
  }



}
