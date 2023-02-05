import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();

  void dispose(){
    emailController.dispose();
    super.dispose();
  }
 Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

      showDialog(
          context:context,
          builder:(context){
            return AlertDialog(
              content: Text("Password Reset Link has been sent to your email ! Check you email"),
            );
          }
      );
    }on FirebaseAuthException catch(e){
      print(e);
      showDialog(
        context:context,
        builder:(context){
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        }
      );
    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text("Enter Your Email and we will send you password reset link",
            textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),

          ),
            SizedBox(height: 10,),
            Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: TextField(
          controller: emailController,
          
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),

            ),
            fillColor:Colors.grey.shade200,
            filled: true,
            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.grey[500]),
          ),
        ),
      ),
          SizedBox(height: 10,),
          MaterialButton(onPressed: passwordReset,child: Text('Reset Password',style: TextStyle(color: Colors.white),),color: Colors.black,)
        ],
      )
    );
  }
}
