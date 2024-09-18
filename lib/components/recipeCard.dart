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
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                  )
                  ,),
              )
            ],
          ),
        ),

      ),
    )
    );
  }
}

