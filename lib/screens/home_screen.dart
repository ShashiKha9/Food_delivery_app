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
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/screens/auth_screen.dart';
import 'package:food_delivery_app/screens/cart_screen.dart';
import 'package:food_delivery_app/screens/restaurant_screen.dart';
import 'package:food_delivery_app/widgets/nearby_restaurants.dart';
import 'package:food_delivery_app/widgets/recentorders.dart';
import 'package:badges/badges.dart';
import 'package:food_delivery_app/widgets/restuarant_rating.dart';

import 'favscreen.dart';

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
                  child:TextField(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> SearchPage())),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Search Food or Restuarants",
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide(width: 0.8,
                            color: Theme.of(context).primaryColor
                              ),
                        )
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

class SearchPage extends StatelessWidget{
  List<Widget> restaurantList=[];

  final text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(
          GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context)=> RestaurantScreen(restaurant: restaurant,))),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              height: 150,
              width: 370,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Color(0xffEEEEEEFF),),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Hero(
                      tag: restaurant.imageUrl,
                      child: Image(
                        height: 150,
                        width: 150,
                        image: AssetImage(restaurant.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(restaurant.name,
                                style: TextStyle(fontSize: 20,
                                    fontWeight: FontWeight.bold),),

                              IconButton(onPressed:()=> print("hi"),
                                icon: Icon( Icons.favorite ,
                                  size: 30,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                          RatingStars(rating: restaurant.rating,),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text(restaurant.address,
                            style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,),
                          const SizedBox(
                            height: 4.0,
                          ),
                          Text("0.2 miles away",
                            style: TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      );


    });
   return Scaffold(
     body: Container(
       margin: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
       child: TextFormField(
         onTap: () => Navigator.push(context,
             MaterialPageRoute(builder: (context)=> SearchPage())),
         decoration: InputDecoration(
             prefixIcon: Icon(Icons.search,color: Theme.of(context).primaryColor,),
             contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
             fillColor: Colors.white,
             filled: true,
             hintText: "Search Food or Restuarants",
             hintStyle: TextStyle(
                 color: Colors.grey
             ),
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(30.0),
               borderSide: BorderSide(width: 0.8,
                   color: Theme.of(context).primaryColor
               ),
)),
         onChanged: (value){
           if(value.isNotEmpty){
             return ;
           }
         },
       ),
     )
   );
  }
  Widget _searchListView(){
    return ListView.builder(
      itemCount: restaurantList.length,
        itemBuilder: (context,index){

        return Card(
          child: ListTile(
            title: Text("d"),
          ),
        );
        });
  }
}

class BottomBar extends StatefulWidget{
  BottomBarState createState()=> BottomBarState();
}
class BottomBarState extends State<BottomBar> {

  List<Widget> _pages=<Widget>[
    HomeScreenPage(),
    FavScreen(),
    FavScreen(),
    FavScreen()
    
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








