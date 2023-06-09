import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        clipBehavior: Clip.none, fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Profile Image.png"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
    child: TextButton(
    style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
    side: BorderSide(color: Color(0xFFF5F6F9))
    )
    )
    ),
    onPressed: () {},
    child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
    ),

    // child: FlatButton(
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(50),
    //               side: BorderSide(color: Colors.white),
    //             ),
    //             color: Color(0xFFF5F6F9),
    //             onPressed: () {},
    //             child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
    //           ),

    // child:TextButton(
    // style: ButtonStyle(
    // shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    // RoundedRectangleBorder(
    // borderRadius: BorderRadius.circular(15.0),
    // side: BorderSide(color: Color(0xFFF5F6F9))
    // )
    // )
    // ),
            ),
          )
        ],
      ),
    );
  }
}
