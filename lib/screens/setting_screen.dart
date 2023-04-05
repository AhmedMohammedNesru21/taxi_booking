
import 'package:taxi_booking/size_config.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/models/debitcard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class Setting_Screen extends StatefulWidget {
  static String routeName = "/setting_screen";
  final String toolbarname;

  Setting_Screen({ required this.toolbarname}) ;

  @override
  State<StatefulWidget> createState() => Settings();
}

class Settings extends State<Setting_Screen> {

 bool _switchValue = true;
  final _accountType = ['English', 'Amharic'];
  final _themeType = ['primaryColor',
  'Brightness'];
  @override
  initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
  //  switchValue=_switchValue;
    final ThemeData _theme = Theme.of(context);
        IconData? _backIcon() {
      switch (Theme.of(context).platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          return Icons.arrow_back;
        case TargetPlatform.iOS:
          return Icons.arrow_back_ios;
      }
      assert(false);
      return null;
    }
    final List<DebitCard> _cards = [
      DebitCard(
        expiry: "09/25",
        lastDigits: "5697",
        logo: Image.asset(
          "assets/images/mastercard.png",
        ),
      ),
      DebitCard(
        expiry: "10/27",
        lastDigits: "3802",
        logo: Image.asset("assets/images/visa.png"),
      ),
    ];
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
        title: Text(LocaleKeys.setting.tr(),style:TextStyle(fontSize: getProportionateScreenWidth(14))),
        backgroundColor: Colors.white,
      ),
      // drawer: AppDrawer(),

        body: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
          height: getProportionateScreenHeight(40.0),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: Row(
                  children: <Widget>[
                    //_verticalD(),
                    GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => signup_screen()));*/
                      },
                      child: Text(
                          LocaleKeys.notification.tr(),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.notifications, color: Colors.black54),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                              ),
                              Text(
                                LocaleKeys.notification.tr(),
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          CupertinoSwitch(
                            value: _switchValue,
                            onChanged: (value) {
                              setState(() {
                                _switchValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 15.0),
              ),
              Container(
                height: getProportionateScreenHeight(40.0),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: Row(
                  children: <Widget>[
                    //_verticalD(),
                    GestureDetector(
                      onTap: () {

                      },
                      child: Text(
                        LocaleKeys.get_in_touch.tr(),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    child: Container(

                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Icon(Icons.phone, color: Colors.black54),
                                    Container(
                                      margin: EdgeInsets.only(left: 5.0),
                                    ),
                                    SizedBox(width:getProportionateScreenWidth(50)),
                                    Text(
                                        LocaleKeys.call_us_on.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: getProportionateScreenWidth(14),
                                        color: Colors.black87,
                                      ),

                                    ),
                                // FlatButton(
                                //     onPressed: () => launch("tel://0911211258"),
                                //     child: new Text("")),

                                  ],
                                ),
                                onTap: () {
                                  launch("tel://0911211258");
                                },
                              )),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.email,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                      ),
                                      SizedBox(width:getProportionateScreenWidth(50)),
                                      Text(
                                        LocaleKeys.email_us.tr(),
                                        style: TextStyle(
                                          fontSize: getProportionateScreenWidth(14),
                                          color: Colors.black87,
                                        ),
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                    launch('mailto:info@Kaylogistic.com');
                                  })),
                          Divider(
                            height: 5.0,
                          ),
                          Container(
                              padding: EdgeInsets.only(
                                  left: 10.0, top: 15.0, bottom: 15.0),
                              child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.info,
                                          color: Colors.black54),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                      ),
                                      SizedBox(width:getProportionateScreenWidth(50)),
                                      Text(
                                       LocaleKeys.get_legal_information.tr(),
                                        style: TextStyle(
                                          fontSize: getProportionateScreenWidth(14),
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                   await launch('https://kayologistics.com/');
                                  })),
                        ],
                      ),
                    )),
              ),
              Container(
                height: getProportionateScreenHeight(40.0),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(top: 7.0),
                child: Row(
                  children: <Widget>[
                    //_verticalD(),
                    GestureDetector(
                      onTap: () {
                        /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => signup_screen()));*/
                      },
                      child: Text(
                          LocaleKeys.Language.tr(),
                        style: TextStyle(
                            fontSize: getProportionateScreenWidth(14),
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Card(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.language, color: Colors.black54),
                              Container(
                                margin: EdgeInsets.only(left: 5.0),
                              ),
                              Text(
                                LocaleKeys.Language.tr(),
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(14),
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                    // languageValue="English";
                    // String themeType
                  DropdownButton(
                    items: _accountType
                        .map((value) => DropdownMenuItem(
                      child: Text(value),
                      value: value,
                    ))
                        .toList(),
                    onChanged: (selectedLanguage) {
                      setState(() async {
                        // selectedType = selectedAccountType;
                        SystemConfig.setStringToSF("languageValue",selectedLanguage!);
                        if(selectedLanguage=='Amharic') {
                          await context.setLocale(Locale('am'));
                        }
                        else if(selectedLanguage=='English')
                          {
                            await context.setLocale(Locale('en'));
                          }
                      });
                    },
                    // value: selectedType,
                    isExpanded: false,
                    hint: Text(LocaleKeys.choose_language.tr(),style: TextStyle(
                      fontSize: getProportionateScreenWidth(14),
                      color: Colors.black87,
                    ),),
                  ),
                ],
                      ),
                    )),
              ),
            ],
          ),
        )
    );
  }
}


