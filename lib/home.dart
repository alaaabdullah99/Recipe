
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe/models/instruction.dart';
import 'Details.dart';
import 'Favorite.dart';
import 'package:recipe/provider/favorite_provider.dart';
import 'home.dart';
import 'models/recipe.api.dart';
import 'models/recipe.dart';


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






class home extends StatefulWidget {

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String textSearch="" ;

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);

    return MaterialApp(
      title: 'Food recipe',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Food recipe'),
        ),
        body:
        Container(
          child: Column(
            children: <Widget>[
               Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                  onChanged:(text){
                    setState(() {
                      textSearch=text;

                    });
                  },

                ),
              ),
              Expanded(
                child: FutureBuilder<List<Recipe>>(
                  future: fetchRecipe(textSearch),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final fav = snapshot.data![index];
                            //rating r=snapshot.data![index].Rating;
                            return Container(

                              child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Row(
                                        children: [
                                          Image.network(snapshot.data![index].image,
                                            height:120,
                                          ),

                                          Flexible(child:  Padding(padding: EdgeInsets.fromLTRB(10,0,5,0),
                                              child:Text(fav.name,
                                                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold) )
                                          ),),



                                        ],
                                      ),
                                      Row(children: [
                                        Icon(Icons.star,color: Colors.yellow.shade700,size: 30,),

                                        Text("1",style: TextStyle(fontSize: 20),),
                                        SizedBox(width: 100,),

                                        MaterialButton(child:provider.isExist(fav)
                                            ? const Icon(Icons.favorite, color: Colors.redAccent)
                                            : const Icon(Icons.favorite_border,color:Colors.redAccent),
                                          color: Colors.grey.shade300,
                                          shape: CircleBorder(),
                                          onPressed: (){
                                            provider.toggleFavorite(fav);
                                          },),
                                        MaterialButton(color: Colors.grey.shade300,
                                          child:const Icon(Icons.arrow_forward,
                                            color:Colors.lightBlueAccent,
                                          ),
                                          shape: CircleBorder(),
                                          onPressed: (){

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Details( recipe:fav,)),
                                            );
                                          },),



                                      ],),
                                    ],

                                  )
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              padding: EdgeInsets.fromLTRB(20,20,0,0),
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                                border: Border.all(color: Colors.blueGrey),
                                color:Colors.grey.shade200,
                              ),

                            );
                          });
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
                ),
              ),


            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat ,
        floatingActionButton: new FloatingActionButton(
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritePage()),
            );
          },
          child: new Icon(Icons.favorite),

        ),

      ),
    );
  }
}