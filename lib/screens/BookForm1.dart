import 'dart:ui';

import 'package:taxi_booking/Core/Models/CarTypeMenu.dart';
import 'package:taxi_booking/components/form_error.dart';
import 'package:taxi_booking/screens/homeMapView/viewMap.dart';
import 'package:taxi_booking/models/extraRateTypes.dart';
import 'package:taxi_booking/repository/db_service.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/Core/Constants/DemoData.dart';

import 'package:taxi_booking/constants.dart';
import 'package:taxi_booking/models/extraRates.dart';

import '../size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class BookForm1 extends StatefulWidget {
  final String title, descriptions, text, fromdate, todate,vehicle_id,customer_id,rate;

  final Image? img;


  const BookForm1(
      {
        required this.title,
        required this.descriptions,
        required this.text,
        required this.fromdate,
        required this.todate,
        this.img,
        required this.vehicle_id,
        required this.customer_id,
        required this.rate})
      ;

  @override
  _BookFormState createState() => _BookFormState();

}

class _BookFormState extends State<BookForm1> {
  late String senderName;
  late String senderPhone;
  late String recipientName;
  late String recipientPhone;
  late String sideRoadMeter;
  bool checkRoadSide=false;
  List<ExtraRateTypes> _regionSecondDropDown = [];
  List<ExtraRates> _subCityDropDown = [];
  var _dbService = DBService();
  bool _selected = false;
  bool _selectedSub = false;
  String _selectedRegion = "";
  String _selectedSubCity = "";
  CarTypeMenu? carTypeMenu;

  final List<String> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }
  @override
  initState() {
    super.initState();
    _loadRegions();
  }
  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedEndTime= TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = new DateTime(DateTime.now().year, DateTime.now().month + 1, DateTime.now().day);
  var controller = new MaskedTextController(mask: '(000) 000 0000');
  TextEditingController distanceContoller=TextEditingController();
  TextEditingController weightContoller=TextEditingController();
  var controllerDropOff = new MaskedTextController(mask: '(000) 000 0000');

  _loadRegions() async {
    _regionSecondDropDown.clear();
    var _regionsService = await _dbService.getAllExtraRateTypes();
    _regionsService.forEach((cartype) {
      setState(() {
        _regionSecondDropDown.add(ExtraRateTypes(
          rateName: cartype['rateName'],
          Id: cartype['Id'].toString(),
        ));
      });
    });
  }
  _loadSubcity(String regionid) async {
    _subCityDropDown.clear();
    var _subcityService = await _dbService.getAllExtraRates(regionid);
    _subcityService.forEach((cartype) {
      setState(() {
        _subCityDropDown.add(ExtraRates(
          rateName: cartype['rateName'],
          Id: cartype['Id'].toString(),
        ));
      });
    });
  }


  bool isNotLessThanToday(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date).inDays;
    if (diff <= 0 || now.day == date.day)
    { return true ;}
    return false;
  }

  List<TextEditingController> _controllers = [];
  int? selectedIndex;

  Widget _myListView() {

    return ListView.builder(
      itemCount: DemoData.typesOfCar.length,
      itemBuilder: (context, index) {
        _controllers.add(new TextEditingController());

        return Card(
          margin: EdgeInsets.only(
              left: Constants.margin,
              top: 0,
              right: Constants.margin,
              bottom: Constants.margin
          ),
          elevation: 10,
          shape: RoundedRectangleBorder(
              side:  BorderSide(color: Colors.red[900]!,width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))
          ),
          shadowColor: Colors.black45,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               ListTile(
                 tileColor: selectedIndex == index ? Colors.lightBlue[100] : null,
                 onTap: () {
                   setState(() {
                     selectedIndex = index;
                   });
                 },

                 leading: ConstrainedBox(
                   constraints: BoxConstraints(
                     minWidth: getProportionateScreenWidth(44),
                     minHeight:getProportionateScreenHeight(44),
                     maxWidth: getProportionateScreenWidth(64),
                     maxHeight: getProportionateScreenWidth(64),
                   ),
                   child: Image.asset(DemoData.typesOfCar[index].image, fit: BoxFit.cover),
                 ),
                title: Text(
                  DemoData.typesOfCar[index].info,
                  style: TextStyle(fontSize: getProportionateScreenWidth(12)),
                ),
                subtitle: Text(DemoData.typesOfCar[index].price,
                  style: TextStyle(fontSize: getProportionateScreenWidth(10)),
                ),

              ),
            ],
          ),
        );
      },
    );
  }

  TextEditingController editingController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  late String _dropdownError;
  late String _selectedItem;

  _validateForm() {
    bool? _isValid = _formKey.currentState?.validate();

    if (_selectedRegion == null || _selectedRegion=="" ) {
      setState(() => _dropdownError = "Please select Rate Type!");
      addError(error: kRateNullError);
      _isValid = false;
    }
    else
      {
        removeError(error: kRateNullError);
      }
    if (selectedIndex==null)
      {
        addError(error: kCarNullError);
      }
    else
      {
        removeError(error: kCarNullError);
      }


  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      return false;
    },
    child: Scaffold(
        body:
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            Container(
              //padding: const EdgeInsets.all(30.0),
              padding: EdgeInsets.only(
                  left: Constants.padding,
                  top: Constants.padding,
                  right: Constants.padding,
                  bottom: Constants.padding),
              margin: EdgeInsets.only(top: Constants.avatarRadius),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.padding),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, offset: Offset(0, 1), blurRadius: 10),
                  ]),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(LocaleKeys.fill_booking_form.tr(), style: TextStyle(fontSize:getProportionateScreenWidth(20),fontWeight: FontWeight.bold,color: Colors.black87)),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      DropdownButtonFormField(
                        value: _selected ? _selectedRegion : null,
                        items: _regionSecondDropDown.map((ExtraRateTypes map) {
                          return new DropdownMenuItem(
                            value: map.Id.toString(), //must be  one of  actNo.
                            child: new Text(
                              map.rateName,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(fontSize: getProportionateScreenWidth(14)),
                            ),
                          );
                        }).toList(),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                          ),
                        ),
                        hint: Text(
                          LocaleKeys.please_select_rate_type.tr(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: getProportionateScreenWidth(14),

                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down_circle_sharp,
                          color: kPrimaryColor, // Add this
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRegion = newValue!;
                            _selectedSub=false;
                            _loadSubcity(_selectedRegion);
                            _selected = true;
                           // _dropdownError = null;
                          });
                        },


                      ),
            // _dropdownError == null
            //     ? SizedBox.shrink()
            //     : Text(
            //   _dropdownError ?? "",
            //   style: TextStyle(color: Colors.red),),
                      SizedBox(height: getProportionateScreenHeight(10)),
                  Visibility(
                    visible: _selectedRegion == null || _selectedRegion=="" || _selectedRegion=="5" ? false : true,
                    child:
                      DropdownButtonFormField(
                        value: _selectedSub?_selectedSubCity.toString() :null,
                        isDense: true,
                        items: _subCityDropDown.map((ExtraRates map) {
                          return new DropdownMenuItem(
                            value: map.Id.toString(), //must be  one of  actNo.
                            child: new Text(
                              map.rateName!,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(fontSize: getProportionateScreenWidth(12)),
                            ),

                          );
                        }).toList(),
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                            ),
                          ),
                        ),
                        hint: Text(
                          LocaleKeys.please_select_extra_rate.tr(),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: getProportionateScreenWidth(12),

                          ),
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down_circle_sharp,
                          color: kPrimaryColor, // Add this
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedSubCity = value!;
                            _selectedSub = true;

                          });
                        },
                      ),
                  ),

                      SizedBox(height: getProportionateScreenHeight(10)),
                      Visibility(
                        visible: _selectedSubCity == null || _selectedSubCity=="" || _selectedRegion!="1" ? false : true,
                        child:
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller:  distanceContoller ,
                          onSaved: (newValue) => senderPhone = newValue!,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              removeError(error: kNamelNullError);
                            }
                            return null;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              addError(error: kNamelNullError);
                              return "";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: LocaleKeys.distance.tr(),
                            hintText: LocaleKeys.enter_your_distance.tr(),
                            // If  you are using latest version of flutter then lable text and hint text shown like this
                            // if you r using flutter less then 1.20.* then maybe this is not working properly
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(10)),
                      TextFormField(
                        controller: weightContoller,
                        keyboardType: TextInputType.phone,
                        onSaved: (newValue) => recipientPhone = newValue!,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            removeError(error: kKglNullError);
                          }
                          return null;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            addError(error: kKglNullError);
                            return "";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          labelText: LocaleKeys.WEIGHT.tr()+" (KG)",
                          hintText:LocaleKeys.ENTER_WEIGHT.tr()+" (KG)",
                          // If  you are using latest version of flutter then lable text and hint text shown like this
                          // if you r using flutter less then 1.20.* then maybe this is not working properly
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
                        ),
                      ),


                      SizedBox(height: getProportionateScreenHeight(10)),
                      FormError(errors: errors),
                    ],)

              ),
            ),

            Container(
                height: getProportionateScreenHeight(450),
               padding: const EdgeInsets.all(2.0),
               margin: EdgeInsets.only(top: Constants.padding),

                child: Card(

                    child: Column(
                      children: <Widget>[
                        Text(LocaleKeys.select_truck_type.tr(), style: TextStyle(
                                       color: Colors.black87, fontSize: getProportionateScreenWidth(14),fontWeight: FontWeight.bold)),
                        //SizedBox(height: getProportionateScreenHeight(5)),
                        Expanded(
                          child: _myListView(),
                        )
                      ],
                    )
                    //)
                ),
            ),

          ]),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_forward),
            tooltip: 'Click to Add',
            foregroundColor: Colors.white,
            backgroundColor: Colors.red[900],
            hoverColor: Colors.white,
            elevation: 10,
            hoverElevation: 20,
            splashColor: Colors.blueGrey,
            highlightElevation: 20,
            mini: false,
            onPressed: () async {
                     _validateForm() ;
                     if(errors.length>=1)
                       {
                                     ScaffoldMessenger.of(context)
                                         .showSnackBar(
                                       SnackBar(
                                         content: Text(
                                             'Please enter value Properly'),
                                       ),
                                     );
                       }
                     else{
                       Navigator.of(context).pushReplacement(MaterialPageRoute(
                         builder: (BuildContext context) =>
                             MapPage(
                                 rateId: _selectedRegion,
                                 extraRateId: _selectedSubCity,
                                 distanceOffRoad: distanceContoller.text,
                                 carTypeMenu: carTypeMenu,
                                 weight: weightContoller.text,
                                 scheduledDate: "",
                                 scheduledTime: "",
                                 selectedIndex: selectedIndex
                             ),
                       ));
                     }

                       }

            ),
    ));
  }
}
