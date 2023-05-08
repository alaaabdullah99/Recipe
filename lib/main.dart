import 'package:flutter/material.dart';
import 'package:recipe/home.dart';
import 'package:recipe/provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe/welcome.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteProvider(),
      child:  MaterialApp(
        title: 'Recipe',
        home: welcome(),
      ),
    );
  }
}