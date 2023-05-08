import 'package:flutter/material.dart';
import 'package:recipe/provider/favorite_provider.dart';

import 'Details.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteList = provider.favoriteList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          final fav = favoriteList[index];
          return Container(

            child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Image.network(fav.image,
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
                      Text("5",style: TextStyle(fontSize: 20),),
                      SizedBox(width: 100,),

                      MaterialButton(child:provider.isExist(fav)
                          ? const Icon(Icons.delete, color: Colors.redAccent)
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
                            MaterialPageRoute(builder: (context) => Details(recipe: fav,)),
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
              color:Colors.grey.shade200,
            ),

          );

        },
      ),
    );
  }
}