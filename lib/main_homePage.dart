import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getbloc/getbloc.dart';
import 'package:student/Login/my_button.dart';
import 'package:student/Login/my_textfield.dart';
import 'dart:io';

import 'package:student/btn2.dart';
import 'package:student/pdf_upload.dart';
import 'package:path/path.dart' as Path;




enum type_of_zerox {singleside,doubleside}
class MainHomePage extends StatefulWidget {
   const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  final idController = TextEditingController();
  final nameController = TextEditingController();
  String? mtoken = " ";

  type_of_zerox?_typezerox;
  String value = "";
  UploadTask?task;
  File?file;
  String ?url;
  String?realfilename;


  saveData() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    String uid = auth.currentUser!.uid.toString();
    if (idController == "" || nameController == "") {
      Fluttertoast.showToast(
          msg: "Please Fill All Details ",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0
      );
      return;
    }

    Map<String, String>dataToSave = {
      'name': nameController.text,
      'ID': idController.text,
      'uid': uid,
      'Type_of_zerox': value.toString(),
      'FileLink': url.toString(),
      'filename': realfilename.toString(),
      'Day': DateTime
          .now()
          .day
          .toString(),
      'Month': DateTime
          .now()
          .month
          .toString(),
      'year': DateTime
          .now()
          .year
          .toString(),
      'token': mtoken.toString()
    };
    FirebaseFirestore.instance.collection('pdf').add(dataToSave);
    Fluttertoast.showToast(
        msg: "PDF Sent Succesfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(() {
            mtoken = token;
          });
        });
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(
        color: Colors.black,
      ),);
    });
    if (result == null) return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
    print("selected");

    if (file == null) return;

    final fileName = Path.basename(file!.path);
    print(fileName);
    realfilename = fileName;
    final destitnation = 'files/$fileName';
    FirebaseApi.uploadFile(destitnation, file!);
    url = await (await FirebaseApi.uploadFile(destitnation, file!))?.ref
        .getDownloadURL();
    print(url);
    print("Uploaded");
    Navigator.of(context).pop();

    Fluttertoast.showToast(
        msg: "PDF Uploaded Successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }
  double screenWidth= 0;
  double screenHeigth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeigth = MediaQuery.of(context).size.height;
    final fileName = file != null ? Path.basename(file!.path) : 'No File Selected';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text("Welcome To Home Page"),
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 30, fontFamily: 'Times New Roman'),
      ),
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(height: 40,),
              Text("Fill Details To Print ", style: TextStyle(
                  fontFamily: 'Times New Roman',
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700]),),
              SizedBox(height: 40,),

              MyTextField(controller: nameController,
                  hintText: "Name",
                  obscureText: false),
              SizedBox(height: 20,),
              MyTextField(
                  controller: idController, hintText: "ID", obscureText: false),
              SizedBox(height: 30,),
              Row(

                children: [

                  Expanded(child: RadioListTile(

                      activeColor: Colors.black,
                      value: type_of_zerox.singleside,
                      groupValue: _typezerox,
                      title: Text("Single Side"
                        , style: TextStyle(
                            fontFamily: 'Times New Roman', fontSize: 20),
                      ),
                      onChanged: (val) {
                        setState(() {
                          _typezerox = val;
                          value = "Single Side";
                        });
                      }),),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RadioListTile(
                        contentPadding: EdgeInsets.all(0.0),
                        activeColor: Colors.black,
                        value: type_of_zerox.doubleside,
                        groupValue: _typezerox,
                        title: Text("Double Side", style: TextStyle(
                            fontFamily: 'Times New Roman', fontSize: 20),),
                        onChanged: (val) {
                          setState(() {
                            value = "Double Side";
                            _typezerox = val;
                          });
                        }),
                  ),)
                ],
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(

                  children: [
                    Text("Upload PDF To Print",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Times New Roman"

                      ),
                    ),

                    SizedBox(width: 80,),

                    // PdfBtn(),
                    InkResponse(
                      onTap: selectFile,
                      child: Icon(Icons.file_copy, size: 30,),)

                  ],
                ),
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Selected FileName : ",style: TextStyle(fontFamily: "Times New Roman",fontSize: 25),)
                ],
              ),
              SizedBox(height: 20,),
              FittedBox(
                  fit: BoxFit.fitWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(fileName,style: TextStyle(fontSize: 20,fontFamily: "Times New Roman"),
                    )
                  ],
                ),
              ),
              SizedBox(height: 40,),

              MyButton1(onTap: saveData, text: "Print PDF")

            ],
          ),
        ),
      ),
    );
  }
}

