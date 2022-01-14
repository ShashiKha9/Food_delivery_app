import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/widgets/nearby_restaurants.dart';
import 'package:food_delivery_app/widgets/recentorders.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Icon(Icons.person_pin),
        centerTitle: true,
        title: const Text("Snacks",style: TextStyle(
          fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0),),
        actions: [
          TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen())),
              child: Text("Cart(${currentUser.cart.length})",style: TextStyle(
                  fontSize: 18.0,
                color: Colors.white,

              ),)),
        ],
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(20.0),
          child:TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(onPressed: ()=> print("clear"),
                  icon: Icon(Icons.clear)),
              contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
              fillColor: Colors.white,
                filled: true,
                hintText: "Search Food or Restuarants",
              hintStyle: TextStyle(
                color: Colors.grey
              ),
              enabled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide(width: 0.8,
                color: Theme.of(context).primaryColor),
              )
            ),
            ),
          ),
          RecentOrders(),
          NearByRestaurants(),
        ],
      ),
    );
  }
}

