import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swms/screen/login_signup/sign_up_screen.dart';
import '../screen/navigation_bar/home_screen.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          print(snapshot);
          if ( snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else if (snapshot.hasData){
            return HomePage();
          }else if (snapshot.hasError){
            return Center(child: Text('Something Went Wrong!'),);
          }else{
            return SignUpScreen();
          }
        },
    );
  }
}

// appBar: AppBar(
//   automaticallyImplyLeading: false, //for back icon arrow in AppBar
//   title: Text('Home Screen'),
//   actions: [
//     GestureDetector(
//         onTap: () async{
//           AuthService().logout();
//           Navigator.pushNamed(context, 'login');
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(Icons.logout),
//         )),
//   ],
// ),