import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_dart/firebase_dart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../pdf_upload.dart';
import 'package:path/path.dart' as Path;


class PdfBtn extends StatefulWidget {
  const PdfBtn({Key? key}) : super(key: key);

  @override
  State<PdfBtn> createState() => _PdfBtnState();
}

class _PdfBtnState extends State<PdfBtn> {
  UploadTask?task;
  File?file;
  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if(result == null)return;
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
    print("selected");

    if(file == null) return;

    final fileName =Path.basename(file!.path);
    print(fileName);
    final destitnation = 'files/$fileName';
    FirebaseApi.uploadFile(destitnation,file!);


    String? url = await (await FirebaseApi.uploadFile(destitnation, file!))?.ref.getDownloadURL();
    print(url);

    print("Uploaded");
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
  Widget build(BuildContext context) {
    return
          InkResponse(
              onTap: selectFile,
              child: Icon(Icons.file_copy,size: 30,),);

  }
}
