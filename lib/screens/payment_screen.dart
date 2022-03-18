import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
   String ? _upiAddrError;

  TextEditingController _upiAddressController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  late Future<List<ApplicationMeta>> _appsFuture;

  @override
  void initState() {
    super.initState();

    _amountController.text = (999).toString();
    _upiAddressController.text = 'shashikha1000-1@okaxis';
    _appsFuture = UpiPay.getInstalledUpiApplications();
  }

  @override
  void dispose() {

    _upiAddressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _openUPIGateway(ApplicationMeta app) async {
    final err = _validateUpiAddress(_upiAddressController.text);
    if (err != null) {
      setState(() {
        _upiAddrError = err;
      });
      return;
    }
    setState(() {
      _upiAddrError = null!;
    });

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    print("Starting transaction with id $transactionRef");

    final a = await UpiPay.initiateTransaction(
      amount: _amountController.text,
      app: app.upiApplication,
      receiverName: '@xyz',
      receiverUpiAddress: _upiAddressController.text,
      transactionRef: transactionRef,
    );

    print(a);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Scaffold(
          appBar: AppBar(title: Text('UPI Payment')),
          body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _upiAddressController,
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'address@upi',
                                labelText: 'Receiving UPI Address',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_upiAddrError != null)
                      Container(
                        margin: EdgeInsets.only(top: 4, left: 12),
                        child: Text(
                          _upiAddrError!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Amount',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 128, bottom: 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: Text(
                              'Pay Using',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                          FutureBuilder<List<ApplicationMeta>>(
                            future: _appsFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState != ConnectionState.done) {
                                return Container(
                                  height: 200,
                                  color: Colors.blue,
                                );
                              } else
                              return GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                childAspectRatio: 1.6,
                                physics: NeverScrollableScrollPhysics(),
                                children: snapshot.data!.map((i) => Material(
                                  key: ObjectKey(i.upiApplication),
                                  color: Colors.grey[200],
                                  child: InkWell(
                                    onTap: () => _openUPIGateway(i),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        i.iconImage(48),
                                        // Image.memory(
                                        //   i.iconImage(48),
                                        //   width: 64,
                                        //   height: 64,
                                        // ),
                                        Container(
                                          margin: EdgeInsets.only(top: 4),
                                          child: Text(
                                            i.upiApplication.getAppName(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                                    .toList(),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
        )
    );
    ;
  }
}
String _validateUpiAddress(String value) {
  if (value.isEmpty) {
    return 'UPI Address is required.';
  }
  // if (!UpiPay.checkIfUpiAddressIsValid(value)) {
  //   return 'UPI Address is invalid.';
  // }
  return null!;
}