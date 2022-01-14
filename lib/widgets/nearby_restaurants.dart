import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/models/order.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/screens/restaurant_screen.dart';
import 'package:food_delivery_app/widgets/restuarant_rating.dart';

class NearByRestaurants extends StatefulWidget {
  const NearByRestaurants({Key? key}) : super(key: key);

  @override
  _NearByRestaurantsState createState() => _NearByRestaurantsState();
}

class _NearByRestaurantsState extends State<NearByRestaurants> {
  _buildRestaurants(){
    List<Widget> restaurantList=[];
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(
          GestureDetector(
            onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantScreen(restaurant: restaurant,))),
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
                          Text(restaurant.name,
                            style: TextStyle(fontSize: 20,
                                fontWeight: FontWeight.bold),),
                          const SizedBox(
                            height: 4.0,
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
    return Column(
      children: restaurantList,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Nearby Restuarants",
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0
            ),),
        ),

        _buildRestaurants(),

      ],
    );;
  }
}
