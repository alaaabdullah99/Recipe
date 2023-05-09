import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe/models/instruction.dart';
import 'home.dart';

class Details extends StatefulWidget {
  final Recipe recipe;
   Details({Key?key,required this.recipe});



  @override
  State<Details> createState() => _DetailsState();

}
class _DetailsState extends State<Details> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        //now you have passing variable
        title: Text("Details"),
    ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
         Stack(
           children: [
             Container(
               margin:EdgeInsets.fromLTRB(15,15,15,0) ,
               width: 450,
               height: 150.9,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(20),
                   image: DecorationImage(
                   image: NetworkImage(widget.recipe.image),
                   fit: BoxFit.cover,),
               ),
             ),
           ],
         ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0,0),
              child: Text(
                widget.recipe.name,
                textAlign:TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                        color: Colors.lightBlue.shade50,),
                        padding:EdgeInsets.fromLTRB(10,10,10,10) ,
                        margin:EdgeInsets.fromLTRB(10,10,10,0) ,
                        height: 80,width: 90,
                    child:Column(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Color(0xFF4A7EB4),
                          size: 30,),
                        Text(widget.recipe.time.toString()+" MIN",
                          style: TextStyle( color: Color(0xFF4A7EB4),fontSize: 20),),

                      ],
                    )),

                Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: Colors.yellow.shade100,),
                    padding:EdgeInsets.fromLTRB(10,10,10,10) ,
                    margin:EdgeInsets.fromLTRB(10,10,10,0) ,
                    height: 80,width: 90,
                    child:Column(
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Colors.amber,
                          size: 30,),
                        Text("2",
                          style: TextStyle(color: Colors.amber,fontSize: 25),),
                      ],
                    )),

                Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: Colors.red.shade50,),
                    padding:EdgeInsets.fromLTRB(10,10,10,10) ,
                    margin:EdgeInsets.fromLTRB(10,10,10,0) ,
                    height: 80,width: 90,
                    child:Column(
                      children: [
                        Icon(
                          Icons.people,
                          color: Color(0xFFEB275B),
                          size: 30,),
                        Text(widget.recipe.personNum.toString(),
                          style: TextStyle(color: Color(0xFFEB275B),fontSize: 25),),
                      ],
                    )),

              ],
            ),

             Align(
              alignment: AlignmentDirectional(-0.91, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
                child: Text(
                  'Description',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
             Align(
              alignment: AlignmentDirectional(-0.65, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 15, 0, 15),
                child: Text(
                  widget.recipe.description,
                  style: TextStyle(fontSize: 20,color: Colors.grey ),
                ),
              ),
            ),
             Align(
              alignment: AlignmentDirectional(-0.9, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10,0, 0, 0),
                child: Text(
                  'Instruction',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.recipe.instructions.length,
              itemBuilder: (BuildContext context, int index){
                return  Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF4DAA78),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10, 10, 10, 10),
                            child: Text(
                              widget.recipe.instructions[index].stepNum.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                          child: Text(
                            widget.recipe.instructions[index].text.toString(),
                            style: TextStyle(fontSize: 20),),)

                    ],
                  ),
                );
              }

            ),
    ],

        ),
      ),
    );
  }
}
