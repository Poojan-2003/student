import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dart/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:student/Read%20Data/get_user_name.dart';
import 'package:student/btn2.dart';
import 'package:student/profile_pic.dart';


import 'Login/my_button.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;


  Future<void> signUserOut() async {

    final googleCurrentUser =
        GoogleSignIn().currentUser ;
    if (googleCurrentUser != null){
      await GoogleSignIn().signOut();
      await GoogleSignIn().disconnect();}
    await FirebaseAuth.instance.signOut();
  }


double screenWidth= 0;
  double screenHeigth = 0;


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text("Profile Page"),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 35, fontFamily: 'Times New Roman'),
      ),
      body: SingleChildScrollView(
        child: Column(

          children: [
            SizedBox(
              height: 50,
            ),
            Column(
              children: [
                ProfilePic(),
              ],
            ),
            SizedBox(height: 50,),
            ListTile(
              leading: Icon(
                Icons.person_outline,
                size: 30,
                color: Colors.grey[700],
              ),
              title:Text('Name' ,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.bold,fontFamily: 'Times New Roman'),),
                trailing:Text(user.displayName.toString(),style: TextStyle(color: Colors.grey[700],fontSize: 17,fontFamily: 'Times New Roman'),),

            ),
            Divider(
              color: Colors.grey[700],
              thickness: 1,
              endIndent: 10,
              indent: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.email_outlined,
                size: 30,
                color: Colors.black,

              ),
                title: Text('Email ' ,style: TextStyle(color: Colors.grey[700],fontSize: 20,fontWeight:FontWeight.bold,fontFamily: 'Times New Roman'),),
                trailing: Text(user.email.toString(),style: TextStyle(color: Colors.grey[700],fontSize: 17,fontFamily: 'Times New Roman'),),

            ),
            SizedBox(height: 200,),
            MyButton1(onTap: signUserOut, text: "Sign Out")
          ],

        ),

        ),
      );


  }
}


