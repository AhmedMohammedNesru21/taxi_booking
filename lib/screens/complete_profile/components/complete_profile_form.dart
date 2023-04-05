import 'package:taxi_booking/dto/SetRegisterPassangerDto.dart';
import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'package:taxi_booking/services/apimanagerdio.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/components/custom_surfix_icon.dart';
import 'package:taxi_booking/components/default_button.dart';
import 'package:taxi_booking/components/form_error.dart';
import 'package:taxi_booking/models/Accounts.dart';
import 'package:taxi_booking/models/Region.dart';
import 'package:taxi_booking/models/Subcity.dart';
import 'package:taxi_booking/models/Wereda.dart';
import 'package:taxi_booking/repository/db_service.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../constants.dart';
import '../../../globals.dart';
import '../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var _dbService = DBService();
  late List<Accounts> _usersList;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String address;
  late String middleName;
  late String emergencyPhoneNumber;
  late String houseNo;
  String _selectedRegion = "Addis Ababa";
  String _selectedSubCity = "Addis Ketema";
  String _selectedWereda="";
  List<Region> _regionSecondDropDown = [];
  List<SubCity> _subCityDropDown = [];
  List<Wereda> _weredaDropDown = [];
  bool _selected = false;
  bool _selectedSub = false;
  bool _selectedW=false;
  late String email;
  late String password;
  late String conform_password;
  bool remember = false;
  var controller = new MaskedTextController(mask: '(000) 000 0000');
  var controllerEmergency = new MaskedTextController(mask: '(000) 000 0000');

  late SetRegisterPassengerDto _setPassengerDto;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();

  @override
  initState() {
    super.initState();
    _loadRegions();
    // getAllUsers();
  }
  getAllUsers() async
  {
    try {
      var users = await _dbService. getActiveAccounts();
      setState(() {
        _usersList=users;
      });

    }
    catch(e)
    {
      print(e);
    }
  }
  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }
  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }
  _loadRegions() async {
    _regionSecondDropDown.clear();
    var _regionsService = await _dbService.getAllRegions();
    _regionsService.forEach((cartype) {
      setState(() {
        _regionSecondDropDown.add(Region(
          Region_Name: cartype['Region_Name'],
          id: cartype['Id'], regionUpdated: '',
        ));
      });
    });
  }
  _loadSubcity(String regionid) async {
    _subCityDropDown.clear();
    var _subcityService = await _dbService.getActiveSubcity(regionid);
    _subcityService.forEach((cartype) {
      setState(() {
        _subCityDropDown.add(SubCity(
          Town_Name: cartype['Town_Name'],
          id: cartype['Id'], subcityUpdated: '',
        ));
      });
    });
  }
  _loadWereda(String subcityid) async {
    _weredaDropDown.clear();
    var _weredaService = await _dbService.getActiveWereda(subcityid);
    _weredaService.forEach((cartype) {
      setState(() {
        _weredaDropDown.add(Wereda(
          Wereda_Name: cartype['Wereda_Name'],
          id: cartype['Id'], weredaUpdated: '',
        ));
      });
    });
  }

  Future<SetRegisterPassengerDto?> _setAccounts() async {
    try {
      SetRegisterPassengerDto configData =
      SetRegisterPassengerDto(
          userName :  (await SystemConfig.getStringValuesSF("userName"))!,
          password: (await SystemConfig.getStringValuesSF("passWord"))!,
          isSuccess : "1",
          lastModified:DateTime.now().toString(),
          FullName: _firstNameController.text+' '+_middleNameController.text+' '+ _lastNameController.text ,
          Phone:(await SystemConfig.getStringValuesSF("userName"))!,
          Email:_emailController.text,
          RoleID:"1",
          StatusId:"1",
          otp:"0",
          AccountMiles:"0",
          NotificationStatusId:"0", AId: '', ReferalCode: '', PassengerId: '',
      );

      _setPassengerDto = await APIManagerDio().updateRegisterPassengerDto(configData);
      bool isconfigData = await SystemConfig.setPassengerId(_setPassengerDto);
      glUserName=_setPassengerDto.FullName.toString();
      glPhoneNumber=_setPassengerDto.userName;
      glEmail=_setPassengerDto.Email;
      if (isconfigData = true) {

        if (_setPassengerDto.PassengerId.isNotEmpty) {
          SetRegisterPassengerDto acc = new SetRegisterPassengerDto(
            userName: _setPassengerDto.userName,
            password: _setPassengerDto.password,
            isSuccess: _setPassengerDto.isSuccess,
            lastModified: _setPassengerDto.lastModified,
            AId: _setPassengerDto.PassengerId,
            FullName: _setPassengerDto.FullName,
            Phone: _setPassengerDto.Phone,
            Email: _setPassengerDto.Email,
            RoleID: _setPassengerDto.RoleID,
            StatusId: _setPassengerDto.StatusId,
            otp: _setPassengerDto.otp,
            AccountMiles: _setPassengerDto.AccountMiles,
            NotificationStatusId: _setPassengerDto.NotificationStatusId, ReferalCode: '', PassengerId: '',

          );

          // await _dbService.insertRegisterPassenger(acc);
        }
        Fluttertoast.showToast(
            msg: LocaleKeys.successful_saved.tr(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);
      }
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    var splitag = glUserName.split(" ");
    var splitag1 ;
    var splitag2 ;
    var splitag3 ;
    if(splitag.length==1)
    {
      splitag1 = splitag[0];
      _firstNameController.text = splitag1.toString();

    }
    else if (splitag.length==2)
    {
      splitag1 = splitag[0];splitag2 = splitag[1];
      _firstNameController.text = splitag1.toString();
      _middleNameController.text =splitag2.toString();
    }
    else if (splitag.length==3){
      splitag1 = splitag[0];splitag2 = splitag[1];splitag3 = splitag[2];
      _firstNameController.text = splitag1.toString();
      _middleNameController.text =splitag2.toString();
      _lastNameController.text = splitag3.toString();
    }
     _emailController.text=glEmail;

    return Form(
      key: _formKey,
      child: Column(
        children: [


          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildMiddleNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // buildEmergencyPhoneNumberFormField(),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          // DropdownButtonFormField(
          //   value: _selected ? _selectedRegion : null,
          //   items: _regionSecondDropDown.map((Region map) {
          //     return new DropdownMenuItem(
          //       value: map.id.toString(), //must be  one of  actNo.
          //       child: new Text(
          //         map.Region_Name,
          //         overflow: TextOverflow.ellipsis,
          //         softWrap: true,
          //       ),
          //     );
          //   }).toList(),
          //   style: TextStyle(color: Colors.black),
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: const BorderRadius.all(
          //         const Radius.circular(30.0),
          //       ),
          //     ),
          //   ),
          //   hint: Text(
          //     "Please select Region ",
          //     style: TextStyle(
          //       color: Colors.grey[600],
          //       fontSize: 16,
          //
          //     ),
          //   ),
          //   icon: Icon(
          //     Icons.arrow_drop_down_circle_sharp,
          //     color: kPrimaryColor, // Add this
          //   ),
          //   onChanged: (String newValue) {
          //     setState(() {
          //       _selectedRegion = newValue;
          //       _selectedSub=false;
          //       _loadSubcity(_selectedRegion);
          //       _selected = true;
          //     });
          //   },
          // ),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // DropdownButtonFormField(
          //   value: _selectedSub?_selectedSubCity.toString() :null,
          //   isDense: true,
          //   items: _subCityDropDown.map((SubCity map) {
          //     return new DropdownMenuItem(
          //       value: map.id.toString(), //must be  one of  actNo.
          //       child: new Text(
          //         map.Town_Name,
          //         overflow: TextOverflow.ellipsis,
          //         softWrap: true,
          //       ),
          //
          //     );
          //   }).toList(),
          //   style: TextStyle(color: Colors.black),
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: const BorderRadius.all(
          //         const Radius.circular(30.0),
          //       ),
          //     ),
          //   ),
          //   hint: Text(
          //     "Please select Subcity",
          //     style: TextStyle(
          //       color: Colors.grey[600],
          //       fontSize: 16,
          //
          //     ),
          //   ),
          //   icon: Icon(
          //     Icons.arrow_drop_down_circle_sharp,
          //     color: kPrimaryColor, // Add this
          //   ),
          //   onChanged: (value) {
          //     setState(() {
          //       _selectedSubCity = value;
          //       _selectedSub = true;
          //       _loadWereda(_selectedSubCity);
          //     });
          //   },
          // ),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // DropdownButtonFormField(
          //   value: _selectedW?_selectedWereda.toString() :null,
          //   isDense: true,
          //   items: _weredaDropDown.map((Wereda map) {
          //     return new DropdownMenuItem(
          //       value: map.id.toString(), //must be  one of  actNo.
          //       child: new Text(
          //         map.Wereda_Name,
          //         overflow: TextOverflow.ellipsis,
          //         softWrap: true,
          //       ),
          //
          //     );
          //   }).toList(),
          //   style: TextStyle(color: Colors.black),
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: const BorderRadius.all(
          //         const Radius.circular(30.0),
          //       ),
          //     ),
          //   ),
          //   hint: Text(
          //     "Please select Wereda",
          //     style: TextStyle(
          //       color: Colors.grey[600],
          //       fontSize: 16,
          //
          //     ),
          //   ),
          //   icon: Icon(
          //     Icons.arrow_drop_down_circle_sharp,
          //     color: kPrimaryColor, // Add this
          //   ),
          //   onChanged: (value) {
          //     setState(() {
          //       _selectedWereda = value;
          //       _selectedW = true;
          //     });
          //   },
          // ),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // buildHouseNoFormField(),
          // DropdownButton<String>(
          //   dropdownColor: Colors.green,
          //   isExpanded: true,
          //   items: _cities.map((String dropDownStringItem) {
          //     return DropdownMenuItem<String>(
          //       value: dropDownStringItem,
          //       child: Text(dropDownStringItem, style: widget.style),
          //     );
          //   }).toList(),
          //   onChanged: (value) => _onSelectedCity(value!),
          //   value: _selectedCity,
          // ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),

          DefaultButton(
            text: LocaleKeys.submit.tr(),
            press: () async {
              // if (_formKey.currentState?.validate()) {
                await _setAccounts();
                Navigator.pushNamed(context, HomeMapScreen.routeName);
              // }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => address = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your phone address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,maxLength: 14,
      onSaved: (newValue) => phoneNumber = newValue!,
      controller: controller,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildEmergencyPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: controllerEmergency,
      onSaved: (newValue) => emergencyPhoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Emergency Phone Number",
        hintText: "Enter your emergency phone number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildMiddleNameFormField() {
    return TextFormField(
      controller: _middleNameController,
      onSaved: (newValue) => middleName = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      decoration: InputDecoration(
        labelText: LocaleKeys.middle_name.tr(),
        hintText: LocaleKeys.enter_your_middle_name.tr(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      controller: _lastNameController,
      onSaved: (newValue) => lastName = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
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
        labelText: LocaleKeys.last_name.tr(),
        hintText: LocaleKeys.enter_your_last_name.tr(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      controller: _firstNameController,
      onSaved: (newValue) => firstName = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
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
        labelText: LocaleKeys.first_name.tr(),
        hintText: LocaleKeys.enter_your_first_name.tr(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildHouseNoFormField() {
    return TextFormField(
      onSaved: (newValue) => houseNo = newValue!,
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
        labelText: "House No",
        hintText: "Enter your house No",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/house-no.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue!,

      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      // validator: (value) {
      //   if (value.isEmpty) {
      //     addError(error: kPassNullError);
      //     return "";
      //   } else if (value.length < 8) {
      //     addError(error: kShortPassError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      //keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kEmailNullError);
        // } else

        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        // if (value.isEmpty) {
        //   addError(error: kEmailNullError);
        //   return "";
        // } else
        if (!emailValidatorRegExp.hasMatch(value!)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: LocaleKeys.enter_your_email.tr(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      controller: _emailController,
      //keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contact",
        hintText: "Contact Number",
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 13.5),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

}
