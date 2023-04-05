import 'package:flutter/material.dart';

import '../constants.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
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
            backgroundColor:  kPrimaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Colors.red)
            ),
            //onSurface: Colors.grey, // Disable color
          ),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              fontSize: getProportionateScreenWidth(14),
              color: Colors.white,
            ),
          ),
        )


    );
  }
}
