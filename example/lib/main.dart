import 'dart:async';
import 'package:flutter/material.dart';
import 'package:midtter/midtter.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isMakePayment = false;
  final midtter = Midtter();
  @override
  void initState() {
    super.initState();
    midtter.init("YOUR_KEY", "YOUR_API_SERVICE");
    midtter.setFinishCallback(_callback);
  }

  _makePayment() {
    setState(() {
      isMakePayment = true;
    });
    midtter
        .makePayment(
          MidtransTransaction(
              "order_id1234567890",
              7500,
              MidtransCustomer(
                  "RFL", "rifal", "rifal@gmail.com", "081277773887"),
              [
                MidtransItem(
                  "5c18ea1256f67560cb6a00cdde3c3c7a81026c29",
                  7500,
                  1,
                  "USB FlashDisk",
                )
              ],
              skipCustomer: true,
              customField1: "ANYCUSTOMFIELD",
              paymentMethod: "cc"),
        )
        .catchError((err) => print("ERROR $err"));
  }

  Future<void> _callback(TransactionFinished finished) async {
    setState(() {
      isMakePayment = false;
    });
    return Future.value(null);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: isMakePayment
              ? CircularProgressIndicator()
              : ElevatedButton(
                  child: Text("Make Payment"),
                  onPressed: () => _makePayment(),
                ),
        ),
      ),
    );
  }
}
