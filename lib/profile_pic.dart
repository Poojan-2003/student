import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key}) : super(key: key);

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {

  String imageUrl = " ";
  void pickUploadImage()async{
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality:75,
    );
    Reference ref1 = FirebaseStorage.instance.ref().child("profilepic.jpeg");
    await ref1.putFile(File(image!.path));
    ref1.getDownloadURL().then((value){
      print(value);
      setState(() {
        imageUrl = value;
      });
    });
  }
  double screenWidth= 0;

  @override
  Widget build(BuildContext context) {
   return SizedBox(

     width: 400,
     height: 200,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [

         GestureDetector(
           onTap: (){
             pickUploadImage();
           },
           child: Container(

             decoration: BoxDecoration(


             ),
             child: Center(
               child: imageUrl == " " ? Icon(Icons.account_circle,size: 125,color: Colors.grey[700],)
                   : Image.network(imageUrl),
             ),
           ),
         ),



       ],
     ),
   );
  }
}
