import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ProgressHUD.dart';

class Pay extends StatefulWidget {
  static String routeName = "/Pay";
  final String title;
  String packagePrice;
  String userEmail;
  String fatoraKey;

  Pay(this.packagePrice, this.userEmail, this.fatoraKey, {required this.title})
  ;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

//   @override
//    _PayState createState() => _PayState(packagePrice,userEmail,fatoraKey);
// }
}

class _PayState extends State<Pay> {
  late String? packagePrice;
  late String? userEmail;
  late String? fatoraKey;

  // _PayState(this.packagePrice, this.userEmail,this.fatoraKey);

  bool _isLoading = true;
  // WebViewController controller;
  // static var uri = "https://maktapp.credit/v3/";
  // String baseURl = "https://maktapp.credit";
  String baseURl = "https://schoolpay.berhanonline.et/";
  static var uri = "https://schoolpay.berhanonline.et/";

  static BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code! >= 200) {
          return true;
        } else {
          return false;
        }
      });

  static Dio dio = Dio(options);



  @override
  void initState() {
    super.initState();
    getFatoraUrl();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: _theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text("Birhan Bank School fee",style: TextStyle(color:Colors.black54),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
        ),
      ),
      body: ProgressHUD(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            children: <Widget>[
              WebView(
                  initialUrl: baseURl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: pageFinishedLoading,
                  // onWebViewCreated: (WebViewController webViewController) {
                  //   controller = webViewController;
                  // }
            ),
            ],
          ),
        ),
        inAsyncCall: _isLoading,
        opacity: 0.0,
      ),

    );
  }

  void pageFinishedLoading(String url) {
    setState(() {
      _isLoading = false;
      if (url.contains("SuccessPayment")) {

        var transactionResponse = url.split('paymentID=')[1].split("&orderId=");
        var paymentID = transactionResponse[0];
        var orderId = transactionResponse[1].split("&transactionid=")[0];
        var transactionId = transactionResponse[1].split("&transactionid=")[1];
        Navigator.pop(context, paymentID+" "+orderId+" "+transactionId);

      } else if (url.contains("Declined")) {
        setState(() {
          baseURl = url;
          // controller.loadUrl(baseURl);
          _isLoading = true;
        });
      }
    });
  }

  Future<dynamic> getFatoraUrl() async {
    try {
      var response = await dio.post('AddTransaction', data: {
        "token": fatoraKey,
        "orderId": Uuid().v1(),
        "amount": packagePrice,
        "customerEmail": userEmail,
        "lang": "en"
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseJson = json.decode(response.data);

        setState(() {
          baseURl = responseJson["result"];
          // controller.loadUrl(baseURl);
          _isLoading = true;
        });

        return responseJson;
      } else
        print(">>Error: " + response.statusCode.toString());
    } on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        print(">>Error: " + "Network Error");
      } else if (exception.type == "DioErrorType.RECEIVE_TIMEOUT" ||
          exception.type == "DioErrorType.CONNECT_TIMEOUT") {
        print(">>Error: " +
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }
  }
}