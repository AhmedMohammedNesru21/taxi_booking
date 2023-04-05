import 'dart:math';

import 'package:taxi_booking/dto/GetAllConfigDTO.dart';
import 'package:taxi_booking/repository/db_service.dart';
import 'package:taxi_booking/screens/Homemap/homemap_in_screen.dart';
import 'package:taxi_booking/util/systemConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/components/default_button.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:flutter/services.dart';
import 'package:taxi_booking/dto/SetRegisterPassangerDto.dart';
import 'package:taxi_booking/services/apimanagerdio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../globals.dart';

class OtpForm extends StatefulWidget {
  bool _isInit = true;
  var _contact = '';
  final String? phone;
  final String? password;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  OtpForm(this.phone, this.password,this.firstName,this.middleName,this.lastName,this.email);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  late TextEditingController textEditingController1;
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  late String smsOTP;
  late String verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late GetAllConfigDTO _getAllConfigs;

  //Method for generate otp from firebase
  Future<void> generateOtp(String contact) async {
    final PhoneCodeSent smsOTPSent = (String? verId, [int? forceCodeResend]) {
      verificationId = verId!;
    };
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: contact,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {print(e);},
        codeSent: smsOTPSent,
        codeAutoRetrievalTimeout: (verificationId)
        {
          print('VerificationId: $verificationId');
        },
        timeout: Duration(seconds: 60),
      );

    } catch (e) {
      // handleError(e as PlatformException);
      // Navigator.pop(context, (e as PlatformException).message);
    }
  }

  //Method for verify otp entered by user
  Future<void> verifyOtp() async {
    if (smsOTP == null || smsOTP == '') {
      showAlertDialog(context, 'please enter 4 digit otp');
      return;
    }
    final AuthCredential authCredential = PhoneAuthProvider.credential(
      smsCode: smsOTP,
      verificationId: verificationId,
    );
    try {
      final UserCredential result = await _auth.signInWithCredential(authCredential);
      User? user = result.user;
      if(user != null){
        _setAccounts();
        Navigator.pushNamed(context, HomeMapScreen.routeName);
      }else{
        print("Error");
      }

    } on PlatformException catch (e) {
      //handleError(e as PlatformException);
    } on FirebaseAuthException {
      // handleError(e as PlatformException);
    }
  }

  //Basic alert dialogue for alert errors and confirmations
  void showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    final CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text('\n$message'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  //this is method is used to initialize data
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load data only once after screen load
    if (widget._isInit) {
      String contact=widget.phone!;
      // widget._contact = '${ModalRoute.of(context).settings.arguments as String}';
      generateOtp('+251$contact');
      widget._isInit = false;
    }
  }
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;
  late FocusNode pin5FocusNode;
  late FocusNode pin6FocusNode;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }
  late int _otp, _minOtpValue, _maxOtpValue; //Generated OTP
  late SetRegisterPassengerDto _setPassengerDto;
  var _dbService = DBService();
  TextEditingController controller1 = new TextEditingController();
  TextEditingController controller2 = new TextEditingController();
  TextEditingController controller3 = new TextEditingController();
  TextEditingController controller4 = new TextEditingController();
  TextEditingController controller5 = new TextEditingController();
  TextEditingController controller6 = new TextEditingController();


  bool resultChecker(int enteredOtp) {
    //To validate OTP
    return enteredOtp == _otp;
  }
  Future<GetAllConfigDTO?> _getAllConfig() async {
    try {
      GetAllConfigDTO configData =
      GetAllConfigDTO(
        userName : widget.phone!,
        passWord: widget.password!,
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

  Future<SetRegisterPassengerDto?> _setAccounts() async {
    try {
      SetRegisterPassengerDto configData =
      SetRegisterPassengerDto(
        userName : widget.phone!,
        password: widget.password!,
        isSuccess : "1",
        lastModified:DateTime.now().toString(),
        FullName: widget.firstName!+" "+widget.middleName!+" "+widget.lastName! ,
        Phone:widget.phone!,
        Email:widget.email!,
        RoleID:"1",
        StatusId:"1",
        otp:controller.text,
        AccountMiles:"0",
        NotificationStatusId:"0", AId: '', ReferalCode: '', PassengerId: '',
      );
      _setPassengerDto = await APIManagerDio().setRegisterPassengerDto(configData);

        String? userNameL = await SystemConfig.getStringValuesSF("role");
        if (_setPassengerDto.isSuccess == "1") {
          if(userNameL==null )
          {
            await _getAllConfig();
          }
          bool isconfigData = await SystemConfig.setPassengerId(_setPassengerDto);
          if (isconfigData) {
            glUserName=(await SystemConfig.getStringValuesSF("fullName"))!;
            glPhoneNumber=(await SystemConfig.getStringValuesSF("userName"))!;
            glEmail=(await SystemConfig.getStringValuesSF("Email"))!;
            debugPrint("Login Success");
          }
        }
        Fluttertoast.showToast(
            msg: 'Successful Saved ',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white);
      }

    catch (e) {
      debugPrint(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.15),

      PinCodeTextField(
        autofocus: true,
        controller: controller,
        hideCharacter: true,
        highlight: true,
        highlightColor: Colors.white10,
        defaultBorderColor: Colors.black,
        hasTextBorderColor: Colors.white,
        highlightPinBoxColor: Colors.red,
        maxLength: pinLength,
        hasError: hasError,
        maskCharacter: "*",
        onTextChanged: (text) {
          setState(() {
            hasError = false;
          });
        },
        onDone: (text) {
          print("DONE $text");
          print("DONE CONTROLLER ${controller.text}");
        },
        pinBoxWidth: getProportionateScreenWidth(40),
        pinBoxHeight: getProportionateScreenHeight(40),
        hasUnderline: true,
        wrapAlignment: WrapAlignment.spaceAround,
        pinBoxDecoration:
        ProvidedPinBoxDecoration.defaultPinBoxDecoration,
        pinTextStyle: TextStyle(fontSize: getProportionateScreenWidth(24),color: Colors.white),
        pinTextAnimatedSwitcherTransition:
        ProvidedPinBoxTextAnimation.scalingTransition,
        pinTextAnimatedSwitcherDuration:
        Duration(milliseconds: 300),
        highlightAnimationBeginColor: Colors.white10,
        highlightAnimationEndColor: Colors.white12,
        keyboardType: TextInputType.number,
      ),


          SizedBox(height: SizeConfig.screenHeight * 0.15),
          DefaultButton(
            text: "Continue",
            press: () {
               String otpUserValue=controller.text;
               smsOTP=otpUserValue;
               verifyOtp();
            },
          )
        ],
      ),
    );
  }
}
