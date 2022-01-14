import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/restaurant_screen.dart';

import 'models/restaurant.dart';

void main() =>
    runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
     theme: ThemeData(
       scaffoldBackgroundColor: Colors.grey[50],
       primaryColor: Colors.deepOrangeAccent
     ),
     home: HomeScreenPage(),
    );
  }
}
