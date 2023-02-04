import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Read Data/get_user_name.dart';

class ShowAllData extends StatefulWidget {
  const ShowAllData({Key? key}) : super(key: key);

  @override
  State<ShowAllData> createState() => _ShowAllDataState();
}

class _ShowAllDataState extends State<ShowAllData> {
  final user= FirebaseAuth.instance.currentUser!;
  final currentUser = FirebaseAuth.instance;
  List<String>docId=[];

  Future getDocId() async{
    await FirebaseFirestore.instance.collection('user').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        print(document.reference);
        docId.add(document.reference.id);
      }),
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocId(),
                builder: (context,snapshot){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount:docId.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: GetUserName(documentId: docId[index],),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
