import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student/Login/auth_service.dart';
import 'package:student/Login/my_button.dart';
import 'package:student/Login/my_textfield.dart';
import 'package:student/Login/square_tile.dart';

import 'forget_password.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
   LoginPage ({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(context: context, builder: (context){
      return const Center(child: CircularProgressIndicator(),);
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,password: passwordController.text
      );
      Navigator.pop(context);
    }on FirebaseAuthException catch(e){
      Navigator.pop(context);
      if(e.code == 'user-not-found'){wrongEmailMessage();}
      else if (e.code == 'wrong-password'){
        wrongPasswordMessage();
      }
    }

  }

  void wrongEmailMessage(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("Incorrect Email"),
      );
    });
  }
  void wrongPasswordMessage(){
    showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("Incorrect Password"),
    );
  });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Icon(
                Icons.lock,
                size: 100,
              ),

              SizedBox(height: 40,),

              Text("Welcome back,you\'ve been missed !",
              style: TextStyle(color: Colors.grey[700],fontSize: 16),
              ),

              SizedBox(height: 25,),



              MyTextField(controller: emailController, hintText: 'Email', obscureText: false),

              SizedBox(height: 10,),

              MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true
              ),
              const SizedBox(height: 10,),
               Padding(padding: const EdgeInsets.symmetric(horizontal: 25),child:
                 Row(mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   GestureDetector(
                       onTap:(){
                         Navigator.push(context,
                             MaterialPageRoute(builder: (context){
                               return ForgetPasswordPage();
                             },),);
                       },
                       child: Text("Forgot Password?",style: TextStyle(color: Colors.grey[600]),)),
                 ],),),

              SizedBox(height: 25,),

              MyButton(text:"Sign In",onTap: signUserIn,),

              SizedBox(height: 50,),

              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text('or continue with',
                      style: TextStyle(color: Colors.grey[700]),),
                    ),
                    Expanded(child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ))
                  ],
                ),
              ),
              const SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(onTap:() => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png'),

                  const SizedBox(width: 25,),

                  SquareTile(onTap: (){},
                      imagePath: 'lib/images/apple.png')
                ],
              ),
              const SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a Member ?'),
                  const SizedBox(width: 4,),
                  GestureDetector(onTap:widget.onTap,child: Text('Register Now',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)),
                ],
              )
            ],
        ),
          ),
      ),
    ),
    );
  }
}
