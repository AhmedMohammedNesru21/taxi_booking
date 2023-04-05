import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class WhiteButton extends StatelessWidget {
  const WhiteButton({
    required this.text,
    required this.press,
  }) ;
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(50),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor:  Colors.black87,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.white)
            ),
            //onSurface: Colors.grey, // Disable color
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              color:Colors.white ,
            ),
          ),
        )
    );
    // return Container(
    //   margin: EdgeInsets.all(10),
    //   padding: EdgeInsets.all(10),
    //   height: getProportionateScreenHeight(45),
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //
    //       border: Border.all(
    //           color: kPrimaryColor, // Set border color
    //           width: 1.0), // Set border width
    //       borderRadius: BorderRadius.all(
    //           Radius.circular(10.0)), // Set rounded corner radius
    //       boxShadow: [
    //         BoxShadow(blurRadius: 10, color: kPrimaryColor, offset: Offset(1, 2))
    //       ] // Make rounded corner of border
    //   ),
    //   child: FlatButton(
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    //
    //     color: Colors.white,
    //     onPressed: press,
    //     child: Text(
    //       text,
    //       style: TextStyle(
    //         fontSize: getProportionateScreenWidth(12),
    //         color: kPrimaryColor,
    //       ),
    //     ),
    //   ),
    // );
  }
}

