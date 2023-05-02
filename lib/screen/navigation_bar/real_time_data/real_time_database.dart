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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
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
                    return Row(
                      children: [
                        GarbageLevel(containerHeight: containerHeight(snapshot), filledHeight: filledHeight(snapshot)),
                        // SizedBox(height: 10,width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.72,
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
    double ans = double.parse(snapshot.child('capcity').value.toString());
    return ans;
  }

  double filledHeight(DataSnapshot snapshot) {
    double ans = double.parse(snapshot.child('height').value.toString());
    ans = containerHeight(snapshot)-ans;
    if(ans<0){
      ans=0;
    }
    return ans;
  }
}



