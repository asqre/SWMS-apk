import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';



class FetchData extends StatefulWidget {
  FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Bin');


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetching data'),
      ),
      body: Container(
        height: double.infinity,
        child: FirebaseAnimatedList(
            shrinkWrap: true,
            query: dbRef,
            defaultChild: Center(child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 10,),
                Text('Loading..'),
              ],
            ),),
            itemBuilder: (context, snapshot, animation, index){
              return ListTile(
                title:  Text(snapshot.child('id').value.toString()),
                subtitle: Text(snapshot.child('height').value.toString()),
              );
            }),
      ),
    );
  }
}
