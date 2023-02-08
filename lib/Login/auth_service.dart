

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;


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

signInWithApple() async{
  FirebaseAuth auth = FirebaseAuth.instance;
  var redirectURL = "https://SERVER_AS_PER_THE_DOCS.glitch.me/callbacks/sign_in_with_apple";
  var clientID = "https://zeroxapp-d0699.firebaseapp.com/__/auth/handler";

  final  credential = await SignInWithApple.getAppleIDCredential(scopes: [
    AppleIDAuthorizationScopes.email,
    AppleIDAuthorizationScopes.fullName,
  ],
      webAuthenticationOptions: WebAuthenticationOptions(
          clientId: clientID,
          redirectUri: Uri.parse(
              redirectURL)));
  print(credential);
  final signInWithAppleEndpoint = Uri(
    scheme: 'https',
    host: 'flutter-sign-in-with-apple-example.glitch.me',
    path: '/sign_in_with_apple',
    queryParameters: <String, String>{
      'code': credential.authorizationCode,
      if (credential.givenName != null)
        'firstName': credential.givenName!,
      if (credential.familyName != null)
        'lastName': credential.familyName!,
      'useBundleId':
      !kIsWeb && (Platform.isIOS || Platform.isMacOS)
          ? 'true'
          : 'false',

      if (credential.state != null) 'state': credential.state!,
    },
  );

  final session = await http.Client().post(
    signInWithAppleEndpoint,
  );
}


}








