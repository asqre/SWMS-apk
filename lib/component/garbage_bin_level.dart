import 'package:flutter/material.dart';

class GarbageLevel extends StatelessWidget {
  const GarbageLevel({Key? key, required this.containerHeight, required this.filledHeight}) : super(key: key);
  final double containerHeight;
  final double filledHeight;

  double PercentageFilled(){
    double ans = (filledHeight/containerHeight) * 100;
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 10,
            width: 30,
            color: (PercentageFilled() ==100) ? Colors.red : Colors.deepPurple,
          ),
          Container(
            padding: EdgeInsets.all(7),
            color: (PercentageFilled() ==100) ? Colors.red : Colors.deepPurple,
            height: 100,
            width: 70,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height:PercentageFilled(),
                    color: Colors.green,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100 - PercentageFilled(),
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
