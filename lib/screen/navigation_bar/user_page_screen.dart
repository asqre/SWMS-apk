import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swms/utils/string_constant.dart';
import '../../component/navigator_drawer_widget.dart';

class UserPageScreen extends StatelessWidget {
  const UserPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text(user.displayName!.toUpperCase()),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'WELCOME',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            // Spacer(),
            SizedBox(
              height: 140,
            ),

            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(user.photoURL ?? StringConstant.imageUrl),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Name: ' + (user.displayName ?? StringConstant.name),
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Email: ' + (user.email ?? StringConstant.email),
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
