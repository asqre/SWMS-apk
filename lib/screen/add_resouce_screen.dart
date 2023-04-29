import 'package:flutter/material.dart';
import 'package:swms/component/navigator_drawer_widget.dart';

class AddResourceScreen extends StatelessWidget {
  const AddResourceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('Resources'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Add Resource'),
      ),
    );
  }
}
