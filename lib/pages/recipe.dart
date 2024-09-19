import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_food_app/constants/apiConstant.dart';
import 'package:new_food_app/modal/food.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../components/recipeInfoCard.dart';
import 'home.dart';

class Recipe extends StatefulWidget {
  const Recipe({super.key});
  @override
  State<Recipe> createState() => _RecipeState();
}

class _RecipeState extends State<Recipe> {
  Food? mealsByID ;

  void fetchRecipe() async{
    print("fetch recipe called");
    print(endpoint);

      print('neeraj url = ${ApiConstant.recipeDetailUrl}$endpoint');
      final response2 = await http.get(Uri.parse('${ApiConstant.recipeDetailUrl}$endpoint'));
      print("neeraj 26 = ${response2}");

      final body2 = response2.body;
      print(response2.statusCode);
    print("neeraj 28 = ${body2}");
      final jsonID = jsonDecode(body2);
    print("neeraj 30 = ${jsonID}");
      final results = jsonID ;
    print("neeraj 33 = ${results}");
      final transformed = Food.fromJson(results);
      // results.map((e){
      //   return Food(
      //       name: e['name'],
      //       cuisine: e['cuisine'],
      //       // strCategory: e['strCategory'],
      //       instructions: e['instructions'],
      //       image: e['image'],
      //       // strYoutube: e['strYoutube'],
      //       // strSource: e['strSource']
      //   );
      // });
      print(results);

      setState(() {
        mealsByID = transformed;
        print("neeraj instruction = ${mealsByID?.instructions}");
      });
    print("fetch recipe completed");

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
      body:mealsByID==null ? Container(
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
                centerTitle: true,
                pinned: true,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 30
                ),
                floating:true,

                expandedHeight: 375,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: SafeArea(
                      child: Text(
                          mealsByID?.name ?? "",/* textAlign: TextAlign.center*/
                      style: const TextStyle(
                        fontSize: 20,
                          color: Colors.white,
                        overflow: TextOverflow.clip
                      )
                        ,),
                    ),
                  ),
                  background: Image.network(mealsByID!.image,
                  color: Colors.black26,
                  colorBlendMode: BlendMode.multiply,
                  fit: BoxFit.cover,),
                  centerTitle: true,
                ),
              ),

              //Category and Provinence
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(15.0, 15, 0, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Category:",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.amber
                                    ),),

                                  Text("Meal Type",
                                    style: TextStyle(
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black)
                                    ,),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image(image: AssetImage("assets/youtube.png"), height: 40,),
                            ),

                            Padding(
                              padding: const  EdgeInsets.fromLTRB(0, 15, 15, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Provenance:",
                                    style: TextStyle(
                                        fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amberAccent
                                    ),),
                                  Text(mealsByID!.cuisine,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.black)
                                    ,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Recipeinfocard(image1: 'assets/cook.gif', cardText: mealsByID!.cookTimeMinutes, suffixText: "Minutes",),
                              Recipeinfocard(image1: 'assets/rice-cooker.gif', cardText: mealsByID!.prepTimeMinutes, suffixText: "Minutes",),
                              Recipeinfocard(image1: 'assets/platter.gif', cardText: mealsByID!.servings, suffixText: "Servings",),
                              Recipeinfocard(image1: 'assets/fire_gif.gif', cardText: mealsByID!.caloriesPerServing, suffixText: "Calories",),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              //Ingredients
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Card(
                        color: Colors.white,
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                          
                            title: const Text("Ingredients",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.amber
                              ),
                            ),
                            childrenPadding: EdgeInsets.zero,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Text(mealsByID!.ingredients.join(', '),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.clip,
                                      color: Colors.black)
                                  ,),
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),

              //Making Procedure
              SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20,),
                            const Text("Procedure",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.amber
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                                mealsByID!.instructions.join('\n\n'),
                            style: TextStyle(
                              fontSize: 18
                            ),
                            ),
                            const SizedBox(height: 90,)
                            /*SizedBox(
                            child: Text(mealsByID!.instructions.toString()))*/
                        // SizedBox(
                        //   height: 200, // Adjust height as needed
                        //   child: ListView.builder(
                        //     itemCount: mealsByID?.instructions.length ?? 0,
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //         padding: const EdgeInsets.symmetric(vertical: 4.0),
                        //         child: Text(
                        //           mealsByID!.instructions[index], // Access individual instruction
                        //           style: const TextStyle(fontSize: 20),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ),

                          ],

                        ),
                      ),
                    ),
                  ),

              )

            ],
          )

    );
  }
}
