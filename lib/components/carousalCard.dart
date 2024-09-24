import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_food_app/service/databaseService.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Carousalcard extends StatefulWidget {
  const Carousalcard({super.key});

  @override
  State<Carousalcard> createState() => _CarousalcardState();
}

List<String> CarousalImages = [
  "assets/cart1.jpg","assets/cart2.jpg","assets/cart3.jpg","assets/cart4.jpg","assets/cart5.jpg","assets/cart6.jpg"
];

final DataBaseService _dataBaseService = DataBaseService.instance;

class _CarousalcardState extends State<Carousalcard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CarouselSlider(
          items: [
            "assets/cart1.jpg","assets/cart2.jpg","assets/cart3.jpg","assets/cart4.jpg","assets/cart5.jpg","assets/cart6.jpg"
          ].map((i){
            return Card(
                elevation: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.transparent,
                    image: DecorationImage(image: AssetImage(i),fit: BoxFit.cover)
                  ),
                ),
            );
          }).toList(),
          options: CarouselOptions(height: 175, autoPlay: true)
        ),
      ),
    );
  }
}


//Product Card
class ProductCard extends StatefulWidget {

  final String productName;
  final String price;
  final String rating;
  final String image;
  Function addtocart;

  ProductCard({super.key, required this.productName, required this.price, required this.rating, required this.image, required this.addtocart});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>{

  bool dontslide = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.tealAccent,
              Colors.blue,
            ],
          ),

          borderRadius: BorderRadius.circular(15),
          // color: Colors.teal[300],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image(image: NetworkImage(widget.image), fit: BoxFit.cover, height: 140, width: double.infinity,),
                )
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Text(widget.productName,
                    overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                  ),

                  //Price and Rating row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(" ₹${widget.price}",
                      style:TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.limeAccent
                      ),),

                      //Rating Row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Icon(Icons.star_rate_rounded, color: Colors.amberAccent, size: 20,),
                          ),
                          Text("${widget.rating}  ", style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            // SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SlideAction(
                height: 40,
                elevation: 0,
                enabled: dontslide? false:true,
                innerColor: Colors.pinkAccent,
                outerColor: Colors.white,
                sliderButtonIconSize: 18,
               sliderButtonIconPadding: 8,
               sliderButtonYOffset: -5,
               submittedIcon: Icon(Icons.check, color: Colors.pinkAccent,),
                borderRadius: 15,
                sliderRotate: false,
                text: dontslide? "          Item Added":"          Add to Cart",
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                onSubmit: (){
                  setState(() {
                    dontslide = true;
                  });
                  widget.addtocart();
                  /*_dataBaseService.addproduct(widget.productName, widget.price);*/
                }

              ),
            )

          ],
        ),
      ),
    );
  }
}

