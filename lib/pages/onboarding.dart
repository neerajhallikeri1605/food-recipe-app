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
                color: Colors.redAccent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/food-onboarding.png"), height: 300,),
                      SizedBox(height: 20,),
                      Text("Page 1 ", style: TextStyle(
                          fontSize: 30
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.blueAccent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/chef-onboarding.png"), height: 300,),
                      SizedBox(height: 20,),
                      Text("Page 2 ", style: TextStyle(
                          fontSize: 30
                      ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.greenAccent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(image: AssetImage("assets/serve-onboarding.png"), height: 300,),
                      SizedBox(height: 20,),
                      Text("Page 3 ", style: TextStyle(
                          fontSize: 30
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

              // final pref = await SharedPreferences.getInstance();
              // pref.setBool('showHome', true);

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


