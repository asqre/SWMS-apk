import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swms/component/garbage_bin_level.dart';
import '../../../component/navigator_drawer_widget.dart';


class RealTimeDatabase extends StatelessWidget {
  RealTimeDatabase({Key? key}) : super(key: key);

  final ref = FirebaseDatabase.instance.ref('Bin');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('Time Monitoring'),
        // backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10,right: 10,left: 10),
        child: Column(
          children: [
            Testing(),
            Expanded(
              child: FirebaseAnimatedList(
                  shrinkWrap: true,
                  query: ref,
                  defaultChild: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Loading..'),
                      ],
                    ),
                  ),
                  itemBuilder: (context, snapshot, animation, index) {
                    return
                      Row(
                      children: [
                        GarbageLevel(containerHeight: containerHeight(snapshot), filledHeight: filledHeight(snapshot)),
                        // SizedBox(height: 10,width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.70,
                            height: 120,
                            child:  Card(
                              color: Colors.yellow,
                              child: ListTile(
                                leading: Icon(
                                  CupertinoIcons.trash,
                                  color: (percentageFilled(snapshot) == 100) ? Colors.red : Colors.green,
                                ),
                                title: Text('Dustbin : ${index + 1}'),
                                subtitle:
                                Text(filledHeight(snapshot).toString()),
                                trailing: Text(
                                  '${percentageFilled(snapshot).toStringAsFixed(2)}%',
                                  style: TextStyle(color: (percentageFilled(snapshot) == 100) ? Colors.red : Colors.green,),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  double percentageFilled(DataSnapshot snapshot) {
    double ans = filledHeight(snapshot) / containerHeight(snapshot)  * 100;
    return ans;
  }

  double containerHeight(DataSnapshot snapshot) {
    String capacity = snapshot.child('capcity').value.toString();
    double ans =0;
    if(capacity.isEmpty){
      ans = 19;
    }else{
      ans = double.parse(capacity);
    }
    return ans;
  }

  double filledHeight(DataSnapshot snapshot) {
    String height = snapshot.child('height').value.toString();
    double ans =0;
    if(height.isNotEmpty){
      ans =double.parse(height);
    }
    ans = containerHeight(snapshot)-ans;
    if(ans<0){
      ans=0;
    }
    return ans;
  }


}



class Testing extends StatelessWidget {
  Testing({Key? key}) : super(key: key);

  final ref = FirebaseDatabase.instance.ref();
  double FilledHeight = 18;

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
        shrinkWrap: true,
        query: ref,
        itemBuilder: (context, snapshot, animation, index) {
          if(snapshot.child('Distance').value.toString() != 'null'){
            FilledHeight = double.parse(snapshot.child('Distance').value.toString());
            if(FilledHeight > 18){
              FilledHeight = 18;
            }
          }
          return (snapshot.child('Distance').value.toString() != 'null') ?
            Row(
            children: [
              GarbageLevel(containerHeight: 18, filledHeight:  filledDistance(snapshot)),
              // SizedBox(height: 10,width: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  height: 120,
                  child:  Card(
                    color: Colors.blue.shade100,
                    child: ListTile(
                      leading: Icon(
                        CupertinoIcons.trash,
                        color: (percentageFilled(snapshot) == 100) ? Colors.red : Colors.green,
                      ),
                      title: Text('Dustbin : Testing'),
                      subtitle:
                      Text(filledDistance(snapshot).toString()),
                      trailing: Text(
                        '${percentageFilled(snapshot).toStringAsFixed(2)}%',
                        style: TextStyle(color: (percentageFilled(snapshot) == 100) ? Colors.red : Colors.green,),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ) : Text('');
        },);
  }

  double percentageFilled(DataSnapshot snapshot) {
    double ans = filledDistance(snapshot) / containerDistance(snapshot)  * 100;
    return ans;
  }

  double containerDistance(DataSnapshot snapshot) {
    double ans =18;
    return ans;
  }

  double filledDistance(DataSnapshot snapshot) {
    double FilledHeight = double.parse(snapshot.child('Distance').value.toString());
    FilledHeight = containerDistance(snapshot)- FilledHeight;
    if(FilledHeight < 0){
      FilledHeight = 0;
    }
    return FilledHeight;
  }


}


