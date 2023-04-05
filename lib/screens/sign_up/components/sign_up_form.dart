import 'package:taxi_booking/screens/otp/otp_screen.dart';
import 'package:taxi_booking/translations/locale_keys.g.dart';
import 'package:taxi_booking/widgets/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:taxi_booking/components/custom_surfix_icon.dart';
import 'package:taxi_booking/components/default_button.dart';
import 'package:taxi_booking/components/form_error.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  late String phone;
  late String password;
  late String conform_password;
  bool remember = false;
  late String firstName;
  late String lastName;
  late String middleName;
  final List<String> errors = [];
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _conform_passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
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
  //callback function of country picker
  void _callBackFunction(String name, String dialCode, String flag) {
    _dialCode = dialCode;
  }
 // RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])");
  bool validatePassword(String pass){
    String _password = pass.trim();
    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: getProportionateScreenHeight(20)),
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
                child:buildPhoneFormField(),
              ),
            ],
          ),
      ),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildPasswordFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: LocaleKeys.continuee.tr(),
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState?.save();
                // if all are valid then go to success screen

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => OtpScreen(
                            phone:_phoneController.text,password:_passwordController.text,firstName: _firstNameController.text,middleName: _middleNameController.text,lastName: _lastNameController.text,email: _emailController.text,
                             )));
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      controller: _conform_passwordController,
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: LocaleKeys.confirm_password.tr(),
        hintText: LocaleKeys.re_enter_your_password.tr(),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(12)),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 4) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kShortPassError);
          return "";
        }
        else
        {
          //call function to check password
          bool result = validatePassword(value);
          if(result){
            // create account event
            return null;
          }else{
            return "Password should contain Number and small letter";
          }
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
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
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
        labelText: LocaleKeys.email.tr(),
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
      controller: _phoneController,
        textAlignVertical: TextAlignVertical.center,
      //keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => phone = newValue!,
      style: TextStyle(fontSize: getProportionateScreenWidth(14)),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNullError);
        }
        // else if (emailValidatorRegExp.hasMatch(value)) {
        //   removeError(error: kInvalidEmailError);
        // }
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
        hintText: "9.......................",
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 25),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [LengthLimitingTextInputFormatter(9)]
    );
  }

  TextFormField buildMiddleNameFormField() {
    return TextFormField(
      controller: _middleNameController,
      onSaved: (newValue) => middleName = newValue!,
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
}
