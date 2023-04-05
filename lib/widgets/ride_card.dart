
import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/models/rentalhistorydata.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/widgets/carHistory_widget.dart';

import '../size_config.dart';


class RideCard extends StatefulWidget {
  final RentalHistoryData car;

  const RideCard({required this.car}) ;

  @override
  _RideCardState createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child: Card(
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    Icons.pin_drop,
                    color: kPrimaryColor,
                  ),
                  // SizedBox(
                  //   width: 5.0,
                  // ),
                  Text(
                    widget.car.condition,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(10)

                    ),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 20.0),
                height: 170.0,
                child: buildCarOnly(widget.car, 0),
              ),
              ListTile(
                contentPadding: EdgeInsets.only(
                  left: 0.0,
                ),
                title: Text(
                  widget.car.brand.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
subtitle:Text(

  "PIck-up "+widget.car.check_in_date+ " - Drop-off "+widget.car.check_out_date,
  // widget.car.condition,
  style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: getProportionateScreenWidth(10),
  ),
),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Price",
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(10)
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "\ br "+widget.car.price.toString(),
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(10),
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
