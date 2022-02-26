import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/data/data.dart';
import 'package:food_delivery_app/models/order.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState( );
}

class _CartScreenState extends State<CartScreen> {
  int counter =0;
  _buildCardItem(Order order){
    final int minValue=0;
    final int maxValue=1000;
    print("repeat steps");
   return  Container(
      margin: EdgeInsets.all(10.0),
      height: 170.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0)
      ),
      child: Row(
        children: [
          Expanded(
              child: Row(
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(order.food.imageUrl),
                            fit: BoxFit.cover
                        ),
                        borderRadius: BorderRadius.circular(15.0)
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(order.food.name, style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(order.restaurant.name, style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,

                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 40,
                            width: 120.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10.0),
                                border: Border.all(width: 0.8,
                                    color: Colors.black)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                onTap: (){
                                setState(() {
                                  if(counter > minValue)
                                  counter--;
                                  print(counter);
                                });
                              },
                                child: Icon(CupertinoIcons.minus,
                                  size: 25,
                                  color: Theme.of(context).primaryColor,),
                              ),
                                Text("${counter}",
                                  style: TextStyle(fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      if(counter < maxValue)
                                        counter++;
                                      print(counter);
                                    });
                                  },
                                  child: Icon(Icons.add,
                                    size: 25,
                                    color: Theme.of(context).primaryColor,),
                                ),

                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          Container(
                child: Text("\$${counter * order.food.price}",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600
                  ),),
          ),

        ],
      ),

    );
  }


  @override
  Widget build(BuildContext context) {
    double totalprice=0.0;
    currentUser.cart.forEach((Order order) => totalprice+= counter * order.food.price

    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text("Cart(${currentUser.cart.length})"),
      ),
      body: ListView.separated(
        itemCount: currentUser.cart.length+1,
        separatorBuilder: (BuildContext context,int index){
          return Divider(
            height: 1.0,
            color: Colors.grey,
          );
        },
          itemBuilder: (BuildContext context,int index){
          if(index < currentUser.cart.length) {
            Order order = currentUser.cart[index];
            return _buildCardItem(order);
          }
          return
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
         Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Estimated Delivery Time",style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600),),

                          Text("25 min",style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600))

                        ],
                      ),
                  

                  SizedBox(
                    height: 12.0,
                  ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Cost",style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),),

                        Text("\$${totalprice.toStringAsFixed(2)}",style: TextStyle(
                          color: Colors.green[700],
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600))

                      ],
                    ),
                  SizedBox(
                    height: 100.0,
                  )


                ],
              ),
            );

          }



         ),
      bottomSheet: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0,-1),
              blurRadius: 6.0

            ),
          ]
        ),
        child: Center(
          child: TextButton(onPressed: (){
            
          }, child: Text("Checkout",style: TextStyle(
            color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0),)),
        ),
      ),
    );
  }
}
