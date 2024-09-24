import 'dart:ffi';

class Food{
  late String name;
  late String image;
  late String cuisine;
  late List<String> instructions;
  late List<String> ingredients;
  late String cookTimeMinutes;
  late String prepTimeMinutes;
  late String servings;
  late String caloriesPerServing;


  Food({
    required this.name,
    required this.image,
    required this.cuisine,
    required this.instructions,
    required this.ingredients,
    required this.cookTimeMinutes,
    required this.prepTimeMinutes,
    required this.servings,
    required this.caloriesPerServing,



  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      cuisine: json['cuisine'],
      instructions: List<String>.from(json['instructions']),
      image: json['image'],
      ingredients: List<String>.from (json["ingredients"]),
      cookTimeMinutes: json["cookTimeMinutes"].toString(),
      prepTimeMinutes: json['prepTimeMinutes'].toString(),
      servings: json["servings"].toString(),
      caloriesPerServing: json["caloriesPerServing"].toString()
    );
  }
}