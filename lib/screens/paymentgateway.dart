import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:square_in_app_payments/in_app_payments.dart';

class PaymentGateway extends StatelessWidget{
  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId('sandbox-sq0idb-90-dYoJMjPUZtltV5M8qgQ');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();

  }
}