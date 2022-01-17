
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/logic/cubit/internet_cubit.dart';
import 'package:food_delivery_app/screens/auth_screen.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/restaurant_screen.dart';
import 'package:food_delivery_app/services/http_request.dart';
import 'models/restaurant.dart';
// Import the generated file
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
 await  Firebase.initializeApp(
 );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
     MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',

     theme: ThemeData(
       visualDensity: VisualDensity.adaptivePlatformDensity,
       scaffoldBackgroundColor: Colors.grey[50],
       primaryColor: Colors.deepOrangeAccent
     ),
     home: AuthScreen(),

    );
  }
}
