import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:new_food_app/components/recipeCard.dart';
import 'package:new_food_app/constants/apiConstant.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List<dynamic> meals = [];

late int endpoint;

class _HomeState extends State<Home> {
  bool isImageLoading = true;

  void fetchMeals() async{
    print('fetchMeals Called');

    final response = await http.get(Uri.parse(ApiConstant.recipeListUrl));

    final body = response.body;

    final json = jsonDecode(body);

    setState(() {
      meals = json["recipes"];
      setState(() {
        isImageLoading = false;
      });
    });

    print(meals);
    print("fetch meals completed");

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMeals();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.amber[300],
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
                      Navigator.pushReplacementNamed(context, '/shopping');
                    },
                    child: Card(
                      color: CupertinoColors.white,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_bag, color:Colors.blueAccent, size: 25,),
                                Text(
                                  " Shopping",
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

                //Recipes Card
                SizedBox(
                  width: 170,
                  height: 50,
                  child: GestureDetector(
                    onTap: (){
                      // Navigator.pushNamed(context, '/home');
                    },
                    child: Card(
                      color: Colors.amber[800],
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                        child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.restaurant_menu, color: Colors.white, size: 25,),
                                Text(
                                  " Recipes",
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
              ],
            ),
          ),
        ),
        body:isImageLoading ? SpinKitPouringHourGlassRefined(color: Colors.amber, size: 100,): ListView.builder(
            itemCount: meals.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final meal = meals[index];
              final name = meal['name'];
              final image = meal['image'];
            //  endpoint = meal['idMeal'];
              return RecipeCard(
                cardName: name,
                cardImage:image,
                ontap: (){
                    endpoint = meal['id'];
                    print(endpoint);
                    Navigator.pushNamed(context, '/recipe', arguments: endpoint);
                  },
              );
            }
        )

    );
  }

  
}
