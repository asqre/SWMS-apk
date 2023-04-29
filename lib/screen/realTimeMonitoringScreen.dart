import 'package:flutter/material.dart';

import '../component/navigator_drawer_widget.dart';

class RealTimeMonitoringScreen extends StatelessWidget {
  const RealTimeMonitoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: const Text('Time Monitoring'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(child: Text('Real Time Monitoring'),),);
  }
}
