import 'package:flutter/material.dart';



//Color kPrimaryColor = Color(0xFF7033FF);
Color kPrimaryColor = Color(0xff86b03e);

Color kPrimaryColorShadow = Color(0xFFF1EBFF);

class Constants{
  Constants._();
  static const double padding =20;
  static const double avatarRadius =45;
}

class Choice {
  const Choice({required this.title, required this.icon,required this.route});

  final String title;
  final IconData icon;
  final String route;
}
const PrimaryColor = Color(0xFFFF7643);
// final List _drawerMenu = [
// {
// "icon": Icons.restore,
// "text": "My rents",
// "route": MyRidesRoute,
// },
// {
// "icon": Icons.local_activity,
// "text": "Promotions",
// "route": PromotionRoute
// },
// {
// "icon": Icons.star_border,
// "text": "My favourites",
// "route": FavoritesRoute
// },
// {
// "icon": Icons.credit_card,
// "text": "My payments",
// "route": PaymentRoute,
// },
// {
// "icon": Icons.notifications,
// "text": "Notification",
// },
// {
// "icon": Icons.chat,
// "text": "Support",
// "route": ChatRiderRoute,
// }
const List<Choice> choices = const <Choice>[
  // const Choice(title: 'My rents', icon: Icons.restore,route: MyRidesRoute,),
  // const Choice(title: 'Promotions', icon: Icons.local_activity,route: MyRidesRoute,),
  // const Choice(title: 'My favourites', icon: Icons.star_border,route: FavoritesRoute,),
  // const Choice(title: 'My payments', icon: Icons.credit_card,route: PaymentRoute,),
  // const Choice(title: 'Notification', icon: Icons.notifications,route: MyRidesRoute,),
  // const Choice(title: 'Map', icon: Icons.notifications,route: MyRidesRoute,),
  // const Choice(title: 'Support', icon: Icons.chat,route: ChatRiderRoute,),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({required Key key, required this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyText1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 128.0, color: textStyle?.color),
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}