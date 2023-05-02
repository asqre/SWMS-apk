import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swms/component/garbage_bin_level.dart';
import 'package:swms/screen/navigation_bar/add_resource/update_record.dart';

import '../../component/navigator_drawer_widget.dart';
import 'add_resource/fetch_data.dart';

class ViewDataScreen extends StatelessWidget {
  const ViewDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('View Data',style: TextStyle(color: Colors.white),),
        // backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.network('https://seeklogo.com/images/S/supabase-logo-DCC676FFE2-seeklogo.com.png')
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FetchData()));
                },
                child: const Text('Fetch Data'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),

              SizedBox(height:  20,),

              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UpdateRecord(dustbinKey: '-NUHu6eYFWuZL8BIuWab')));
                },
                child: const Text('Update Record'),
                color: Colors.blue,
                textColor: Colors.white,
                minWidth: 300,
                height: 40,
              ),
            ],
          ),
        ),
      )
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ref = FirebaseDatabase.instance.ref('Distance');



  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ref.onValue,
        builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            Map<dynamic, dynamic> map = snapshot.data!.snapshot
                .value as dynamic;
            return ListView.builder(
                itemCount: snapshot.data!.snapshot.children.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('ASDFS'),
                  );
                });
          }
        });
  }
}
