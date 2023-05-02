import 'package:flutter/material.dart';
import 'package:swms/component/navigator_drawer_widget.dart';

import 'fetch_data.dart';
import 'insert_data.dart';

class AddResourceScreen extends StatelessWidget {
  const AddResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('Resources'),
        // backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              width: 300,
              height: 300,
              image: NetworkImage(
                  'https://seeklogo.com/images/G/google-cloud-logo-ADE788217F-seeklogo.com.png'),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Firebase Realtime Database',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InsertData()));
              },
              child: const Text('Insert Data'),
              color: Colors.blue,
              textColor: Colors.white,
              minWidth: 300,
              height: 40,
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
