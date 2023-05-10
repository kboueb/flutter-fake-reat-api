import 'dart:async';
import 'dart:convert';

import 'package:api_rest/home-screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final formData = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async{
    try{
      Response response = await post(
          // Uri.parse('https://reqres.in/api/register'),
          Uri.parse('https://reqres.in/api/login'),
          body: {
            'email' : email,
            'password' : password
          }
      );
      
      if(response.statusCode == 200){
        print('Logged In successfully');
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        Timer(const Duration(seconds: 2), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
        });
      }else{
        print('failed');
      }
    }catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.network('images/social-media.png'),
            Icon(Icons.login, color: Colors.white, size: 70,),
            const SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  helperText: 'eve.holt@reqres.in',
                  helperStyle: TextStyle(color: Colors.white),
                  prefixIcon: const Icon(CupertinoIcons.mail),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password',
                  helperText: 'pistol',
                  helperStyle: TextStyle(color: Colors.white),

                  prefixIcon: const Icon(CupertinoIcons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                login(emailController.text.toString(), passwordController.text.toString());
              },

              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.deepOrange
                ),
                alignment: Alignment.center,
                height: 50,
                // color: Colors.blueGrey,
                child: const Center(
                  child: Text('Log In', style: TextStyle(color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
