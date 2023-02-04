import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dart/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getbloc/getbloc.dart';

import 'package:student/Login/auth_service.dart';
import 'package:student/Login/my_button.dart';
import 'package:student/Login/my_textfield.dart';
import 'package:student/Login/square_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_database/firebase_database.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage ({super.key,required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final userNameController = TextEditingController();


  void signUserUp() async {

    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator(),);
    });
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        showErrorMessage();
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      }
      else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    Map<String,String>dataToSave={
      'name':userNameController.text,
      'email':emailController.text,
      'uid':uid,

    };
    FirebaseFirestore.instance.collection('user').add(dataToSave);



  }

  void wrongEmailMessage() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Incorrect Email"),
      );
    });
  }

  void wrongPasswordMessage() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Incorrect Password"),
      );
    });
  }

  void showErrorMessage() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Passwords don't match"),
      );
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
                const SizedBox(height: 25,),
                Icon(
                  Icons.lock,
                  size: 70,
                ),

                SizedBox(height: 25,),

                Text("Let's create Account for you",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),

                SizedBox(height: 25,),
                MyTextField(controller: userNameController,
                    hintText: 'UserName',
                    obscureText: false),
                SizedBox(height: 10,),

                MyTextField(controller: emailController,
                    hintText: 'Email',
                    obscureText: false),

                SizedBox(height: 10,),

                MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true
                ),

                SizedBox(height: 10,),

                MyTextField(controller: confirmpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true),
                const SizedBox(height: 10,),


                SizedBox(height: 25,),

                MyButton(text: "Sign Up", onTap: signUserUp,),

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
                    SquareTile(onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png'),

                    const SizedBox(width: 25,),

                    SquareTile(
                        onTap:(){},
                        imagePath: 'lib/images/apple.png')
                  ],
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have account?'),
                    const SizedBox(width: 5,),
                    GestureDetector(onTap: widget.onTap,
                        child: Text('Login Now', style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),)),
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