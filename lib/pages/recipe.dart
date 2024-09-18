import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:new_food_app/constants/apiConstant.dart';
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
                pinned: true,
                iconTheme: const IconThemeData(
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
                        mealsByID?.name ?? "",
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white
                    )
                      ,),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Category:",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber
                                ),),

                              Text("Some Category",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)
                                ,),
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: Image.network(""),
                        // ),
                    
                        // const VerticalDivider(
                        //   thickness: 2, // Make the divider thin
                        //   width: 20,    // Adjust the spacing between the two children
                        //   color: Colors.black,
                        // ),
                    
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Provenance:",
                                style: TextStyle(
                                    fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber
                                ),),
                              Text(mealsByID!.cuisine,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)
                                ,),
                            ],
                          ),
                        ),
                    
                    
                      ],
                    ),
                  ),
                ),
              ),

              //Ingredients
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
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
                        padding: EdgeInsets.symmetric(horizontal: 18.0),
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
                        const SizedBox(height: 20,),
                        const Text("Procedure",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.amber
                          ),
                        ),
                        /*SizedBox(
                        child: Text(mealsByID!.instructions.toString()))*/
                    SizedBox(
                      height: 200, // Adjust height as needed
                      child: ListView.builder(
                        itemCount: mealsByID?.instructions.length ?? 0,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              mealsByID!.instructions[index], // Access individual instruction
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        },
                      ),
                    ),
                        const SizedBox(height: 90,)
                      ],
                    ),
                  ),
              )

            ],
          )

    );
  }
}
