import 'package:flutter/material.dart';

import '../pages/home.dart';

class RecipeCard extends StatelessWidget {

  final String cardName;
  final String cardImage;
  final Function ontap;
  RecipeCard({required this.cardName, required this.cardImage, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        child: GestureDetector(
          onTap: () {
            ontap();
          },
        child: Container(
          height: 180,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                offset: const Offset(
                  0.0,
                  8.0,
                ),
                blurRadius: 10.0,
                spreadRadius: -8.0,
              ),
            ],
            image: DecorationImage(
                image: NetworkImage(cardImage),
                colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.multiply),
                fit: BoxFit.cover
            ),

          ),
          child: Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                  child: Text(cardName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      overflow: TextOverflow.clip,

                    )
                    ,),
                )
              ],
            ),
          ),

        ),
            ),
      )
    );
  }
}

class CategoryCard extends StatelessWidget {

  final String cardName;
  final Icon icon;
  final Color color;

  CategoryCard({super.key, required this.cardName, required this.icon, required this.color, });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        width:  90,
        child: Card(
          color: color,
          shadowColor: Colors.white70,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                icon,
                SizedBox(height: 10,),
                Center(child: Text(
                  cardName,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                    fontSize: 14
                  ),

                )
                )
              ],
            ),
          ),
        ),
      );
  }
}


