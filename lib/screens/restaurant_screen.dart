
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/models/food.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/widgets/restuarant_rating.dart';

class RestaurantScreen extends StatelessWidget {
   RestaurantScreen({Key? key,required this.restaurant}) : super(key: key);
  final Restaurant restaurant;
  _buildMenuItem(context,Food food){
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 175,
            width: 175,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(food.imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(15.0)
            ),
          ),
          Container(
            height: 175,
            width: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.3),
              ],
                stops: [
                  0.1,
                  0.4,
                  0.6,
                  0.9
                ]
              )
            ),
          ),
          Positioned(
            // left: 20.0,
            // bottom: 5.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(food.name,style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.white
                ),),
                Text("\$${food.price.toString()}",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Colors.white),
                )
      ]
    ),
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: IconButton(onPressed: (){

              }, icon:Icon(Icons.add,color: Colors.white,),
              iconSize: 30.0,)

            ),
          )
            ],
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: restaurant.imageUrl,
                child: Image(
                  height: 220.0,
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage(restaurant.imageUrl),
                fit: BoxFit.cover,),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: ()=>Navigator.pop(context),
                      icon:Icon(Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30.0,) ),

                  IconButton(onPressed: ()=>print("Favourite"),
                      icon:Icon(Icons.favorite,
                        color: Theme.of(context).primaryColor,
                        size: 30.0,) )
                ],
              )
              )
            ],
          ),
          Padding(
            padding:const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(restaurant.name,
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600),),
                    Text("0.2 miles away",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),),
                  ],
                ),
                RatingStars(rating: restaurant.rating),
                SizedBox(
                  height: 6.0,
                ),
                Text(restaurant.address,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),)

              ],
            ),
            
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).primaryColor,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),

                  onPressed: ()=> print("Reviews"),
                  child: Text("Reviews")),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                    ),
                  ),

                  onPressed: ()=> print("Contact"),
                  child: Text("Contact"))
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text("Menu",style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2
            ),),
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(10.0),
                crossAxisCount: 2,
              scrollDirection: Axis.vertical,
              children: List.generate(restaurant.menu.length, (index) {
                Food food= restaurant.menu[index];
                return _buildMenuItem(context,food);



              } ),
            ),
          ),
          
        ],
      )
    );
  }
}
