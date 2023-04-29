import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swms/utils/string_constant.dart';
import 'dialog.dart';

class ChipButton extends StatefulWidget {
  const ChipButton({Key? key}) : super(key: key);

  @override
  State<ChipButton> createState() => _ChipButtonState();
}

class _ChipButtonState extends State<ChipButton> {
  bool isSelected =false;
  @override
  Widget build(BuildContext context) {
    return ActionChip(label: Text(StringConstant.updateContent,style: TextStyle(fontSize: 12,),),
      elevation: 0,
      backgroundColor: Colors.white,
      padding: EdgeInsets.all(20),
      avatar: CircularProgressIndicator(),
      onPressed: (){
        setState(() {
          isSelected = !isSelected;
        });
      },
    );
  }
}


class SplashWidget extends StatefulWidget {
  const SplashWidget({Key? key}) : super(key: key);

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {

  startTime() async{
    var duration = new Duration(seconds: 6);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => buildPopupDialog(context, '', '')));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: initScreen(context)
    );
  }

  initScreen(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(Icons.flutter_dash),
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text('Splash Screen'),
            Padding(padding: EdgeInsets.only(top: 20)),
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }

}
