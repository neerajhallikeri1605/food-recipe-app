import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Recipeinfocard extends StatelessWidget {


  String image1;
  String cardText;
  String suffixText;

  Recipeinfocard({super.key, required this.image1, required this.cardText, required this.suffixText});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white,
          shadowColor: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage(image1), height: 50,),
                SizedBox(height: 10,),
                Center(child: Text('$cardText\n$suffixText', textAlign: TextAlign.center,))
              ],
            ),
          ),


      ),
    );
  }
}
