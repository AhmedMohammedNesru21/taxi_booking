import 'package:taxi_booking/models/debitcard.dart';
import 'package:flutter/material.dart';

import '../size_config.dart';


class CardContainer extends StatelessWidget {
  final DebitCard cardDetail;
  CardContainer({required this.cardDetail});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        leading: cardDetail.logo,
        title: Text(
          "**** **** **** ${cardDetail.lastDigits}",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(19),
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "Expires ${cardDetail.expiry}",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
