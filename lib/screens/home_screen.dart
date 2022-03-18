
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/logic/cubit/internet_cubit.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/screens/restaurant_screen.dart';
import 'package:food_delivery_app/widgets/nearby_restaurants.dart';
import 'package:food_delivery_app/widgets/recentorders.dart';
import 'package:badges/badges.dart';
import 'package:food_delivery_app/widgets/restuarant_rating.dart';
import 'package:food_delivery_app/widgets/searchwidget.dart';

import '../constants/internet.dart';
import 'authscreen.dart';
import 'favorite_sccreen.dart';


class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key,}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState(connectivity: Connectivity());
}

class _HomeScreenPageState extends State<HomeScreenPage> {
   String text="restaurant0";
  final Connectivity connectivity;
  _HomeScreenPageState({required this.connectivity,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context)=>
        InternetCubit(connectivity: connectivity),
     child: Scaffold(
       drawer: Drawer(
         child:Container(
           margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            TextButton(onPressed: (){
               Navigator.pushReplacement(context, 
                   MaterialPageRoute(builder: (context)=> AuthScreen()));
             }, child: Text("Logout",style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: Colors.white),))
             ]
            )
         ),
       ),

      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Icon(Icons.person),
        centerTitle: true,
        
        title: const Text("Snacks",style: TextStyle(
          fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0),),
        actions: [
          TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen())),
              child: Badge(
                position: BadgePosition.topEnd(top: -16,end: -11),
                badgeContent: Text(currentUser.cart.length.toString(),style: TextStyle(color: Colors.white),),
                child: Icon(Icons.shopping_cart_outlined,color: Colors.white,),
              )
          ),
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
                      duration: Duration(milliseconds: 300),
                      backgroundColor: Colors.green,));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("No Internet Connection",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0,
                        fontWeight: FontWeight.w600,),),
                      duration: Duration(milliseconds: 300),
                      backgroundColor: Colors.black87,));
              }
            },

            child: ListView(
              children: [
                Padding(padding: EdgeInsets.all(20.0),
                  child:Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                  child:GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> SearchPage())),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(Icons.search_sharp,
                            color: Theme.of(context).primaryColor,),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Search for Restaurant...",style: TextStyle(
                              letterSpacing: 0.6,
                              color: Colors.grey,
                          fontWeight: FontWeight.w400),)
                        ],
                      ),
                    ),
                    ),
                  ),
                ),
                RecentOrders(),
                NearByRestaurants(),
              ],
            ),
      ),
      ),
    );
  }
}
class SearchPage extends StatefulWidget{
  const  SearchPage({Key ?key}):super(key: key);
  SearchPageState createState()=> SearchPageState();
}
class SearchPageState extends State<SearchPage>{
  late List<Restaurant> rest=restaurants;
  String query='';

  @override
  Widget build(BuildContext context) {
     return
       Scaffold(
       body:Column(
         children: [
           buildSearch(),
           Expanded(child: ListView.builder(
               itemCount: rest.length,
               itemBuilder: (context, index) {
                 final r = rest[index];
                 return buildRest(r);
               }))
         ],
       )
   );

  }


  Widget buildRest(Restaurant r) =>ListTile(
    leading: Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(r.imageUrl,),
            fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8.0)
      ),
    ),
    title: Text(r.name),
    subtitle: Text(r.address),
  );
  Widget buildSearch()=> SearchWidget(
    onChanged: searchRest,
    text: query,
  );

  void searchRest(String query){
    final rest = restaurants.where((r) {
      final nameLower = r.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query=query;
      this.rest=rest;
    });
  }
}


class BottomBar extends StatefulWidget{
  BottomBarState createState()=> BottomBarState();
}
class BottomBarState extends State<BottomBar> {

  List<Widget> _pages=<Widget>[
    HomeScreenPage(),
    FavoriteScreen(),
    FavoriteScreen(),
    FavoriteScreen(),

  ];
  int _selectedtIndex=0;

  void _onTapped(index){
    setState(() {
      _selectedtIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        _pages.elementAt(_selectedtIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.black),
        currentIndex: _selectedtIndex,
        onTap: _onTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu_outlined),
              label: "Restaurant",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_food_beverage_outlined),
              label: "Food"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: "Wallet"
          ),
        ],
      ),
    );
  }
}








