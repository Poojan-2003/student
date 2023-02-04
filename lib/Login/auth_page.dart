import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getbloc/getbloc.dart';
import 'package:student/Login/login_or_register.dart';

import '../home_page.dart';
import 'LoginPage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){return HomePage();}
          else return LoginOrRegisterPage();
        },
      ),
    );
  }
}
