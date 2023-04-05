import 'package:taxi_booking/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

import 'HomeMScreen.dart';
import 'components/body.dart';
import 'package:taxi_booking/screens/DataHandler/appData.dart';

import 'home_Map_Screen.dart';
class HomeMapScreen extends StatelessWidget {
  static String routeName = "/homeMap_in";
  AppData appData = AppData();
 // bool drawerOpen = true;
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child:Scaffold(

       drawer: AppDrawer(),

      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.only(top: 80),
      //         child: Container(
      //           height: 100,
      //           width: 100,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               border: Border.all(color: Colors.green),
      //               image: DecorationImage(
      //                   image: AssetImage("assets/images/avatar.jpg"))
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         height: 5,
      //       ),
      //       ////////////
      //       SizedBox(height: 30,),
      //       Divider(color: Colors.grey.withOpacity(0.4),),
      //       Padding(
      //         padding: const EdgeInsets.only(top: 20, left: 40),
      //         child: Column(
      //           children: [
      //             Row(
      //               children: [
      //                 Icon(Icons.history),
      //                 SizedBox(width: 15,),
      //                 Text("History", style: TextStyle(
      //                     fontSize: 13, color: Colors.black
      //                 ),)
      //               ],
      //             ),
      //             SizedBox(height: 15,),
      //             Row(
      //               children: [
      //                 Icon(Icons.person),
      //                 SizedBox(width: 15,),
      //                 Text("Vist Profile", style: TextStyle(
      //                     fontSize: 13, color: Colors.black
      //                 ),)
      //               ],
      //             ),
      //             SizedBox(height: 15,),
      //             Row(
      //               children: [
      //                 Icon(Icons.info),
      //                 SizedBox(width: 15,),
      //                 Text("About", style: TextStyle(
      //                     fontSize: 13, color: Colors.black
      //                 ),)
      //               ],
      //             ),
      //             SizedBox(height: 15,),
      //             GestureDetector(
      //               onTap: ()
      //               {
      //                 // FirebaseAuth.instance.signOut();
      //                 // Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
      //               },
      //               child: Row(
      //                 children: [
      //                   Icon(Icons.info),
      //                   SizedBox(width: 15,),
      //                   Text("Sign Out", style: TextStyle(
      //                       fontSize: 13, color: Colors.black
      //                   ),)
      //                 ],
      //               ),
      //             )
      //
      //
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),

      body: HomeMScreen(),
    ),);
  }
}