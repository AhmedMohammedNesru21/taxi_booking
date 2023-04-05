import 'package:taxi_booking/screens/otp/otp_screen.dart';
import 'package:taxi_booking/widgets/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/components/custom_surfix_icon.dart';
import 'package:taxi_booking/components/default_button.dart';
import 'package:taxi_booking/components/form_error.dart';
import 'package:taxi_booking/components/no_account_text.dart';
import 'package:taxi_booking/size_config.dart';
import 'package:flutter/services.dart';
import '../../../constants.dart';
import 'package:taxi_booking/dto/SendEmailpassDot.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              Text(
                "Re-login",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please re-enter your phone number to received a code to log back into your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.1),
              ForgotPassForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email;
  bool _is_emailed=false;
  late SendEmailPassDto _setSendEmailPassDto;
  TextEditingController _loginController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  var _dialCode = '';
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
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                // _setPasswordToEmail();
                // if(_is_emailed==true)
                //   {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => OtpScreen(
                      phone:_loginController.text,password:"",firstName: "",middleName: "",lastName: "",email: "",
                    )));
                  // }
                // Do what you want to do
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
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
