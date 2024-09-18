import 'dart:convert';

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

  void fetchMeals() async{
    print('fetchMeals Called');

    final response = await http.get(Uri.parse(ApiConstant.recipeListUrl));

    final body = response.body;

    final json = jsonDecode(body);

    setState(() {
      meals = json["recipes"];
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
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
          backgroundColor: Colors.amber,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              final name = meal['name'];
              final image = meal['image'];
            //  endpoint = meal['idMeal'];
              return RecipeCard(
                cardName: name,
                cardImage: image,
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
