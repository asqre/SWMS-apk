import 'package:flutter/material.dart';

import '../component/navigator_drawer_widget.dart';

class ViewDataScreen extends StatelessWidget {
  const ViewDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('View Data',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(child: Text('View Data'),),);
  }
}
