import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../navigator_drawer_widget.dart';

class RealTimeDatabase extends StatelessWidget {
   RealTimeDatabase({Key? key}) : super(key: key);

  final ref = FirebaseDatabase.instance.ref('Bin');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('Time Monitoring'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FirebaseAnimatedList(
                shrinkWrap: true,
                  query: ref,
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
          ],
        ),
      ),
    );
  }
}
