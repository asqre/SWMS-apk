import 'package:flutter/material.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars=0;

  Widget _buildStar(int starCount){
    return InkWell(
      child: Icon(
        Icons.star,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: (){
        setState(() {
          _stars=starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Rate this Post'),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('CANCEL')),
        TextButton(onPressed: (){
          Navigator.of(context).pop(_stars);
        }, child: Text('OK')),
      ],
    );
  }
}
