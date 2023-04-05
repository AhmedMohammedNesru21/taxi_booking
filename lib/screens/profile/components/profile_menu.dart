import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    required this.text,
    required this.icon,
    required this.press,
  }) ;

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child:TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Color(0xFFF5F6F9))
                )
            )
        ),
    onPressed: press,
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  color: kPrimaryColor,
                  width: 22,
                ),
                SizedBox(width: 20),
                Expanded(child: Text(text)),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
    )
      // child: FlatButton(
      //   padding: EdgeInsets.all(20),
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      //   color: Color(0xFFF5F6F9),
      //   onPressed: press,
      //   child: Row(
      //     children: [
      //       SvgPicture.asset(
      //         icon,
      //         color: kPrimaryColor,
      //         width: 22,
      //       ),
      //       SizedBox(width: 20),
      //       Expanded(child: Text(text)),
      //       Icon(Icons.arrow_forward_ios),
      //     ],
      //   ),
      // ),
    );
  }
}