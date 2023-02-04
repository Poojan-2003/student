import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:student/Login/auth_page.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',


  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp ({super.key});
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}


