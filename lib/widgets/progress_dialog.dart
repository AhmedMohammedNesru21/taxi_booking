
import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {

  String message;
  ProgressDialog({@required required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0)
        ),
        child: Padding(
          padding:  EdgeInsets.all(15.0),
          child: Row(
            children: [
              SizedBox(width: 4.0,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),
              SizedBox(width: 10.0,),
              Text(message,style: TextStyle(color: kPrimaryColor,fontSize: getProportionateScreenWidth(12)),)
            ],
          ),
        )
      ),
    );
  }
}
