import 'dart:async';

import 'package:taxi_booking/dto/GetAllConfigDTO.dart';
import 'package:taxi_booking/dto/userCredentialDto.dart';
import 'package:taxi_booking/repository/db_service.dart';
import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'package:taxi_booking/services/apimanagerdio.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:taxi_booking/widgets/country_picker.dart';
import 'package:taxi_booking/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/components/custom_surfix_icon.dart';
import 'package:taxi_booking/components/form_error.dart';
import 'package:taxi_booking/helper/keyboard.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../globals.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../wellcome.dart';
import '../sign_in_screen.dart';
class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  bool remember = false;
  late String userName;
  late String phoneNumber;
  final List<String> errors = [];
  var _dbService = DBService();
  late UserCredentialDTO receivedUser;
  var _dialCode = '';
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  late GetAllConfigDTO _getAllConfigs;
  // @override
  // void initState() {
  //     detectUser();
  //   super.initState();
  // }
  int currentPage = 0;
  void detectUser() async {
    if ( await SystemConfig.getStringValuesSF("userName")!= null && await SystemConfig.getStringValuesSF("userName")!= "" && await SystemConfig.getStringValuesSF("passWord") != null && await SystemConfig.getStringValuesSF("passWord") !="") {
      glUserName=(await SystemConfig.getStringValuesSF("fullName"))!;
      glPhoneNumber=(await SystemConfig.getStringValuesSF("userName"))!;
      glEmail=(await SystemConfig.getStringValuesSF("email"))!;
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeMapScreen()));
    }
    else
    {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen()));
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
  Future<bool?>_userLogin() async {
    try
    {
      ProgressDialog(message: LocaleKeys.logging_in.tr(),);
      if (_loginController.text.isNotEmpty ) {
        List<UserCredentialDTO> _userCredentials = [
          UserCredentialDTO(
            userName: _loginController.text,
            passWord: "a123456",
            role: "1",
            phoneNumber:(await SystemConfig.getStringValuesSF("Phone")!= null? await SystemConfig.getStringValuesSF("Phone"): "911027763")!,
            OTP :(await SystemConfig.getStringValuesSF("OTP")!= null? await SystemConfig.getStringValuesSF("OTP"): "0")!, email: '', fullName: '', profileImage: '', isSuccess: '',
          ),
        ];
        receivedUser = await APIManagerDio().login(_userCredentials);
        String? userNameL = await SystemConfig.getStringValuesSF("role");
            if (receivedUser.isSuccess == "1") {
              if(userNameL==null )
              {
                await _getAllConfig();
              }
              bool isLoggedIn = await SystemConfig.setLogin(receivedUser);
              if (isLoggedIn) {
                glUserName=(await SystemConfig.getStringValuesSF("fullName"))!;
                glPhoneNumber=(await SystemConfig.getStringValuesSF("userName"))!;
                glEmail=(await SystemConfig.getStringValuesSF("email"))!;
                debugPrint("Login Success");
                return true;
              }
              else {
                return false;
              }
            } else {
              debugPrint("unable to set Login ");
              Fluttertoast.showToast(
                  msg: LocaleKeys.login_unsuccessful.tr(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.red,
                  textColor: Colors.white);
              return false;
            }
          }



    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
             LocaleKeys.internet_connection_problem.tr()),
        ),
      );
      return false;
    }
  }
  Future<GetAllConfigDTO?> _getAllConfig() async {
    try {
      GetAllConfigDTO configData =
      GetAllConfigDTO(
        userName: _loginController.text,
        passWord:_passwordController.text,
        imei:"359175104936577",
        ratesLastUpdated:(await SystemConfig.getStringValuesSF("ratesLastUpdated")!= null? await SystemConfig.getStringValuesSF("ratesLastUpdated"): "1970-01-01")!,
        regionsLastUpdated:(await SystemConfig.getStringValuesSF("regionsLastUpdated")!= null? await SystemConfig.getStringValuesSF("regionsLastUpdated"): "1970-01-01")!,
        subCityModelLastUpdated:(await SystemConfig.getStringValuesSF("subCityModelLastUpdated")!= null? await SystemConfig.getStringValuesSF("subCityModelLastUpdated"): "1970-01-01")!,
        woredaLastUpdated:(await SystemConfig.getStringValuesSF("woredaLastUpdated")!= null? await SystemConfig.getStringValuesSF("woredaLastUpdated"): "1970-01-01")!,
        serviceLastUpdated:(await SystemConfig.getStringValuesSF("serviceLastUpdated")!= null? await SystemConfig.getStringValuesSF("serviceLastUpdated"): "1970-01-01")!,
        routeStatusLastUpdated:(await SystemConfig.getStringValuesSF("routeStatusLastUpdated")!= null? await SystemConfig.getStringValuesSF("routeStatusLastUpdated"): "1970-01-01")!,
        vehicleModelLastUpdated:(await SystemConfig.getStringValuesSF("vehicleModelLastUpdated")!= null? await SystemConfig.getStringValuesSF("vehicleModelLastUpdated"): "1970-01-01")!,
        extraRateTypesLastUpdated:(await SystemConfig.getStringValuesSF("extraRateTypesLastUpdated")!= null? await SystemConfig.getStringValuesSF("extraRateTypesLastUpdated"): "1970-01-01")!,
        extraRatesLastUpdated:(await SystemConfig.getStringValuesSF("extraRatesLastUpdated")!= null? await SystemConfig.getStringValuesSF("extraRatesLastUpdated"): "1970-01-01")!,
        cancelationReasonsLastUpdated:(await SystemConfig.getStringValuesSF("cancelationReasonsLastUpdated")!= null? await SystemConfig.getStringValuesSF("cancelationReasonsLastUpdated"): "1970-01-01")!, rates: [], regions: [], subCitys: [], woredas: [], services: [], routeStatuses: [], cancelationReasons: [], extraRates: [], extraRateTypes: [], vehicleModels: [],
      );

      _getAllConfigs = await APIManagerDio().getConfig(configData);


          if(_getAllConfigs.rates!=null) {
            if (_getAllConfigs.rates.isNotEmpty) {
              _getAllConfigs.rates.forEach((rate) async {
                await _dbService.insertRates(rate);
              });
            }

          }
          if(_getAllConfigs.regions!=null) {
            if (_getAllConfigs.regions.isNotEmpty) {
              _getAllConfigs.regions.forEach((region) async {
                await _dbService.insertRegions(region);
              });

            }
          }


          if(_getAllConfigs.subCitys!=null) {
            if (_getAllConfigs.subCitys.isNotEmpty) {

              _getAllConfigs.subCitys.forEach((subcity) async
              {
                await _dbService.insertSubcity(subcity);
              });
            }
          }
          if(_getAllConfigs.woredas!=null) {
            if (_getAllConfigs.woredas.isNotEmpty) {
              _getAllConfigs.woredas.forEach((wereda) async {
                await _dbService.insertWereda(wereda);
              });
            }
          }
          if(_getAllConfigs.services!=null) {
            if (_getAllConfigs.services.isNotEmpty) {
              _getAllConfigs.services.forEach((service) async {
                await _dbService.insertService(service);
              });
            }
          }
          if(_getAllConfigs.routeStatuses!=null) {
            if (_getAllConfigs.routeStatuses.isNotEmpty) {
              _getAllConfigs.routeStatuses.forEach((routeStatuse) async {
                await _dbService.insertRouteStatuses(routeStatuse);
              });
            }
          }
          if(_getAllConfigs.extraRateTypes!=null) {
            if (_getAllConfigs.extraRateTypes.isNotEmpty) {
              _getAllConfigs.extraRateTypes.forEach((extraRateType) async {
                await _dbService.insertExtraRateTypes(extraRateType);
              });
            }
          }
          if(_getAllConfigs.extraRates!=null) {
            if (_getAllConfigs.extraRates.isNotEmpty) {
              _getAllConfigs.extraRates.forEach((extraRate) async {
                await _dbService.insertExtraRates(extraRate);
              });
            }
          }
          if(_getAllConfigs.vehicleModels!=null) {
            if (_getAllConfigs.vehicleModels.isNotEmpty) {
              _getAllConfigs.vehicleModels.forEach((vehicleModel) async {
                await _dbService.insertVehicleModels(vehicleModel);
              });
            }
          }
          if(_getAllConfigs.cancelationReasons!=null) {
            if (_getAllConfigs.cancelationReasons.isNotEmpty) {
              _getAllConfigs.cancelationReasons.forEach((cancelationReason) async {
                await _dbService.insertCancelationReasons(cancelationReason);
              });
            }
          }

          Fluttertoast.showToast(
              msg: "All Configuration Data Saved Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              // timeInSecForIos: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white);

    }
    catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          // timeInSecForIos: 1,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
    }
  }
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // height: 45,
            decoration: BoxDecoration(
              border: Border.all(
                color: kPrimaryColor,
              ),
              borderRadius: BorderRadius.circular(36),
            ),
            child:
            Row(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                CountryPicker(
                  callBackFunction: _callBackFunction,
                  headerText: 'Select Country',
                  headerBackgroundColor: Theme.of(context).primaryColor,
                  headerTextColor: Colors.grey,
                ),
                SizedBox(
                  width:  MediaQuery.of(context).size.width * 0.01,
                ),
                Expanded(
                  child:   buildPhoneFormField(),
                ),
              ],
            ),
          ),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value!;
                  });
                },
              ),
              Text(LocaleKeys.remember_me.tr()),
              Spacer(),
              GestureDetector(
                // onTap: () => Navigator.pushNamed(
                //     context, ForgotPasswordScreen.routeName),
                child: Text(""
                  // LocaleKeys.forgot_password.tr(),
                  // style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: LocaleKeys.continuee.tr(),
            press: () async {
              if ( await _userLogin()==true)
              {
              KeyboardUtil.hideKeyboard(context);
              Navigator.pushNamed(context, WellCome.routeName);
              // }
              }
              else
                {
                  Navigator.pop(context);
                }
            },
          ),
        ],
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
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: LocaleKeys.password.tr(),
        hintText: LocaleKeys.enter_your_password.tr(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _loginController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue!,
      onChanged: (value) {
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
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
  TextFormField buildPhoneFormField() {
    return TextFormField(
        controller: _loginController,
        textAlignVertical: TextAlignVertical.center,
        onSaved: (newValue) => email = newValue!,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNullError);
          }

          return null;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPhoneNullError);
            return "";
          }
          return null;
        },
        decoration: InputDecoration(
          //labelText: "Phone",
          hintText: "9........................",
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 35),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [LengthLimitingTextInputFormatter(9)]
    );
  }
}
