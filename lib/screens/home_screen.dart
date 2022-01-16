import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/constants/internet.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/logic/cubit/internet_cubit.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/widgets/nearby_restaurants.dart';
import 'package:food_delivery_app/widgets/recentorders.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState(connectivity: Connectivity());
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  final Connectivity connectivity;
  _HomeScreenPageState({required this.connectivity});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>
        InternetCubit(connectivity: connectivity),
     child: Scaffold(
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
      body: BlocListener<InternetCubit,InternetState>(
        listener: ( context, state) {
          if(state is InternetConnected && state.internet == Internet.Online){
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Internet Connected",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0,
                      fontWeight: FontWeight.w600),),
                  backgroundColor: Colors.green,));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No Internet Connection",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0,
                      fontWeight: FontWeight.w600,),),
                  backgroundColor: Colors.black87,));

          }
      },

        child: ListView(
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
      )
      ),
    );
  }
}

