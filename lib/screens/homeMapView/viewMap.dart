import 'dart:async';

import 'package:taxi_booking/Core/Models/CarTypeMenu.dart';
import 'package:taxi_booking/models/Rates.dart';
import 'package:taxi_booking/models/Routers.dart';
import 'package:taxi_booking/models/cancelationReasons.dart';
import 'package:taxi_booking/models/direction%20_details.dart';
import 'package:taxi_booking/models/extraRates.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';
import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_widget/google_maps_widget.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:taxi_booking/screens/OnGoingRideScreen.dart';
import 'package:taxi_booking/components/default_button.dart';
import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/repository/db_service.dart';
import 'package:taxi_booking/screens/Assitants/assitantMethods.dart';
import 'package:taxi_booking/services/apimanagerdio.dart';
import 'package:taxi_booking/dto/SetConfigRequestDto.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../size_config.dart';


class MapPage extends StatefulWidget {

  static String routeName = "/MapView";
  final String? extraRateId, distanceOffRoad,weight,scheduledDate,scheduledTime,rateId;
  final CarTypeMenu? carTypeMenu;
  final int? selectedIndex;
  const MapPage(
      {
        this.rateId,
        this.extraRateId,
        this.distanceOffRoad,
        this.carTypeMenu,
        this.weight,
        this.scheduledDate,
        this.scheduledTime,
        this.selectedIndex
      });

  @override
  State<StatefulWidget> createState() => MapPageState();
}

class MapPageState extends State<MapPage> with WidgetsBindingObserver {
  late LatLng originLatlong;
  late LatLng destLatlong;
  late String SourceName;
  late DirectionDetails tripDirectionDetails;
  String _placeDistance="0";
  String _duration="0";
  String duration="0";
  double rideDetailContainer = 230;
  double searchContainerHeight = 0;
  double requestRideContainerHeight = 0;
  bool drawerOpen = true;
  var buttomPaddingOfMap = 0.0;
  late int? _totoalAmount;
  int? _grandTotal=0;
  int _offRoadAmount=0;
  String extraRateValue="0";
  bool _isCancle = false;
  List<CancelationReasons> _CancelDropDown = [];
  var _dbService = DBService();
  late String _chosenGearType;
  late List<ExtraRates> xRates ;
  late List<Rates> rate ;
  late ChinetRequestDto _chinetRequestDtoDto;
  late String rateType;
  late GoogleMapController mapController;
  void showNotification() {

  }
  _loadCancelDropDown() async {
    _CancelDropDown.clear();
    var _cancleService = await _dbService.getAllCancelationReasons();
    _cancleService.forEach((cancelation) {
      setState(() {
        _CancelDropDown.add(CancelationReasons(
          reasonName: cancelation['reasonName'],
          Id: cancelation['Id'].toString(), reasonDescription: '', remark: '', isDeleted: '', lastModifiedDate: '',
        ));
      });
    });
  }
  @override
  void initState() {
    super.initState();
    var initialPos = Provider
        .of<AppData>(context, listen: false)
        .pickUpLocation;
    var finalPos = Provider
        .of<AppData>(context, listen: false)
        .dropOffLocation;
    // initi
    originLatlong=LatLng(initialPos!.latitude!, initialPos.longitude!);
    destLatlong=LatLng(finalPos!.latitude!, finalPos.longitude!);
    SourceName=initialPos.placeName!;
    _calculateDistance(originLatlong,destLatlong);
    // _DistanceDuration(originLatlong,destLatlong);
    _loadCancelDropDown();


  }
  Future<bool?> _calculateDistance(var oPickUpLatLng, var oDropOffLatLng) async {
    try {
      var _killoMeterPrice;
      var _offRoadAmount;
      var details = await AssistantMethods.obtainPlaceDirection(
          oPickUpLatLng, oDropOffLatLng);
      tripDirectionDetails=details!;
      if(widget.rateId!=null && widget.rateId!="") {
        var _extraRateTypes=await _dbService.getExtraRateTypes(widget.rateId!);
        if(_extraRateTypes[0].rateName.toString()!=null)
        {
          if(_extraRateTypes[0].rateName.toString()=='Normal')
          {
            var _rate = await _dbService.getRatesValue("1");
            _killoMeterPrice= _rate[0].ratePerKilloMeterPrice.toString();
          }
          else
          {
            var _extraRate;
            if(widget.extraRateId!=null && widget.extraRateId!="") {
              _extraRate = await _dbService.getExtraRatesValue(
                  widget.extraRateId!);
            }
            _killoMeterPrice= _extraRate[0].rateValue.toString();
            if(widget.distanceOffRoad !=null && widget.distanceOffRoad !="") {
              double? distance = double.parse(widget.distanceOffRoad!)/1000;
              _offRoadAmount=(distance*_killoMeterPrice).truncate();
            }

          }
        }
      }
      setState(() {
        _placeDistance=tripDirectionDetails.distanceText!;
        _duration=tripDirectionDetails.durationText!;

        if(_killoMeterPrice !=null && _killoMeterPrice !="") {
          _totoalAmount=(int.parse(_killoMeterPrice)*(tripDirectionDetails.distanceValue!/1000)).truncate();
        }
        if (_offRoadAmount!=0 && _offRoadAmount!=null)
        {
          _grandTotal=(_totoalAmount! +_offRoadAmount) as int?;
        }
        else
        {
          _grandTotal=_totoalAmount;
        }

      });


    }
    catch (ex) {

    }
  }
  Future<ChinetRequestDto?> _setRequest() async {
    try {
      String? struserUpdate = await SystemConfig.getStringValuesSF("userUpdate");
      var initialPos = Provider
          .of<AppData>(context, listen: false)
          .pickUpLocation;
      var finalPos = Provider
          .of<AppData>(context, listen: false)
          .dropOffLocation;
      ChinetRequestDto _chinetRequestDto = new ChinetRequestDto(
          userName : (await SystemConfig.getStringValuesSF("userName")!= null? await SystemConfig.getStringValuesSF("userName"): "user001")!,
          password: (await SystemConfig.getStringValuesSF("passWord")!= null? await SystemConfig.getStringValuesSF("passWord"): "1234")!,
          lastModified : DateTime.now().toString(),
          createdAt:DateTime.now().toString(),
          Dropofflatitude:finalPos!.latitude.toString(),
          Dropofflongitude:finalPos!.longitude.toString(),
          Pickuplatitude:initialPos!.latitude.toString(),
          Pickuplongitude:initialPos!.longitude.toString(),
          DropoffAddress:finalPos!.placeName!,
          PickupAddress:initialPos!.placeName!,
          passengerId:(await SystemConfig.getStringValuesSF("passengerId")!= null? await SystemConfig.getStringValuesSF("passengerId"): "37")!,
          statusId:"1",
         // extraRateValue:extraRateValue,
          ExtraRates:(widget.extraRateId!=null?widget.extraRateId:"")!,
          scheduleddate:(widget.scheduledDate!=null?widget.scheduledDate:"")!,
          scheduledtime:(widget.scheduledTime!=null?widget.scheduledTime:"")!, isSuccess: '', Did: '', requestId: '', RouteId: '', FullName: '', Phone: '', RouteStatusId: '', DriverConfirmTime: '', ArrivalTime: '', DropOffTime: '', ReasonId: '', Killometers: '', AmountPaid: '', MilesPaid: '', IsPaid: ''
      );
      _chinetRequestDtoDto = await APIManagerDio().setConfigRequest(_chinetRequestDto);
      if (_chinetRequestDtoDto.isSuccess == "1") {

        if (_chinetRequestDtoDto.Did == null ||
            _chinetRequestDtoDto.Did == "null") {
          if(_isCancle==false) {
            showNotification();
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(
                    'Driver is unavailable.'),
              ),
            );
          }

        }
        else {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.success_to_set_request.tr()),

            ),
          );
          bool isLoggedIn = await SystemConfig.SetRequest(_chinetRequestDtoDto);
          if (isLoggedIn) {
            if (_chinetRequestDtoDto.Did.isNotEmpty) {
              if (_chinetRequestDtoDto.Pickuplongitude.isNotEmpty) {
                Routers routers = new Routers(
                  DriverID: _chinetRequestDtoDto.Did,
                  PassengerId: _chinetRequestDtoDto.passengerId,
                  PickupLatitud: _chinetRequestDtoDto.Pickuplatitude,
                  PickupLongtide: _chinetRequestDtoDto.Pickuplongitude,
                  DropOffLatitude: _chinetRequestDtoDto.Dropofflatitude,
                  DropOffLongitude: _chinetRequestDtoDto.Dropofflongitude,
                  DropOffLocationName: _chinetRequestDtoDto.DropoffAddress,
                  DriverCofirmTime: "0",
                  ArrivalTime: "0",
                  DropOffTime: "0",
                  RouterNote: "",
                  DriverRating: "",
                  PassangerRating: "0",
                  KiloMeters: _chinetRequestDtoDto.Killometers,
                  AmountPaid: "0", PickupLocationName: '', Password: '',

                );
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (c, a1, a2) =>
                        OnGoingRideScreen(
                          NewRouteId: _chinetRequestDtoDto.RouteId,
                          FullName: _chinetRequestDtoDto.FullName,
                          Dropofflatitude: _chinetRequestDtoDto.Dropofflatitude,
                          Dropofflongitude: _chinetRequestDtoDto
                              .Dropofflongitude,
                          Pickuplatitude: _chinetRequestDtoDto.Pickuplatitude,
                          Pickuplongitude: _chinetRequestDtoDto.Pickuplongitude,
                          DropoffAddress: _chinetRequestDtoDto.DropoffAddress,
                          PickupAddress: _chinetRequestDtoDto.PickupAddress,
                          Phone: _chinetRequestDtoDto.Phone,

                        ),
                    transitionsBuilder: (c, anim, a2, child) =>
                        FadeTransition(
                            opacity: anim, child: child),
                    transitionDuration:
                    Duration(milliseconds: 3000),
                  ),
                );
                // Navigator.pushNamed(context, OnGoingRideScreen.routeName);
              }
            }
          }
          else {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(
                    LocaleKeys.unable_to_set_request.tr()),
              ),
            );
          }
        }
      }
      else
        {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeMapScreen()));
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(
                  LocaleKeys.unable_to_set_request.tr()),
            ),
          );

        }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
              LocaleKeys.internet_connection_problem.tr()),
        ),
      );
    }
  }

  Future<ChinetRequestDto?> _setCancel() async {
    try {
      String? struserUpdate = await SystemConfig.getStringValuesSF("userUpdate");
      var initialPos = Provider
          .of<AppData>(context, listen: false)
          .pickUpLocation;
      var finalPos = Provider
          .of<AppData>(context, listen: false)
          .dropOffLocation;
        ChinetRequestDto _chinetRequestDto = new ChinetRequestDto(
        userName : (await SystemConfig.getStringValuesSF("userName")!= null? await SystemConfig.getStringValuesSF("userName"): "user001")!,
        password: (await SystemConfig.getStringValuesSF("passWord")!= null? await SystemConfig.getStringValuesSF("passWord"): "1234")!,
       // imei:widget.selectedIndex.toString(),
        isSuccess : "1",
          lastModified : (await SystemConfig.getStringValuesSF("last_modified")!= null? await SystemConfig.getStringValuesSF("last_modified"): "1970-01-01")!,
        createdAt:DateTime.now().toString(),
        Did:"",
        DropoffAddress:finalPos!.placeName!,
        Dropofflatitude:finalPos!.latitude.toString(),
        Dropofflongitude:finalPos!.longitude.toString(),
        passengerId:(await SystemConfig.getStringValuesSF("passengerId")!= null? await SystemConfig.getStringValuesSF("passengerId"): "37")!,
        PickupAddress:initialPos!.placeName!,
        Pickuplatitude:initialPos!.latitude.toString(),
        Pickuplongitude:initialPos!.longitude.toString(),
        statusId:"3",
        FullName:"",
        DriverConfirmTime:"",
        ArrivalTime:"",
        DropOffTime:"",
        ReasonId:_chosenGearType,
        Killometers:"",
        AmountPaid:_grandTotal.toString(),
        MilesPaid:"",
        IsPaid:"",
        //extraRateValue:"",
        ExtraRates:"",
        scheduleddate:"",
        scheduledtime:"", requestId: '', RouteId: '', Phone: '', RouteStatusId: '',

      );

      _chinetRequestDtoDto = await APIManagerDio().setConfigRequest(_chinetRequestDto);
      if (_chinetRequestDtoDto.isSuccess == "1") {
        if(_chinetRequestDtoDto!=null)
          {
            _chinetRequestDtoDto.Phone=widget.selectedIndex.toString();
            _chinetRequestDtoDto.ReasonId=_chosenGearType;
            _chinetRequestDtoDto.AmountPaid=_grandTotal.toString();

            await _dbService.insertRouters(_chinetRequestDtoDto);
          }


        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(
            content: Text( LocaleKeys.success_to_set_cancel.tr()),
          ),
        );
        bool isLoggedIn = await SystemConfig.SetRequest(_chinetRequestDtoDto);

      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
              LocaleKeys.internet_connection_problem.tr()),
        ),
      );
    }
  }

  void displayRequestRideContainer() {
    setState(() {
      requestRideContainerHeight = 265.0;
      rideDetailContainer = 0;
      buttomPaddingOfMap = 230.0;
      drawerOpen = true;
    });
    saveRideRequest();
  }
  void saveRideRequest() async {
    await _setRequest();
   // await _setSendFCMRequest();
    // rideRequestRef.set(riderinfoMap);
  }
  void cancelRideRequest() {
    // rideRequestRef.remove() _textFieldController;
    _displayDialog(context);
  }
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,

        builder: (context) {
          return AlertDialog(
              shape:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            title: Text(LocaleKeys.reasons_for_cancellation.tr(),style: TextStyle(

              fontSize: getProportionateScreenWidth(12),

            ),),
            content:

            DropdownButtonFormField(
              value:  _chosenGearType,
              items: _CancelDropDown.map((CancelationReasons map) {
                return new DropdownMenuItem(
                  value: map.Id.toString(), //must be  one of  actNo.
                  child: new Text(
                    map.reasonName,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style:TextStyle(
                      fontSize: getProportionateScreenWidth(10),
                    ) ,
                  ),
                );
              }).toList(),
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(30.0),
                  ),
                ),
              ),
              hint: Text(
                LocaleKeys.please_select_reason.tr(),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: getProportionateScreenWidth(9),

                ),
              ),
              icon: Icon(
                Icons.arrow_drop_down_circle_sharp,
                color: kPrimaryColor, // Add this
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _chosenGearType = newValue!;

                });
              },
            ),
            actions: <Widget>[
             new TextButton(
               style: ButtonStyle(
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                       RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(50.0),
                           side: BorderSide(color: Colors.white)

                       )
                   )
               ),

               onPressed: () async {
                 await _setCancel();
                 _isCancle = true;
                 Navigator.pushNamed(context, HomeMapScreen.routeName);
               },
                child: new Text(LocaleKeys.submit.tr(),style:TextStyle(color: Colors.white)),
              ),
          // new  FlatButton(
          //   child: new Text(LocaleKeys.submit.tr(),style:TextStyle(color: Colors.white)),
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(50),
          // side: BorderSide(color: Colors.white),
          // ),
          // color: kPrimaryColor,
          // onPressed: () async {
          //     await _setCancel();
          //     _isCancle = true;
          //   Navigator.pushNamed(context, HomeMapScreen.routeName);
          // },
          // ),

            ],
          );
        });
  }

  @override

  resetApp() {
    setState(() {
      searchContainerHeight = 250.0;
      rideDetailContainer = 0.0;
      requestRideContainerHeight = 0;
      buttomPaddingOfMap = 230.0;
      drawerOpen = true;
    });
    // locatePosition();
  }
  getBoxShadow()
  {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(3.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 5.0),
              blurRadius: 10,
              spreadRadius: 3)
        ]);

  }
  getInoutDecoration(hint,icon)
  {
    return InputDecoration(
      icon: Container(
        margin: EdgeInsets.only(left: 20, top: 5),
        width:getProportionateScreenWidth(10),
        height: getProportionateScreenHeight(10),
        child:icon ,
      ),
      hintText: hint,
      border: InputBorder.none,
      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
    );
  }
  // Completer<GoogleMapController> _controller = Completer();
  // //onMapCreated method
  // void onMapCreated(GoogleMapController controller) {
  //   controller.setMapStyle(Utils.mapStyles);
  //   _controller.complete(controller);
  // }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final pickUpState=Provider
        .of<AppData>(context, listen: false)
        .pickUpLocation;
    final dropOffState=Provider
        .of<AppData>(context, listen: false)
        .dropOffLocation;
    return SafeArea(

      child: Scaffold(
          body:Stack(

            children: [

          GoogleMapsWidget(
            trafficEnabled:true,
            buildingsEnabled:true,
            apiKey: mapKey,
            sourceLatLng: originLatlong,
            destinationLatLng: destLatlong,
            defaultCameraZoom: 12,
            routeWidth: 4,
            routeColor: kPrimaryColor,
            sourceMarkerIconInfo: MarkerIconInfo(
              assetPath: "assets/images/Start.png",
              assetMarkerSize: Size.square(80),
            ),
            destinationMarkerIconInfo: MarkerIconInfo(
              assetPath: "assets/images/End.png",
              assetMarkerSize: Size.square(80),
            ),
            driverMarkerIconInfo: MarkerIconInfo(
              assetPath: "assets/images/Freight.jpg",
              assetMarkerSize: Size.square(90),
            ),
            // sourceName: SourceName,
            // driverName: "",
            // onTapDriverMarker: (currentLocation) {
            //   print("Driver is currently at $currentLocation");
            // },
            totalTimeCallback: (time) => print(time),
            totalDistanceCallback: (distance) => print(distance),
          ),

          Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                  child:Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: getProportionateScreenWidth( width * 0.9),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            //ROW 1
                            children: [
                              Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child: Image.asset("assets/images/Start.png",width: 80.0,height: 40,)
                              ),
                      Flexible(
                        child: Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.all(1.0),
                                child: Text(pickUpState!.placeName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                    fontSize: getProportionateScreenWidth(18),
                                    // fontFamily: "Regular",
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black87)
                                ),


                              ),
                      ),

                              Container(
                                margin: EdgeInsets.all(1.0),

                              ),
                            ],
                          ),
                          Row(//ROW 2
                              children: [
                                 Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child: Image.asset("assets/images/brige.png",width: 80.0,height: 30,),
                                ),
                                Flexible(child: Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child:  Visibility(
                                    visible: _placeDistance == null ? true : true,
                                    child: Text(' $_placeDistance   $_duration ',
                                        overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(18),
                                        // fontFamily: "Regular",
                                        // fontWeight: FontWeight.bold,
                                        color:Colors.black,
                                      ),
                                    ),
                                  ),
                                ),),
                                Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child:  Visibility(
                                    visible: _offRoadAmount==0 ? false : true,
                                    child: Text('Off Road amount: $_offRoadAmount ETB',

                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(12),
                                        fontWeight: FontWeight.bold,color:Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ]),
                          Row(// ROW 3
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child: Image.asset("assets/images/End.png",width: 80.0,height: 40,),
                                ),
                                Flexible(child:  Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child:  Text(dropOffState!.placeName!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                      fontSize: getProportionateScreenWidth(18),
                                          // fontFamily: "Regular",
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  )),
                                )),

                              ]),
                          Row(// ROW 4
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child: Text("                ", style: TextStyle(
                                      fontSize: getProportionateScreenWidth(12),
                                      // fontFamily: "Regular",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red
                                  )),

                                ),
                                Container(
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(1.0),
                                  child:Visibility(
                                    visible: _grandTotal == null ? false : true,
                                    child: Text(LocaleKeys.total_amount.tr()+' : $_grandTotal ETB',
                                        overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(18),
                                        // fontFamily: "Regular",
                                        // fontWeight: FontWeight.bold,
                                        color:Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                          SizedBox(height: getProportionateScreenHeight(30),),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(16)),

                            child:DefaultButton(
                              text: LocaleKeys.call_driver.tr(),
                              press: () {

                                displayRequestRideContainer();

                              },
                            ),),
                        ],
                      ),
                    ),
                  ),
        ),
          Positioned(
                bottom: 0.0,
                left: 0.0,
                right:0.0,

                  child: Container(
                    height: getProportionateScreenHeight(requestRideContainerHeight),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),topRight: Radius.circular(20.0)),
                      boxShadow: [BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 16.0,
                        color :Colors.black54,
                        offset:Offset(0.7, 0.7),
                      ),
                      ],
                    ),
                    child :
                    Column(
                      children :[
                        SizedBox(height: getProportionateScreenHeight(12)),
                        SizedBox(
                          width: double. infinity,
                          child: ColorizeAnimatedTextKit(
                            onTap: ( ) {
                              print("Tap Event");},
                            text :[
                              LocaleKeys.please_wait.tr(),
                              LocaleKeys.finding_a_driver.tr() ,
                              LocaleKeys.requesting_a_kayo.tr(),
                            ],
                            textStyle :TextStyle(fontSize:getProportionateScreenWidth(20)),
                           // textStyle :TextStyle(fontSize:getProportionateScreenWidth(30),fontFamily:"Signatra"),
                            colors: [
                              Colors.black87,
                              // Colors.purple,
                              // Colors.pink,
                              // Colors.blue,
                              // Colors.yellow,
                              kPrimaryColor,
                            ],
                            textAlign : TextAlign.center,

                            //alignment:AlignmentDirectional.topStart),
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(22)),
                        GestureDetector(
                          onTap: ()
                          {
                            cancelRideRequest();
                            resetApp();
                          },
                          child:Container(
                              height: getProportionateScreenHeight(60),
                              width: getProportionateScreenWidth(60),
                              decoration :
                              BoxDecoration (
                                color: Colors.white,
                                borderRadius : BorderRadius.circular(26.0) ,
                                border: Border.all(width: 2.0,color: Colors.grey[300]!),),
                              child: Icon(Icons.close, size: getProportionateScreenWidth(26),)
                          ) ,
                        ),
                        SizedBox(height: getProportionateScreenHeight(10),) ,
                        Container(
                          width: double.infinity,
                          child: Text( LocaleKeys.cancel_logistic.tr(),textAlign: TextAlign.center , style :TextStyle (fontSize:getProportionateScreenWidth(12)),),
                        ),

                      ],
                    ),
                  ),
                ),
              //),
                ],
                 ),

               ),
        // ],
        //   )
      // ),
     );
  }
}