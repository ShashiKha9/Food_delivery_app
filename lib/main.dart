
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
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
       primaryColor: Colors.deepOrangeAccent,
       canvasColor: Colors.deepOrangeAccent,
     ),
     home: BottomBar(),

    );
  }
}
