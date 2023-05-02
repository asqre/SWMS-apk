import 'package:flutter/material.dart';
import 'package:swms/screen/navigation_bar/real_time_data/real_time_database.dart';

class RealTimeMonitoringScreen extends StatelessWidget {
  const RealTimeMonitoringScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RealTimeDatabase();
  }
}
