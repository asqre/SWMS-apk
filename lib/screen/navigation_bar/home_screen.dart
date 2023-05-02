import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swms/component/navigator_drawer_widget.dart';
import 'package:swms/utils/string_constant.dart';
import '../../common_functions/string_validator.dart';


class HomePage extends StatelessWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        // centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0,bottom: 12,right: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(user?.photoURL ?? StringConstant.imageUrl),
            ),
          ),
        ],
      ),
      drawer: NavigatorDrawer(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(opacity: 1,
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/homeBackground.jpg'),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150,),
              Text('Garbage Monitoring System', style: TextStyle(color: Colors.black,fontSize: 25,),),
              SizedBox(height: 20),
              Text('IoT Based\n SoftWare\n Solution', style: TextStyle(color: Colors.blueGrey,fontWeight: FontWeight.bold, fontSize: 40,),),
              SizedBox(height: 30,),
              ActionChip(
                  label: Text(
                    'Explore Work',
                    style: TextStyle(fontSize: 16,color: Colors.white),
                  ),
                onPressed: () async {
                  LaunchApplicationURL(StringConstant.homeURL);
                },
                elevation: 8,
                avatar:  FaIcon(FontAwesomeIcons.link,color: Colors.white,size: 16,),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
