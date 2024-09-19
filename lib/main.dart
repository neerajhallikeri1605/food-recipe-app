import 'package:flutter/material.dart';
import 'package:new_food_app/pages/home.dart';
import 'package:new_food_app/pages/onboarding.dart';
import 'package:new_food_app/pages/recipe.dart';
import 'package:new_food_app/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async{

  // final pref = await SharedPreferences.getInstance();
  // pref.getBool('showHome') ?? false;

  runApp(MaterialApp(
    initialRoute: '/onboarding',
    routes: {
     '/home' : (context) => const Home(),
      '/recipe' : (context) => const Recipe(),
      '/onboarding' : (context) => const Onboarding(),
      '/signup' : (context) => const Signup()

    },
  ));
}

