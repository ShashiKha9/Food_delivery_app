import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/models/order.dart';

class RecentOrders extends StatelessWidget {
  const RecentOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text("Recent Orders",
              style:TextStyle(fontSize: 22.0,
                fontWeight: FontWeight.w600,
                letterSpacing: 1
          )),
        ),
        Container(
          height: 120,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: currentUser.orders.length,
              itemBuilder: (context,int index){
              Order order= currentUser.orders[index];
              return Container(
                width: 320,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(width: 1.0,
                      color: Colors.white),

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image(
                            height: 100.0,
                            width: 100.0,
                            image: AssetImage(order.food.imageUrl),
                            fit: BoxFit.cover,),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.food.name,style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600
                              ),),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Text(order.restaurant.name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
                                ),),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Text(order.date,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
                                ),)
                            ],
                          ),
                        ),
                ]

                    ),

                    Container(
                      width: 48.0,
                      margin: EdgeInsets.only(right: 20.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child:IconButton(onPressed: ()=> print("add"),
                            icon: Icon(Icons.add,
                            size: 30.0, color: Colors.white,
                            ))

                    )
                  ],
                ),
              );




              }),
        )

      ],
      
    );
  }
}
