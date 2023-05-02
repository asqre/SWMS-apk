import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swms/screen/login_signup/on_boarding_page.dart';
import 'package:swms/screen/navigation_bar/user_page_screen.dart';
import '../services/auth_services.dart';
import '../utils/string_constant.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: InkWell(
                onTap: (){
                  // close navigation drawer before
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> UserPageScreen()));
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10,),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user.photoURL ?? StringConstant.imageUrl),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        (user.displayName ?? StringConstant.name).toUpperCase(),
                        style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        (user.email ?? StringConstant.email),
                        style: TextStyle(color: Colors.white,fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: (){
                  Navigator.pushReplacementNamed(context, 'homePage');
                },
              ),
              ListTile(
                leading: Icon(Icons.navigation_outlined),
                title: const Text('Generate Routes'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'generateRoutes');
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.businessTime),
                title: const Text('Real Time Monitoring'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'realTime');
                },
              ),
              ListTile(
                leading: Icon(Icons.signal_wifi_statusbar_null),
                title: const Text('Status of Bins'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'statusBins');
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sunPlantWilt),
                title: const Text('Add a Resource'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'addResource');
                },
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.database),
                title: const Text('view Data'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'viewData');
                },
              ),
              // Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Divider(
                  color: Colors.black54,
                ),
              ),
              ListTile(
                title: Text('Help'),
                leading: Icon(Icons.help_outline_outlined),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, 'helpPage');
                },
              ),
              ListTile(
                title: const Text('Logout',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                onTap: (){
                  final provider =Provider.of<GoogleSignInProvider>(context,listen: false);
                  provider.logout();

                  //Todo : changes done for onboarding
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => OnBoardingPage()));

                },
                trailing: Icon(Icons.logout,color: Colors.red,),
              )
            ],
          )
        ],
      ),
    );
  }
}
