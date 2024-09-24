import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

final controller = PageController();
bool isLastPage = false;

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(()=> isLastPage = index == 2);
            },
            children: [
              Container(
                color: Colors.blueGrey[300],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(image: AssetImage("assets/shoppingGirl.jpg"), height: 300,)),
                      SizedBox(height: 20,),
                      Text("Shopping", style: TextStyle(
                          fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.deepPurpleAccent[100],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(image: AssetImage("assets/deliveryBoy.jpg"), height: 300,)),
                      SizedBox(height: 20,),
                      Text("Delivery", style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.blueGrey[300],
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(image: AssetImage("assets/cookingGirl.jpg"), height: 300,)),
                      SizedBox(height: 20,),
                      Text("Cooking", style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: SafeArea(
        child: Container(
          height: 80,
          // color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: isLastPage?
            TextButton(onPressed: () async{

              final pref = await SharedPreferences.getInstance();
              pref.setBool('showHome', true);

                Navigator.pushReplacementNamed(context, '/signup');
            },
              style: ButtonStyle(
                  backgroundColor : WidgetStatePropertyAll<Color>(Colors.amber),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.amberAccent, width: 3)
                )
              ),

              ),
              child: Text("Get Started",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black
                ),
              ),
            ) : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed:(){
                  controller.jumpToPage(2);
                }, child: Text(
                  "Skip",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),
                ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const SwapEffect(
                        type: SwapType.yRotation,
                        dotColor: Colors.black,
                        activeDotColor: Colors.amber),
                    onDotClicked: (index)=> controller.animateToPage(
                        index,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.easeInOutCubicEmphasized
                    ),

                  ),
                ),
                TextButton(onPressed: (){
                  controller.nextPage(duration: Duration(milliseconds: 1500), curve: Curves.easeInOutCubicEmphasized);
                }, child: Text("Next",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),
                ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


