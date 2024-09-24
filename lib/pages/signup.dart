import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:new_food_app/constants/apiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool passwordVisible = false;

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
        Navigator.popAndPushNamed(context, '/shopping');
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
      backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(

              children: [
                SizedBox(height: 20,),
                Container(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                            onPressed: (){
                              setState(() {
                                isLoginOrSignup = true;
                              });
                            }, child: Text("Login",
                        style: TextStyle(
                          fontSize: 30,
                            color: isLoginOrSignup ? Colors.amber : Colors.grey

                        ),)),

                        TextButton(
                            onPressed: (){
                              setState(() {
                                isLoginOrSignup = false;
                              });
                            }, child: Text("Sign Up",
                          style: TextStyle(
                              fontSize: 30,
                            color: isLoginOrSignup ? Colors.grey : Colors.amber
                          ),)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 60,),

                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
                  },
                  cursorColor: Colors.amber,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20
                  ),
                  decoration: InputDecoration(
                      // hintText: "E-mail",
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color:Colors.amber,
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 2),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    prefixIcon: Icon(Icons.email)
                  ),
                ),

                SizedBox(height: 28),
                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Colors.amber,
                  obscureText: passwordVisible? false:true,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color:Colors.amber,
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber, width: 2),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                          child: passwordVisible? Icon(CupertinoIcons.eye_slash_fill):Icon(Icons.remove_red_eye),
                      onTap: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                      }
                      )
                  ),
                ),
                GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Forgot Password?  ",
                        textAlign: TextAlign.end,),
                    )
                ),
                // SizedBox(height: 10),

                isLoginOrSignup ? SizedBox(height: 0,) : SizedBox(height: 10,),
                isLoginOrSignup ? Text("") : TextFormField(
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.amber,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                    decoration: InputDecoration(
                      labelText: "Phone number",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color:Colors.amber,
                      ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber, width: 2),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        prefixIcon: Icon(Icons.phone),

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
                    child:Center(child: loader?
                    SpinKitThreeBounce(color: Colors.amberAccent[100], size: 40,)
                        : Text(isLoginOrSignup?"Login":"Sign Up",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                    )
                    ),
                  ),
                ),
                TextButton(onPressed: () async {
                  final pref = await SharedPreferences.getInstance();
                  pref.setBool('showHome', false);
                }, child: Text("Press to have onboarding screen")),

                SizedBox(height: 10,),

                Center(child:
                Text("------------ OR ------------",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey
                ),)),

                SizedBox(height: 30,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/search.png"), height: 45,),
                    Image(image: AssetImage("assets/facebook.png"), height: 45,),
                    Image(image: AssetImage("assets/twitter.png"), height: 45,)
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }

}
