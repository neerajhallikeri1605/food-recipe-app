import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_food_app/modal/food.dart';
import 'dart:convert';
import 'package:easy_url_launcher/easy_url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'home.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});
  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  List<Food> mealsByID = [];
  List array = [];
  void fetchRecipe() async{
      final response2 = await http.get(Uri.parse("https://themealdb.com/api/json/v1/1/lookup.php?i=$endpoint"));
      final body2 = response2.body;
      final jsonID = jsonDecode(body2);
      final results = jsonID["meals"] as List<dynamic>;
      final transformed = results.map((e){
        return Food(
            strMeal: e['strMeal'],
            strArea: e['strArea'],
            strCategory: e['strCategory'],
            strInstructions: e['strInstructions'],
            strMealThumb: e['strMealThumb'],
            strYoutube: e['strYoutube'],
            strSource: e['strSource']

        );
      }).toList();


      setState(() {
        mealsByID = transformed;
      });

  }

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.amber,
          onPressed: () {
            // String url = mealsByID[0].strSource;
            //   await EasyLauncher.url(url: url,
            //       mode: Mode.platformDefault);
            },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          label: const Text("More Info",
          style:  TextStyle(
            fontSize: 18,
            color: Colors.white,
          )
            ,),
          icon: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 30,),
        ),
      ),
      body:mealsByID.isEmpty ? Container(
        alignment: Alignment.center,
          child: const SpinKitPouringHourGlassRefined(
            color: Colors.amber,
            size: 100.0,
          )
        ):
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.amber,
                pinned: true,
                iconTheme: IconThemeData(
                  color: Colors.white,
                  fill: 0,
                  size: 30
                ),
                floating:true,
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Text(
                        mealsByID[0].strMeal,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    )
                      ,),
                  ),
                  background: Image.network(mealsByID[0].strMealThumb,
                  color: Colors.black26,
                  colorBlendMode: BlendMode.multiply,
                  fit: BoxFit.cover,),
                  centerTitle: true,
                ),
              ),

              //Category and Provinence
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Category:",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber
                            ),),

                          Text(mealsByID[0].strCategory,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)
                            ,),
                        ],
                      ),

                      const VerticalDivider(
                        thickness: 2, // Make the divider thin
                        width: 20,    // Adjust the spacing between the two children
                        color: Colors.black,
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Provenance:",
                            style: TextStyle(
                                fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber
                            ),),
                          Text(mealsByID[0].strArea,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)
                            ,),
                        ],
                      ),


                    ],
                  ),
                ),
              ),

              //Ingredients
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("Ingredients",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.amber
                        ),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("data\ndata\ndata\ndata\ndata",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),

                            Text("data\ndata\ndata\ndata\ndata",
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //Making Procedure
              SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        Text("Procedure",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.amber
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                            mealsByID[0].strInstructions,
                        style: TextStyle(
                          fontSize: 20
                        ),
                        ),
                        SizedBox(height: 90,)
                      ],
                    ),
                  ),
              )

            ],
          )
        // SafeArea(
        //   child: Column(
        //     children: [
        //       // Image.network(
        //       //   mealsByID[0].strMealThumb,
        //       //   height: 400, // Adjust the height as needed
        //       //   width: double.infinity, // To make it fit the width of the screen
        //       //   fit: BoxFit.cover, // Adjust the image scaling as needed
        //       // ),
        //       SizedBox(height: 20,),
        //       Text(
        //           mealsByID[0].strMeal,
        //       style: TextStyle(
        //         fontSize: 28,
        //         color: Colors.black,
        //       )
        //         ,),
        //       SizedBox(height: 5,),
        //       Text(
        //           'Category : ${mealsByID[0].strCategory}',
        //       style: TextStyle(
        //         fontSize: 18
        //       ),),
        //
        //
        //
        //     ]
        //   ),
        // ),

    );
  }
}
