import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/models/rentalhistorydata.dart';
import 'package:taxi_booking/repository/db_service.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/widgets/ride_card.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import '../size_config.dart';
class MyRides extends StatefulWidget {
  static String routeName = "/myRides";
  @override
  _MyRidesState createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  var _dbService = DBService();
  late List<RentalHistoryData> completcars ;
  late List<RentalHistoryData> upcomingcars ;
  late List<RentalHistoryData> canclecars ;
  @override
  initState() {
    super.initState();
    _loadCompletCars();
    _loadUpComingCars();
    _loadCancleCars();

  }
  _loadCancleCars() async {
    try {
      var _carService = await _dbService.getCanceled();
      setState(() {
        canclecars = _carService;
      });

    }
    catch(e)
    {
      print(e);
    }
  }


  _loadUpComingCars() async {
    try {
      var _carService = await _dbService.getUpComing();
      setState(() {
        upcomingcars = _carService;
      });

    }
    catch(e)
    {
      print(e);
    }
  }

  _loadCompletCars() async {
    try {
      var _carService = await _dbService.getCompleted();
      setState(() {
        completcars = _carService;
      });

    }
    catch(e)
    {
      print(e);
    }
  }
  Widget? _myListView() {

    if (upcomingcars!=null && upcomingcars.length!=0) {

      if(upcomingcars.length>6)
      {
        return Column(
          children: <Widget>[
            RideCard(car: upcomingcars[0]),
            RideCard(car: upcomingcars[1]),
            RideCard(car: upcomingcars[2]),
            RideCard(car: upcomingcars[3]),
            RideCard(car: upcomingcars[4]),
            RideCard(car: upcomingcars[5]),
            RideCard(car: upcomingcars[6]),
          ],
        );
      }
      else if(upcomingcars.length>5)
      {
        return Column(
          children: <Widget>[
            RideCard(car: upcomingcars[0]),
            RideCard(car: upcomingcars[1]),
            RideCard(car: upcomingcars[2]),
            RideCard(car: upcomingcars[3]),
            RideCard(car: upcomingcars[4]),
            RideCard(car: upcomingcars[5]),
          ],
        );

      }
      else if(upcomingcars.length>4)
      {
        return Column(
          children: <Widget>[
            RideCard(car: upcomingcars[0]),
            RideCard(car: upcomingcars[1]),
            RideCard(car: upcomingcars[2]),
            RideCard(car: upcomingcars[3]),
            RideCard(car: upcomingcars[4]),

          ],
        );

      }
      else if(upcomingcars.length>3)
      {
        return Column(
          children: <Widget>[
            RideCard(car: upcomingcars[0]),
            RideCard(car: upcomingcars[1]),
            RideCard(car: upcomingcars[2]),
            RideCard(car: upcomingcars[3]),

          ],
        );
      }
      else if(upcomingcars.length>2) {
        return Column(
          children: <Widget>[
            RideCard(car: upcomingcars[0]),
            RideCard(car: upcomingcars[1]),
            RideCard(car: upcomingcars[2]),

          ],
        );

      }
      else if(upcomingcars.length>1)
      {
        return Column(
          children: <Widget>[
            RideCard(car: upcomingcars[0]),
            RideCard(car: upcomingcars[1]),

          ],
        );
      }
      else
      {
        return Column(
          children: <Widget>[
            RideCard(car: upcomingcars[0]),

          ],
        );
      }

    }
  }
  Widget? _mycompletcarsListView() {

    if (completcars!=null && completcars.length!=0) {

      if(completcars.length>6)
      {
        return Column(
          children: <Widget>[
            RideCard(car: completcars[0]),
            RideCard(car: completcars[1]),
            RideCard(car: completcars[2]),
            RideCard(car: completcars[3]),
            RideCard(car: completcars[4]),
            RideCard(car: completcars[5]),
            RideCard(car: completcars[6]),
          ],
        );
      }
      else if(completcars.length>5)
      {
        return Column(
          children: <Widget>[
            RideCard(car: completcars[0]),
            RideCard(car: completcars[1]),
            RideCard(car: completcars[2]),
            RideCard(car: completcars[3]),
            RideCard(car: completcars[4]),
            RideCard(car: completcars[5]),
          ],
        );

      }
      else if(completcars.length>4)
      {
        return Column(
          children: <Widget>[
            RideCard(car: completcars[0]),
            RideCard(car: completcars[1]),
            RideCard(car: completcars[2]),
            RideCard(car: completcars[3]),
            RideCard(car: completcars[4]),

          ],
        );

      }
      else if(completcars.length>3)
      {
        return Column(
          children: <Widget>[
            RideCard(car: completcars[0]),
            RideCard(car: completcars[1]),
            RideCard(car: completcars[2]),
            RideCard(car: completcars[3]),

          ],
        );
      }
      else if(completcars.length>2) {
        return Column(
          children: <Widget>[
            RideCard(car: completcars[0]),
            RideCard(car: completcars[1]),
            RideCard(car: completcars[2]),

          ],
        );

      }
      else if(completcars.length>1)
      {
        return Column(
          children: <Widget>[
            RideCard(car: completcars[0]),
            RideCard(car: completcars[1]),

          ],
        );
      }
      else
      {
        return Column(
          children: <Widget>[
            RideCard(car: completcars[0]),

          ],
        );
      }

    }
  }
  Widget? _mycanclecarsListView() {

    if (canclecars!=null && canclecars.length!=0) {

      if(canclecars.length>6)
      {
        return Column(
          children: <Widget>[
            RideCard(car: canclecars[0]),
            RideCard(car: canclecars[1]),
            RideCard(car: canclecars[2]),
            RideCard(car: canclecars[3]),
            RideCard(car: canclecars[4]),
            RideCard(car: canclecars[5]),
            RideCard(car: canclecars[6]),
          ],
        );
      }
      else if(canclecars.length>5)
      {
        return Column(
          children: <Widget>[
            RideCard(car: canclecars[0]),
            RideCard(car: canclecars[1]),
            RideCard(car: canclecars[2]),
            RideCard(car: canclecars[3]),
            RideCard(car: canclecars[4]),
            RideCard(car: canclecars[5]),
          ],
        );

      }
      else if(canclecars.length>4)
      {
        return Column(
          children: <Widget>[
            RideCard(car: canclecars[0]),
            RideCard(car: canclecars[1]),
            RideCard(car: canclecars[2]),
            RideCard(car: canclecars[3]),
            RideCard(car: canclecars[4]),

          ],
        );

      }
      else if(canclecars.length>3)
      {
        return Column(
          children: <Widget>[
            RideCard(car: canclecars[0]),
            RideCard(car: canclecars[1]),
            RideCard(car: canclecars[2]),
            RideCard(car: canclecars[3]),

          ],
        );
      }
      else if(canclecars.length>2) {
        return Column(
          children: <Widget>[
            RideCard(car: canclecars[0]),
            RideCard(car: canclecars[1]),
            RideCard(car: canclecars[2]),

          ],
        );

      }
      else if(canclecars.length>1)
      {
        return Column(
          children: <Widget>[
            RideCard(car: canclecars[0]),
            RideCard(car: canclecars[1]),

          ],
        );
      }
      else
      {
        return Column(
          children: <Widget>[
            RideCard(car: canclecars[0]),

          ],
        );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              LocaleKeys.my_history.tr(),
              style: TextStyle(
                fontSize: getProportionateScreenWidth(12),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: kPrimaryColor,
                      labelStyle: TextStyle(
                        fontSize: getProportionateScreenWidth(10),
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: kPrimaryColor,
                      tabs: <Widget>[
                        Tab(
                          text: LocaleKeys.UPCOMING.tr(),
                        ),
                        Tab(
                          text: LocaleKeys.COMPLETED.tr(),
                        ),
                        Tab(
                          text: LocaleKeys.CANCELED.tr(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(

                      child: TabBarView(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: _myListView(),
                          ),
                          SingleChildScrollView(
                            child: _mycompletcarsListView(),
                          ),
                          SingleChildScrollView(
                            child: _mycanclecarsListView(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
