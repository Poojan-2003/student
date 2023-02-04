import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async{
    final GoogleSignInAccount ? gUser = await GoogleSignIn(
        scopes:<String>["email"]).signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );
    FirebaseAuth auth = FirebaseAuth.instance;
    final UserCredential userCredential = await auth.signInWithCredential(credential);
    User? user = userCredential.user;


    return await FirebaseAuth.instance.signInWithCredential(credential);
  }




}




