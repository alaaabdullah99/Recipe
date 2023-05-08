import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:recipe/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  Future<List<Recipe>> fetchRecipe(String textSearch) async {
    var Recipes=<Recipe>[];
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "0", "size": "20", "tag": "under_3-_minutes"});


    final response = await http
        .get(uri,
        headers:{
          "x-rapidapi-key": "5c3e6666ffmsh36ddfe0334d832cp12e5edjsn0d8d4cdae257",
          "x-rapidapi-host": "tasty.p.rapidapi.com",
          "useQueryString": "true"
        }
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonResponse = json.decode(response.body);

      final inspect= jsonResponse['results'];
      print(inspect);
      for( var resp in inspect){
        Recipes.add(Recipe.fromJson(resp));
      }
      return Recipes.where((element) => element.name.toLowerCase().contains(textSearch)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Recipes');
    }
  }
}