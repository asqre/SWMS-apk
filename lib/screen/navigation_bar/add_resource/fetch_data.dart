import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:swms/screen/add_resource/update_record.dart';

class FetchData extends StatefulWidget {
  FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Bin');

  DatabaseReference reference = FirebaseDatabase.instance.ref().child('Students');

  Widget listItem ({required Map student}){
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 110,
      color: Colors.amberAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            student['name'],
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5,),
          Text(
            student['age'],
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5,),
          Text(
            student['salary'],
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      UpdateRecord(studentKey: student['key'])));
                },child: Row(
                children: [
                  Icon(Icons.edit,color: Theme.of(context).primaryColor,)
                ],
              ),
              ),
              const SizedBox(width: 6,),
              GestureDetector(
                onTap: (){
                  reference.child(student['key']).remove();
                },
                child: Row(
                  children: [
                    Icon(Icons.delete,
                    color: Colors.red[700],)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

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
