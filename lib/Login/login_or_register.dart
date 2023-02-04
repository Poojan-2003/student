import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:student/Login/register_page.dart';

import 'LoginPage.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({Key? key}) : super(key: key);

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
 bool showLoginPage = true;

 void tooglePages(){
   setState(() {
     showLoginPage =! showLoginPage;
   });
 }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        onTap : tooglePages,
      );
    }else {
      return RegisterPage(
        onTap:tooglePages,
      );
    }
  }
}
