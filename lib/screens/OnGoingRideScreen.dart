// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';
import 'dart:ui';

import 'package:taxi_booking/Core/Enums/Enums.dart';
import 'package:taxi_booking/Core/ProviderModels/RideBookedModel.dart';
import 'package:taxi_booking/Core/Utils/BasicShapeUtils.dart';
import 'package:taxi_booking/widgets/DriverDetailsWithPin.dart';
import 'package:taxi_booking/widgets/DriverReachedWidget.dart';
import 'package:taxi_booking/models/direction%20_details.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import 'package:taxi_booking/services/apimanagerdio.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';

import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../constants.dart';
import '../main.dart';
import 'package:taxi_booking/dto/driverCurrentlocationdto.dart';

import '../size_config.dart';


class OnGoingRideScreen extends StatefulWidget {
  final String? NewRouteId;
  final String? FullName;
  final String? Dropofflatitude;
  final String? Dropofflongitude;
  final String? Pickuplatitude;
  final String? Pickuplongitude;
  final String? DropoffAddress;
  final String? PickupAddress;
  final String? Phone;
  //
  const OnGoingRideScreen({
    this.NewRouteId,
    this.FullName,
    this.Dropofflatitude,
    this.Dropofflongitude,
    this.Pickuplatitude,
    this.Pickuplongitude,
    this.DropoffAddress,
    this.PickupAddress,
    this.Phone,}) ;

  static String routeName = "/onGoingRideScreen";
  static const TAG = "OnGoingRideScreen";

  @override
  _OnGoingRideScreenState createState() => _OnGoingRideScreenState();
}

class _OnGoingRideScreenState extends State<OnGoingRideScreen> {
  _OnGoingRideScreenState();
  final rideBookedProvider = RideBookedModel();
  late LatLng originLatlong;
  LatLng? driverLatlong;
  LatLng? destLatlong;
  String? SourceName;
  DirectionDetails? tripDirectionDetails;
  String? _placeDistance="0";
  String? _duration="0";
  String? duration="0";
  DriverCurrentLocation? _updateLocationDto;
  LocationData? currentLocation;
  Timer? timer;
// a reference to the destination location
  LocationData? destinationLocation;
// wrapper around the location API
  // wrapper around the location API
  Location? location;
  @override
  void initState() {
    super.initState();
    //timer.cancel();
    var initialPos = Provider
        .of<AppData>(context, listen: false)
        .pickUpLocation;
    var finalPos = Provider
        .of<AppData>(context, listen: false)
        .dropOffLocation;
    originLatlong=LatLng(initialPos!.latitude!, initialPos!.longitude!);
    destLatlong=LatLng(finalPos!.latitude!, finalPos!.longitude!);
    SourceName=initialPos.placeName;
    intTimer();
  }
  //
  int Arrivednotfication=0;
  Future<DriverCurrentLocation?> _getDriverCurrentLocation() async {
    try
    {

      DriverCurrentLocation configData =
      DriverCurrentLocation(
        userName: (await SystemConfig.getStringValuesSF("userName"))!,
        passWord: (await SystemConfig.getStringValuesSF("passWord"))!,
        RouteId: widget.NewRouteId??"132",
        passengerId : (await SystemConfig.getStringValuesSF("passengerId")?? "37"),

      );
      _updateLocationDto =await APIManagerDio().getDriverCurrentLocation(configData);
      if (_updateLocationDto!.CurrentLatitude!.isNotEmpty)
      {
        if(_updateLocationDto!.RouteStatusId=="4")
        {
          if(Arrivednotfication==0)
          {
            //showNotification();
            Arrivednotfication++;
          }
        }
        setState(() {

          driverLatlong=LatLng(double.tryParse(_updateLocationDto!.CurrentLatitude!)!, double.tryParse(_updateLocationDto!.CurrentLongitude!)!);

        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  @override
  void dispose() {
    super.dispose();
  }
  void intTimer()
  {

    const interval=Duration(seconds: 10);
    timer=Timer.periodic(interval, (timer) async{
      await _getDriverCurrentLocation();
    });
  }
  GoogleMapController? mapController;
  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();
  PolylinePoints? polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: 160,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            isDraggable: false,
            defaultPanelState: PanelState.OPEN,
            color: Colors.transparent,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                blurRadius: 8.0,
                color: Color.fromRGBO(0, 0, 0, 0),
              )
            ],
            borderRadius: ShapeUtils.borderRadiusGeometry,
            body:
            GoogleMapsWidget(
              apiKey: mapKey,
              sourceLatLng: originLatlong,
              destinationLatLng: destLatlong!,
              defaultCameraZoom: 16,
              routeWidth: 4,
              routeColor: kPrimaryColor,
              sourceMarkerIconInfo: MarkerIconInfo(
                assetPath: "assets/images/Start.png",
                assetMarkerSize: Size.square(70),
              ),
              destinationMarkerIconInfo: MarkerIconInfo(
                assetPath: "assets/images/End.png",
                assetMarkerSize: Size.square(70),
              ),
              driverMarkerIconInfo: MarkerIconInfo(
                assetPath: "assets/images/Freight.jpg",
                assetMarkerSize: Size.square(90),
              ),
              // sourceName: SourceName!,
              // driverName: "",
              // onTapDriverMarker: (currentLocation) {
              //   print("Driver is currently at $currentLocation");
              // },
              totalTimeCallback: (time) => print(time),
              totalDistanceCallback: (distance) => print(distance),
              // mock stream
              driverCoordinatesStream: Stream.periodic(
                Duration(milliseconds: 5000),
                    (i) =>
                        LatLng(
                      driverLatlong!.latitude??originLatlong.latitude,
                      driverLatlong!.longitude??originLatlong.longitude,
                ),

              ),
            ),

            panel: rideBookedProvider.driverStatus == DriverStatus.OnWay
                ? DriverDetailsWithPin((widget.FullName!=null?widget.FullName:"")!,"4.9",(widget.Phone!=null?widget.Phone:"09")!,(widget.NewRouteId!=0?widget.NewRouteId:"")!,"A-12345")
                : rideBookedProvider.driverStatus == DriverStatus.InRoute
                ? DriverDetailsWithPin((widget.FullName!=null?widget.FullName:"")!,"4.9",(widget.Phone!=null?widget.Phone:"09")!,(widget.NewRouteId!=0?widget.NewRouteId:"")!,"A-12345")
                : DriverReachedWidget(),
          ),

          Padding(
            padding: const EdgeInsets.only(
                top: kToolbarHeight * 1, left: 20, right: 20),
            child: SizedBox(
              height: kToolbarHeight * 1.5,
              width: double.infinity,
              child: Card(
                color: kPrimaryColor,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            Icons.directions_car,
                            color: Colors.white,
                          ),
                          Text(
                            duration!
                                ,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white30,
                      height: kToolbarHeight * 1.5,
                      width: 3,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          SourceName!,
                          maxLines: 2,
                          style: TextStyle(fontSize: getProportionateScreenWidth(17), color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
