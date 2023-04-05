import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '/constants.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:taxi_booking/screens/Assitants/assitantMethods.dart';
import 'package:flutter_map_tappable_polyline/flutter_map_tappable_polyline.dart';
class NearByMap extends StatefulWidget {
  @override
  _NearByMapState createState() => _NearByMapState();
}

class _NearByMapState extends State<NearByMap> {
  LatLng? myLocation;
  @override
  void initState() {
    super.initState();
    getMyLocation();
     //_getNearbyLocation();
  }

  requestCab( LatLng? pickUpLocation, LatLng? dropLocation) {

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

    var latFakeNearby =  pickUpLocation!.latitude + randomDeltaForLat;
    var lngFakeNearby = pickUpLocation!.longitude + randomDeltaForLng;

    var bookedCabCurrentLocation = LatLng(latFakeNearby, lngFakeNearby);

    this.setState(() {
      _markers.add(
        Marker(
          width: 60.0,
          height: 60.0,
          point: bookedCabCurrentLocation,
            builder: (ctx) => Container(
              child: Image.asset(
                "assets/images/car2.png",
                width: 30.0,
                height: 30.0,
              ),
            ),
        ),
      );
    });
  }

  Future<void> getMyLocation() async {
    var rn = new Random();
    int num= 1 + rn.nextInt(6 - 1);

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high);
    Geolocator.getCurrentPosition(
        desiredAccuracy: geolocator.LocationAccuracy.high);
    myLocation = LatLng(position.latitude, position.longitude);

    // for (int i=0;i<num;i++)
    // {
    //   requestCab(myLocation,myLocation);
    // }
    String address =
    await AssistantMethods().searchCordinateAddress(position, context);
    print("this is your address" + address);
    //placeAddress=
    this.setState(() {
      _markers.add(
        Marker(
          width: 60.0,
          height: 60.0,
          point: myLocation!,
          builder: (ctx) => Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 30.0,
                  child: Icon(
                    Icons.person_pin_circle,
                    color: kPrimaryColor,
                  ),
                ),
                Container(
                  child: Text("Pick"),
                )
              ],
            ),
          ),
        ),
      );
    });
    print(position);
  }
  // List<Marker> _markers;
  List<Marker> _markers = [
    Marker(
      width: 30.0,
      height: 30.0,
      point: LatLng(9.00946, 38.78090),
      builder: (ctx) => Container(
        child: Image.asset(
          "assets/images/car2.png",
          width: 60.0,
          height: 60.0,
        ),
      ),
    ),
    Marker(
      width: 30.0,
      height: 30.0,
      point: LatLng(9.01158, 38.78163),
      builder: (ctx) => Container(
        child: Image.asset(
          "assets/images/car2.png",
          width: 30.0,
          height: 30.0,
        ),
      ),
    ),
    Marker(
      width: 30.0,
      height: 30.0,
      point: LatLng(9.01220, 38.77784),
      builder: (ctx) => Container(
        child: Image.asset(
          "assets/images/car2.png",
          width: 30.0,
          height: 30.0,
        ),
      ),
    )
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 230.0,
      child: FlutterMap(
        options: MapOptions(
          plugins: [
            TappablePolylineMapPlugin(),
          ],
          center: LatLng(45.1313258, 5.5171205),
          zoom: 11.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          TappablePolylineLayerOptions(
            // Will only render visible polylines, increasing performance
              polylineCulling: true,
              pointerDistanceTolerance: 20,
              polylines: [
                TaggedPolyline(
                  tag: 'My Polyline',
                  // An optional tag to distinguish polylines in callback
                  //points: getPoints(0),
                  color: Colors.red,
                  strokeWidth: 9.0, points: null,
                ),
                TaggedPolyline(
                  tag: 'My 2nd Polyline',
                  // An optional tag to distinguish polylines in callback
                  //points: getPoints(1),
                  color: Colors.black,
                  strokeWidth: 3.0, points: null,
                ),
                TaggedPolyline(
                  tag: 'My 3rd Polyline',
                  // An optional tag to distinguish polylines in callback
                 // points: getPoints(0),
                  color: Colors.blue,
                  strokeWidth: 3.0, points: null,
                ),
              ],
              onTap: (polylines, tapPosition) => print('Tapped: ' +
                  polylines.map((polyline) => polyline.tag).join(',') +
                  ' at ' +
                  tapPosition.globalPosition.toString()),
              onMiss: (tapPosition) {
                print('No polyline was tapped at position ' +
                    tapPosition.globalPosition.toString());
              })
        ],
      ),

    );
  }

}
// class MapUtils {
//   static LatLngBounds boundsFromLatLngList(List<LatLng> list) {
//     double x0, x1, y0, y1;
//     for (LatLng latLng in list) {
//       if (x0 == null) {
//         x0 = x1 = latLng.latitude;
//         y0 = y1 = latLng.longitude;
//       } else {
//         if (latLng.latitude > x1) x1 = latLng.latitude;
//         if (latLng.latitude < x0) x0 = latLng.latitude;
//         if (latLng.longitude > y1) y1 = latLng.longitude;
//         if (latLng.longitude < y0) y0 = latLng.longitude;
//       }
//     }
//     return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
//   }
// }
