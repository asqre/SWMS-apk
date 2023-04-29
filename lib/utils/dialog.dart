import 'package:flutter/material.dart';

Widget buildPopupDialog(BuildContext context, String popUpExample, String content){
  return new AlertDialog(
    title: Text(popUpExample),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(content),
      ],
    ),
    actions: [
      new TextButton(onPressed: (){
        Navigator.of(context).pop();
      }, child: Text('OK',style: TextStyle(color: Colors.blue),),
      )
    ],
  );
}