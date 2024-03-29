import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetUserName extends StatelessWidget {
 final String documentId;
 GetUserName({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
        future:users.doc(documentId).get(),
        builder: ((context,snapshot){
      if(snapshot.connectionState == ConnectionState.done){
        Map<String , dynamic>data = 
            snapshot.data!.data() as Map<String,dynamic>;
        return Text('First Name : ${data['email']}');

      }
      return Text("loading");
    }));
  }
}
