import 'package:recipe/models/instruction.dart';

class Recipe {
  final int? time;
  final int? personNum;
  final String name;
  final String description;
  final String image;
  //final int? Rating;
  final List<instruction> instructions;

  Recipe({required this.instructions,required this.image,required this.personNum,required this.time,required this.name, required this.description});

  factory Recipe.fromJson(Map<String, dynamic> json) {

    return Recipe(
      image: json['thumbnail_url'],
      //Rating: json['user_ratings'],
      time:json['total_time_minutes'],
      name:json['name'],
      description: json['description'],
      instructions: List<dynamic>.from(json['instructions']??[]).
      map((e) => instruction.fromJson(e)).toList(),
      personNum: json['num_servings'],

    );
  }
}