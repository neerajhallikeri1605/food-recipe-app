import 'dart:ffi';

class Food{
  late String name;
  late String image;

  late String cuisine;
  late List<String> instructions;


  Food({
    required this.name,
    required this.image,
    required this.cuisine,
    required this.instructions,

  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'],
      cuisine: json['cuisine'],
      instructions: List<String>.from(json['instructions']),
      image: json['image'],
    );
  }
}