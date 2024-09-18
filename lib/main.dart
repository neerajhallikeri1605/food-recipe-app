import 'package:flutter/material.dart';
import 'package:new_food_app/pages/home.dart';
import 'package:new_food_app/pages/recipe.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
     '/home' : (context) => const Home(),
      '/recipe' : (context) => const Recipe()

    },
  ));
}

