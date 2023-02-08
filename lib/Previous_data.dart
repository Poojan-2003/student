import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousDATA extends StatefulWidget {
  const PreviousDATA({Key? key}) : super(key: key);

  @override
  State<PreviousDATA> createState() => _PreviousDATAState();
}

class _PreviousDATAState extends State<PreviousDATA> {
  String uid ="";
  view_data(){
    FirebaseAuth auth = FirebaseAuth.instance;
    uid = auth.currentUser!.uid.toString();
  }
  // Uri ?url;

  _launchUrl(String url) async{
    // print(url);
    // Uri uri = url as Uri;
    var urlf= Uri.parse(url);
    // var urlf = Uri.parse("https://www.geeksforgeeks.org/");
    if(await canLaunchUrl(urlf)){
      await launchUrl(urlf,mode: LaunchMode.externalApplication);
    }else {
     throw 'could not launch';
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view_data();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(

        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('pdf')
                .where('uid', isEqualTo: uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, i) {
                      var data = snapshot.data!.docs[i];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 40,),
                             
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("FileName : ",style: TextStyle(fontSize: 25,fontFamily: 'Times New Roman'),),
                                    Text(data['filename'],style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman')),

                                  ],
                                ),
                              ),
                                  SizedBox(height: 10,),
                               TextButton.icon(
                                 onPressed: ()async{_launchUrl(data['FileLink']);},
                                 icon: Icon(Icons.download,size: 25,),
                               label: Text("Download File",style: TextStyle(fontSize: 20),),

                               ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Date Of Printing :",style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman')),
                                    Text(data['Day'],style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman')),
                                    Text("-"),
                                    Text(data['Month'],style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman')),
                                    Text("-"),
                                    Text(data['year'],style: TextStyle(fontSize: 20,fontFamily: 'Times New Roman')),

                                  ],
                                ),
                                SizedBox(height: 10,),

                              Divider(
                                thickness: 1,
                                color: Colors.black,
                                endIndent: 10,
                                indent: 10,
                              )


                            ],
                          ),
                        ),
                      );
                    }
                );
              }
              else return Container(
                child: Center(
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("No Data Found")
                    ],),
                ),
              );
            },
          ),
        ),
      ),
    );

  }

  addnum(int i) {
    i++;
  }
}
