
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Pay.dart';

class PaymentDetail  extends StatefulWidget {
  static String routeName = "/PaymentDetail";
  //PaymentDetail({Key key, this.title}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<PaymentDetail> {

  String paymentID="";
  String orderId="";
  String transaction="";

  final _teAmount = TextEditingController();
  final _teEmail = TextEditingController();

  void _pay() {
    if (_teAmount.text.isNotEmpty && _teEmail.text.isNotEmpty) {
      final result = Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Pay(
                  _teAmount.text.trim(),
                  _teEmail.text.trim(),
                  "E4B73FEE-F492-4607-A38D-852B0EBC91C9", title: '',)));
      result.then((result) {
        transactionResult(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          ),

        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),

            child: getFormUI(),
          ),
        ));
  }

  Widget getFormUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        TextFormField(
          controller: _teAmount,
          decoration: InputDecoration(hintText: 'Amount'),
          keyboardType: TextInputType.phone,
          maxLength: 10,
        ),
        TextFormField(
          controller: _teEmail,
          decoration: InputDecoration(hintText: 'Email'),
          maxLength: 32,
        ),
        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: _pay,
          child: Text('Pay'),
        ),

        SizedBox(height: 40.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(paymentID),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(orderId),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(transaction),
        ),
      ],
    );
  }

  Widget buttonMedium(String buttonLabel, EdgeInsets margin, Color bgColor,
      Color textColor, double textSize) {
    var loginBtn = Container(
      margin: margin,
      padding: EdgeInsets.all(10.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(const Radius.circular(60.0)),
      ),
      child: Text(
        buttonLabel,
        style: TextStyle(
            color: textColor, fontSize: textSize, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

  void transactionResult(String result) {
    _teAmount.text = "";
    _teEmail.text = "";

    setState(() {
      var transactionDetail = result.split(" ");

      paymentID="Payment Id: "+transactionDetail[0];
      orderId="OrderId: "+transactionDetail[1];
      transaction="Transaction Id: "+transactionDetail[2];
    });

  }
}
