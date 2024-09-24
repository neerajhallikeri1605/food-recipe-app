import 'package:flutter/material.dart';
import 'package:new_food_app/pages/cart.dart';
import 'package:new_food_app/pages/home.dart';
import 'package:new_food_app/pages/onboarding.dart';
import 'package:new_food_app/pages/recipe.dart';
import 'package:new_food_app/pages/shopping.dart';
import 'package:new_food_app/pages/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  final showHome = pref.getBool('showHome') ?? false;
  
  runApp(MyApp(showHome:showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute:showHome?'/shopping':'/onboarding' /*'/cart'*/,
      routes: {
        '/home' : (context) => const Home(),
        '/recipe' : (context) => const Recipe(),
        '/onboarding' : (context) => const Onboarding(),
        '/signup' : (context) => const Signup(),
        '/shopping': (context) => const Shopping(),
        '/cart': (context) => const Cart()

      },
    );
  }
}




