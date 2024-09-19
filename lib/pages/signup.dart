import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:new_food_app/constants/apiConstant.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loader = false;
  bool isLoginOrSignup = false;

  void loginFun(String email, String password) async{
    setState(() {
      loader = true;
    });
    try{
      Response signupResponse =
      await post(Uri.parse(isLoginOrSignup ? ApiConstant.loginUrl : ApiConstant.registerUrl),
      body: {
        "email" : email,
        "password" : password
      }
      );
      if(signupResponse.statusCode == 200){
        print("registered successfully");
        var signupData = jsonDecode(signupResponse.body.toString());
        print(signupData);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        var signupData = jsonDecode(signupResponse.body.toString());
        print(signupData);
        print('registered unsuccessfully');
      }
    } catch(e) {
      print(e.toString());
    } finally{
      setState(() {
        loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: (){
                            setState(() {
                              isLoginOrSignup = true;
                            });
                          }, child: Text("Login")),
                      TextButton(
                          onPressed: (){
                            setState(() {
                              isLoginOrSignup = false;
                            });
                          }, child: Text("Sign Up")),
                    ],
                  ),
                ),

                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "E-mail"
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: "Password"
                  ),
                ),
                isLoginOrSignup ? SizedBox(height: 0,) : SizedBox(height: 20,),
                isLoginOrSignup ? Text("") : TextFormField(
                  decoration: InputDecoration(
                      hintText: "Phone Number"
                  ),
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    loginFun(emailController.text.toString(),
                        passwordController.text.toString());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child:Center(child: loader? SpinKitThreeBounce(color: Colors.amberAccent[100], size: 40,): Text(isLoginOrSignup?"Login":"Sign Up" )),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}
