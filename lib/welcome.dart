import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class welcome extends StatefulWidget {

  @override
  State<welcome> createState() => _welcomeState();
}

class _welcomeState extends State<welcome> {

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Food recipe',
    theme: ThemeData(
      primarySwatch: Colors.green,
      primaryColor: Colors.white,

    ),
      home: Scaffold(
       body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              SizedBox(height: 90,),
              Image.asset('assets/images/Recipe.png'),
              Text("Welcome to Recipes",style:TextStyle(fontWeight:FontWeight.bold,fontSize:28)),
              Text("Start making your dishes with our Recipes",
              style:TextStyle(fontSize:20) ),
              SizedBox(height: 15,),
              FlatButton(
              child: Text(" Start ",style: TextStyle(fontSize: 30,color: Colors.white),),
              color:Colors.green.shade400,
              minWidth: 50,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
              onPressed:(){ Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => home()),
                                            );}
            ),
              

            ],
          ),
        ),
      )
  );
  }
}
