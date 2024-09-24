import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_food_app/components/carousalCard.dart';
import 'package:new_food_app/components/recipeCard.dart';
import 'package:http/http.dart' as http;
import 'package:new_food_app/constants/apiConstant.dart';
import 'package:new_food_app/service/databaseService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shopping extends StatefulWidget {
  const Shopping({super.key});

  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {

  final DataBaseService _dataBaseService = DataBaseService.instance;


List<dynamic> cardDetails = [];
List<dynamic> cardCategory = [];

  void fetchCardDetails() async{

    print("fetchCardDetails Called");

    final cardDetailResponse = await http.get(Uri.parse(ApiConstant.productsUrl));
    final cardCategoryResponse = await http.get(Uri.parse(ApiConstant.productsCategoryUrl));
    print("1neeraj done");
    final cardDetailBody = cardDetailResponse.body;
    final cardCategoryBody = cardCategoryResponse.body;
    print("2neeraj done");
    final cardDetailJson = jsonDecode(cardDetailBody);
    final cardCategoryJson = jsonDecode(cardCategoryBody);
    print("3neeraj done");

    setState(() {
      cardDetails = cardDetailJson['products'];
      cardCategory = cardCategoryJson;
      print("4neeraj done");
    });

    print(cardDetails);
    print("5neeraj done");

    print("fetchCardDetails finished");
  }


  void initState(){
    super.initState();
    fetchCardDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
        FloatingActionButton.extended(onPressed: () async{
          //TODO
          await Future.delayed(Duration(milliseconds: 500));
          Navigator.pushNamed(context, '/cart');

        },

          label: Text("My Cart", style: TextStyle(
            fontSize: 20,
            color: Colors.white
          ),),
          backgroundColor: Colors.pinkAccent,
          splashColor: Colors.lightBlueAccent,
          isExtended: true,
          icon: Padding(
            padding: const EdgeInsets.all(0),
            child: Image(image: AssetImage("assets/shoppingCart.png"), height: 40,),
          ),

        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 55,
        backgroundColor: Colors.lightBlue[300],
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
          ),*/
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Shopping Card
              SizedBox(
                width: 170,
                height: 50,
                child: GestureDetector(
                  onTap: (){
                  //   TODO
                  },
                  child: Card(
                    color: CupertinoColors.activeBlue,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag, color:Colors.white, size: 25,),
                          Text(
                              " Shopping",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                          ),
                        ],
                      )
                      ),
                    ),
                  ),
                ),
              ),

              //Recipes Card
              SizedBox(
                width: 170,
                height: 50,
                child: GestureDetector(
                  onTap: (){
                  Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: Card(
                    color: CupertinoColors.white,
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restaurant_menu, color: Colors.amber, size: 25,),
                              Text(
                                " Recipes",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                      ),

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))),
              toolbarHeight: 55,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () async{
                      final pref = await SharedPreferences.getInstance();
                      pref.setBool('showHome', false);
                      Navigator.pushNamed(context, "/onboarding");
                    },
                      child: Icon(Icons.person, size: 35, color: Colors.white,)),
                )
              ],
              backgroundColor: Colors.lightBlue[300],
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(100),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
                      child: CupertinoSearchTextField(
                        backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      style: TextStyle(
                        fontSize: 18
                      ),),
                    ),
                  )
              ),

              title:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hey Neeraj!",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                      ),
                      Text("Lets get you something exciting!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[350],
                        ),)
                    ],
                  ),
              pinned: true,
              floating:true,

              expandedHeight: 275,

              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0),
                  child: Carousalcard(),
                )
              )

              ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15,5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        "Category",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                    Text(
                      "View All",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: 90,
                  width: 70,
                  child: ListView.builder(
                    itemCount: cardCategory.length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryCard(cardName: cardCategory[index],icon: Icon(index%2==0?Icons.chair_rounded:index%3==0?Icons.store:index%5==0?Icons.catching_pokemon:Icons.spa,
                          size: 30, color:Colors.white,),
                          color: index%2 == 0? Colors.pinkAccent: index%3==0?Colors.purpleAccent: index%5==0?Colors.redAccent:Colors.blueAccent,);

                      },
                      /*children: [
                        CategoryCard(cardName: "Asian", icon: Icon(Icons.spa, size: 30, color: Colors.white,), color: Colors.blueAccent, ),
                        CategoryCard(cardName: "Italian", icon: Icon(Icons.local_pizza, size: 30, color: Colors.white,), color: Colors.pinkAccent),
                        CategoryCard(cardName: "Chinese", icon:Icon(Icons.ramen_dining, size: 30, color: Colors.white,), color: Colors.redAccent,),
                        CategoryCard(cardName: "Fast-Food", icon: Icon(Icons.fastfood, size: 30, color: Colors.white,), color: Colors.orangeAccent,),
                        CategoryCard(cardName: "Greek", icon: Icon(Icons.soup_kitchen_sharp, size: 30, color: Colors.white,), color: Colors.pinkAccent,),
                        CategoryCard(cardName: "Fast-Food", icon: Icon(Icons.fastfood, size: 30, color: Colors.white,), color: Colors.redAccent,),
                        CategoryCard(cardName: "Greek", icon: Icon(Icons.soup_kitchen_sharp, size: 30, color: Colors.white,), color: Colors.deepPurpleAccent,),
                        // CategoryCard(),
                        // CategoryCard(),
                        // CategoryCard(),

                      ]*/
                  ),
                ),
              )
            ),

            const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Products",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,)
                    ],
                  ),
                )
            ),

            SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                mainAxisSpacing: 12,
                // crossAxisSpacing: 12,
                mainAxisExtent: 260),
                delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10),
                        child: ProductCard(
                          productName: cardDetails[index]['title'],
                          price: cardDetails[index]["price"].toString(),
                          rating: cardDetails[index]['rating'].toString(),
                          image: cardDetails[index]['thumbnail'],
                          addtocart: () {
                            _dataBaseService.addproduct(cardDetails[index]['title'], cardDetails[index]['price'].toString());
                          },
                        )
                        // CategoryCard(cardName: "Indian", icon:Icon( Icons.restaurant_rounded), color: Colors.greenAccent,),
                      );
                    },
                  childCount: cardDetails.length
                )
            ),

            //Just for space below
            SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15,5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20,),
                      Text(
                        "Category",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),

                      Text(
                        "View All",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
            ),








          ],
        ),
      )
    );
  }
}
