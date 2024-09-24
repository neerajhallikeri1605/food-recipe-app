

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_food_app/modal/productsInCart.dart';
import 'package:new_food_app/service/databaseService.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}
final DataBaseService dataBaseService = DataBaseService.instance;

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text("My Cart", style: TextStyle(
            fontSize: 22,
            color: Colors.white
          ),
          ),
        ),
      body: Container(
        child: FutureBuilder(future: dataBaseService.getproduct(), builder: (context, snapshots){
          return ListView.builder(
            itemCount: snapshots.data?.length ?? 0,
              itemBuilder: (context, index){
              CartProducts shoppedProducts = snapshots.data![index];
                return ListTile(
                    title: Text(shoppedProducts.productName, style: TextStyle(color: Colors.black),),
                subtitle: Text(shoppedProducts.productPrice),
                );
              });
        }),
      ),
    );
  }
}
