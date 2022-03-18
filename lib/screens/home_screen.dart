
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

import '../constants/internet.dart';
import 'authscreen.dart';
import 'favorite_sccreen.dart';


class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState(connectivity: Connectivity());
}

class _HomeScreenPageState extends State<HomeScreenPage> {
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
   final ValueChanged<String> onChanged;
    SearchPage(this.onChanged);

  SearchPageState createState()=> SearchPageState();

}
class SearchPageState extends State<SearchPage>{
  final text = TextEditingController();
  late List<Restaurant> rest=restaurants;
  @override
  Widget build(BuildContext context) {
     return
       Scaffold(
       body: Container(
         height: 48,
         width: double.infinity,
         margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
         child: Column(
           children: [
             TextFormField(
               cursorColor: Theme.of(context).primaryColor,
               autofocus: true,
               controller: text,
               decoration: InputDecoration(
                   prefixIcon: IconButton(
                       splashRadius: 20.0,
                       iconSize: 20.0,
                       onPressed: (){
                         Navigator.of(context).pop();
                       }, icon: Icon(Icons.arrow_back_ios_rounded,
                     color: Theme.of(context).primaryColor,
                   )),
                   suffixIcon: text.text.isNotEmpty? GestureDetector(
                     child: Icon(Icons.clear_outlined,size: 18.0,
                       color: Colors.grey[600],
                     ),
                     onTap: (){
                       setState(() {
                         text.clear();
                       });
                     },
                   ):null,
                   fillColor: Colors.white,
                   filled: true,
                   hintText: "Search Food or Restuarants",
                   hintStyle: TextStyle(
                       letterSpacing: 0.6,
                       color: Colors.grey,
                       fontWeight: FontWeight.w400
                   ),
                   contentPadding: EdgeInsets.symmetric(vertical: 10),
                   focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Theme.of(context).primaryColor),
                       borderRadius: BorderRadius.circular(10.0)
                   )
               ),
               onChanged: widget.onChanged,
             ),
             Expanded(child: ListView.builder(
               itemCount: rest.length,
                 itemBuilder: (context, index) {
                 final r = rest[index];
                 return buildRest(r);
                 }))
           ],

         ),
       ),

   );

  }

  Widget buildRest(Restaurant r) =>ListTile(
    leading: Image.asset(r.imageUrl,
      fit: BoxFit.cover,
      width: 50,
      height: 50,
    ),
    title: Text(r.name),
    subtitle: Text(r.address),
  );

  void searchRest(String query){
    final restaurant = rest.where((r) {
      final nameLower = r.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower);
    }).toList();
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








