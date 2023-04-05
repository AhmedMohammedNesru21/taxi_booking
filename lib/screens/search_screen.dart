
import 'package:taxi_booking/models/address.dart';
import 'package:taxi_booking/models/place_prediction.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_booking/screens/Assitants/request_assitance.dart';


import '../constants.dart';
import 'BookForm1.dart';
import 'DataHandler/appData.dart';
import 'package:easy_localization/easy_localization.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpTextEditingController=new TextEditingController();
  TextEditingController dropOffTextEditingController=new TextEditingController();
   late Address address;
   late AppData appdata;
   List<PlacePrediction> placePredictionList = [];
  List<PlacePrediction> placePickUpPredictionList = [];
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  @override
  Widget build(BuildContext context) {
    String? placeAddress= Provider.of<AppData>(context).pickUpLocation != null ? Provider.of<AppData>(context).pickUpLocation!.placeFormattedAddress!=null?Provider.of<AppData>(context).pickUpLocation!.placeFormattedAddress:Provider.of<AppData>(context).pickUpLocation!.placeName : "";
   //pickUpTextEditingController.text=placeAddress;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.enter_destination.tr(),
          style: TextStyle(color: Colors.white,fontSize: getProportionateScreenWidth(16),),
        ),

        centerTitle: true,
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body:SingleChildScrollView(
        child: Column(
        children: [
          Container(
            height: getProportionateScreenHeight(246),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 3.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7))
            ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 10),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    children: [
                      SizedBox(width: getProportionateScreenWidth(3)),
                      Expanded(

                        child: Container(

                          height:getProportionateScreenWidth(60),

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10),
                          ),
                          child: Row(
                            children: <Widget>[
                              // Icon(
                              //   Icons.add_location,
                              //   color: kPrimaryColor,
                              // ),
                              SizedBox(width: getProportionateScreenWidth(5)),
                              Expanded(
                                    child: TextField(
                                      controller: pickUpTextEditingController,
                                      onChanged: (value) {
                                        setState(() {
                                          findPickUpPlace(value);
                                        });
                                      },
                                      textAlignVertical: TextAlignVertical.center,
                                      style: TextStyle(fontSize: getProportionateScreenWidth(16),),
                                      // decoration: InputDecoration(
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                      //     ),
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                      //     ),
                                      //     hintText: "My current location, Addis Ababa",
                                      //     fillColor: Colors.transparent,
                                      //     filled: true,
                                      //     border: InputBorder.none,
                                      //     isDense: true,
                                      //     labelText:"From",
                                      //     contentPadding: EdgeInsets.only(
                                      //         left: 10.0, top: 20.0, bottom: 1.0)
                                      //
                                      // ),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),

                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          contentPadding: EdgeInsets.only(
                                              left: 10.0, top: 1.0, bottom: 1.0),
                                          labelText:"From",
                                          labelStyle: TextStyle(
                                              color: myFocusNode1.hasFocus ? kPrimaryColor : Colors.black
                                          ),
                                          hintText: "My current location, Addis Ababa",
                                        )

                                    ),
                                  ),

                              // Icon(
                              //   Icons.search,
                              //   color: kPrimaryColor,
                              // )
                            ],
                          ),
                        ),
                        )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    children: [
                      // Image.asset(
                      //   "assets/images/desticon.png",
                      //   height:getProportionateScreenHeight(30),
                      //   width:getProportionateScreenWidth(30),
                      // ),

                      Expanded(
                      //     child: Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white10,
                      //     borderRadius: BorderRadius.circular(5.0),
                      //   ),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(13.0),
                      //     child: TextField(
                      //       controller: dropOffTextEditingController,
                      //       style: TextStyle(fontSize: getProportionateScreenWidth(14),),
                      //       autofocus: true,
                      //       onChanged: (value) {
                      //         setState(() {
                      //           findPlace(value);
                      //         });
                      //       },
                      //       decoration: InputDecoration(
                      //           hintText: LocaleKeys.enter_destination_location.tr(),
                      //           fillColor: Colors.grey[200],
                      //           filled: true,
                      //           border: InputBorder.none,
                      //           isDense: true,
                      //           contentPadding: EdgeInsets.only(
                      //               left: 11.0, top: 20.0, bottom: 20.0)),
                      //     ),
                      //   ),
                      // )
                        child: Container(

                          height:getProportionateScreenWidth(60),

                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10),
                          ),
                          child: Row(
                            children: <Widget>[
                              // Icon(
                              //   Icons.add_location,
                              //   color: kPrimaryColor,
                              // ),
                              SizedBox(width: getProportionateScreenWidth(5)),
                              Expanded(
                                child: TextField(
                                  controller: dropOffTextEditingController,
                                    focusNode: myFocusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: TextStyle(fontSize: getProportionateScreenWidth(16),),
                                  autofocus: true,
                                  onChanged: (value) {
                                    setState(() {
                                      findPlace(value);
                                    });
                                  },
                                  // decoration: InputDecoration(
                                  //     // focusedBorder: OutlineInputBorder(
                                  //     //   borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                  //     // ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(color: Colors.transparent, width: 1.0),
                                  //     ),
                                  //     hintText: LocaleKeys.enter_destination_location.tr(),
                                  //     fillColor: Colors.transparent,
                                  //     filled: true,
                                  //     border: InputBorder.none,
                                  //     isDense: true,
                                  //     labelText:"Where to",
                                  //     contentPadding: EdgeInsets.only(
                                  //         left: 10.0, top: 20.0, bottom: 1.0)
                                  // ),
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.grey),
                                      ),
                                          contentPadding: EdgeInsets.only(
                                              left: 10.0, top: 1.0, bottom: 1.0),
                                      labelText:"Where to",
                                      labelStyle: TextStyle(
                                          color: myFocusNode.hasFocus ? kPrimaryColor : Colors.black
                                      ),
                                    )

                                ),
                              ),

                              // Icon(
                              //   Icons.search,
                              //   color: kPrimaryColor,
                              // )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        //  dispaly prediction
          (placePredictionList.length > 0)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListView.separated(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0.0),
                      itemBuilder: (context, index) {
                        return PredictionTile(
                          placePrediction: placePredictionList[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: placePredictionList.length),
                )

              : Container(),
          (placePickUpPredictionList.length > 0)
              ? Padding(
            padding:
            EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListView.separated(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, index) {
                  return PredictionPickTile(
                    placePrediction: placePickUpPredictionList[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemCount: placePickUpPredictionList.length
            ),
          )
              : Container(),

        SizedBox(
          width: SizeConfig.screenWidth,
          height: getProportionateScreenHeight(50),
          child: Card(
            elevation: getProportionateScreenHeight(10),
           // padding: const EdgeInsets.all(4.0),
          margin:const EdgeInsets.only(
              top: 0.0,
                  left:3.0,
            right:5.0,
            bottom: 10.0,
              ) ,
          child: Text(
            LocaleKeys.recent_locations.tr(),
            style: TextStyle(
             // fontFamily: 'Arial',
              fontSize: getProportionateScreenWidth(14),
              color: Colors.white,
              height: getProportionateScreenHeight(1.5),


            ),
            textAlign: TextAlign.left,
          ),
            color: Colors.grey[400],
          ),

        ),
          // Center(
          //
          //   child: Card(child: Text('     Recent Location',style: TextStyle( fontSize: 20,fontWeight: FontWeight.bold),
          //        ),
          //   color: Colors.grey,),
          // ),
        ],
      ),
    ));
  }

  void findPlace(String placeName) async {
    try {
      if (placeName.length > 1) {
        String autoComplete =
            "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ET";

        var res = await RequestAssitant.getRequest(autoComplete);

        if (res == "failed") {
          return;
        }

        if (res["status"] == "OK") {
          var predictions = res["predictions"];
          var placeList = (predictions as List)
              .map((e) => PlacePrediction.fromJson(e))
              .toList();
          setState(() {
            placePredictionList = placeList;
          });
        }
      }
    }
    catch(ex)
    {
      Navigator.of(context).pop();
    }
  }
  void findPickUpPlace(String placeName) async {
    try {
      if (placeName.length > 1) {
        String autoComplete =
            "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:ET";

        var res = await RequestAssitant.getRequest(autoComplete);

        if (res == "failed") {
          return;
        }

        if (res["status"] == "OK") {
          var predictions = res["predictions"];
          var placeList = (predictions as List)
              .map((e) => PlacePrediction.fromJson(e))
              .toList();
          setState(() {
            placePickUpPredictionList = placeList;

          });
        }
      }
    }
    catch(ex)
    {
      Navigator.of(context).pop();
    }
  }

}

void getPlaceAdressDetails(String PlaceId, context) async {
  try {
      ProgressDialog(message: "Loading...");
    // showDialog(context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) =>
    //         ProgressDialog(message: "Loading..."));

    String placeAddressUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$PlaceId&key=$mapKey";

    var res = await RequestAssitant.getRequest(placeAddressUrl);

    Navigator.of(context).pop();
    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placedId = PlaceId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];
      Provider.of<AppData>(context, listen: false).updateDropOffLocationAddress(
          address);
      print("This is Drop off Location ::");
      print(address.placeName);

      // Navigator.pop(context, "obtainDirection");

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              BookForm1(
                  title: "Drop Date",
                  descriptions: "Drop Time",
                  text: "Yes",
                  fromdate: "Pickup Date",
                  todate: "Pick up Time",
                  vehicle_id: "1",
                  customer_id: "1",
                  rate: "180",)));
    }
  }
  catch(ex)
   {
     Navigator.of(context).pop();
   }
}
void getPlacePickAddressDetails(String PlaceId, context) async {
  try
  {
    // showDialog(context: context,
    //     builder: (BuildContext context) =>
    //         ProgressDialog(message: "Loading .... Form"));
    String placeAddressUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$PlaceId&key=$mapKey";

    var res = await RequestAssitant.getRequest(placeAddressUrl);

    Navigator.of(context).pop();
    if (res == "failed") {
      return;
    }

    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placedId = PlaceId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];
      Provider.of<AppData>(context, listen: false).upadatePickUpLocationAddress(
          address);
      print("This is Drop off Location ::");
      print(address.placeName);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              SearchScreen()));

    }
  }
  catch(ex)
  {
    Navigator.of(context).pop();
  }
}
class PredictionTile extends StatelessWidget {
  final PlacePrediction placePrediction;
  PredictionTile({ required this.placePrediction, }) ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        ProgressDialog(message: "Loading...");
        getPlaceAdressDetails(placePrediction.place_id, context);

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: getProportionateScreenWidth(14),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePrediction.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                      ),
                      SizedBox(
                        height:getProportionateScreenHeight(3),
                      ),
                      Text(
                        placePrediction.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: getProportionateScreenWidth(10), color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
            // SizedBox(
            //   width: getProportionateScreenWidth(10),
            // ),
          ],
        ),
      ),
    );
  }
}
class PredictionPickTile extends StatelessWidget {

  final PlacePrediction placePrediction;
  PredictionPickTile({ required this.placePrediction, }) ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        getPlacePickAddressDetails(placePrediction.place_id, context);

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              width: getProportionateScreenWidth(10),
            ),
            Row(
              children: [
                Icon(Icons.add_location),
                SizedBox(
                  width: getProportionateScreenWidth(14),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        placePrediction.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: getProportionateScreenWidth(16)),
                      ),
                      SizedBox(
                        height:getProportionateScreenHeight(3),
                      ),
                      Text(
                        placePrediction.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: getProportionateScreenWidth(14), color: Colors.grey),
                      )
                    ],
                  ),
                )
              ],
            ),
            // SizedBox(
            //   width: getProportionateScreenWidth(10),
            // ),
          ],
        ),
      ),
    );
  }
}


