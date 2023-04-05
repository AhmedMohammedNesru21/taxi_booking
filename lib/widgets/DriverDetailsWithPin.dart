


import 'package:taxi_booking/dto/SetConfigRequestDto.dart';
import 'package:taxi_booking/screens/homeMapView/viewMap.dart';
import 'package:taxi_booking/services/apimanagerdio.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/constants.dart';

import '../size_config.dart';

class DriverDetailsWithPin extends StatelessWidget {
  static String routeName = "/DriverDetailsWithPin";

  late final String  Fullname;
  late final String driverRating;
  late final String carCompanyName;
  late final String pin ;
  late final String carNumber;
  late ChinetRequestDto _chinetRequestDtoDto;
  DriverDetailsWithPin(this.Fullname,this.driverRating,this.carCompanyName,this.pin,this.carNumber);
  // Future<ChinetRequestDto> _setCancel() async {
  //   try {
  //
  //
  //     ChinetRequestDto _chinetRequestDto = new ChinetRequestDto(
  //       userName: await SystemConfig.getStringValuesSF("userName"),
  //       password: await SystemConfig.getStringValuesSF("passWord"),
  //       //imei:"359175104936577",
  //       isSuccess : "1",
  //       lastModified : (await SystemConfig.getStringValuesSF("last_modified")!= null? await SystemConfig.getStringValuesSF("last_modified"): "1970-01-01"),
  //       createdAt:DateTime.now().toString(),
  //       passengerId:(await SystemConfig.getStringValuesSF("passengerId")!= null? await SystemConfig.getStringValuesSF("passengerId"): "37"),
  //       statusId:"3",
  //       ReasonId:"2",
  //       AmountPaid:"0",
  //
  //
  //     );
  //     _chinetRequestDtoDto = await APIManagerDio().setConfigRequest(_chinetRequestDto);
  //     if (_chinetRequestDtoDto.isSuccess == "1") {
  //
  //     }
  //   } catch (e) {
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // final rideBookedModel = Provider.of<RideBookedModel>(context);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          boxShadow: [
            BoxShadow(
              blurRadius: 20.0,
              color: Colors.grey,
            ),
          ]),
      margin: const EdgeInsets.all(8.0),
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkResponse(
                onTap: () async {
                  //_showCancelDialog();
                  Navigator.of(context).pushReplacementNamed(MapPage.routeName);
                  // await _setCancel();
                },
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                        height: 80,
                        child: ClipOval(

                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: Constants.avatarRadius,
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                                child: Image.asset("assets/images/Profile Image.png")),
                          ),

                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: kPrimaryColor,
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              // rideBookedModel.currentDriver.driverName +
                              Fullname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // rideBookedModel.currentDriver.driverRating
                              //     .toString() +
                              driverRating+
                                  " \u2605",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenWidth(15),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          carCompanyName,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "Pin : " + pin,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(15),
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Text(
                          // rideBookedModel.currentDriver.carDetail.carNumber,
                          carNumber,
                          // "A-234567",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
