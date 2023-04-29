import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms/screen/add_resouce_screen.dart';
import 'package:swms/screen/forgot_password_screen.dart';
import 'package:swms/component/home_screen_widget.dart';
import 'package:swms/screen/generate_routes_screen.dart';
import 'package:swms/screen/help_page.dart';
import 'package:swms/screen/on_boarding_page.dart';
import 'package:swms/screen/realTimeMonitoringScreen.dart';
import 'package:swms/screen/register_screen.dart';
import 'package:swms/screen/status_of_bins_screen.dart';
import 'package:swms/screen/user_page_screen.dart';
import 'package:swms/screen/view_data_screen.dart';
import 'package:swms/services/auth_services.dart';
import 'package:swms/screen/sign_up_screen.dart';
import 'screen/home_screen.dart';
import 'screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //TODO: changes done for onboarding
  //to show onboarding page after install
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(SWMS(showHome: showHome));

  // runApp(const SWMS());
}

class SWMS extends StatelessWidget {
  // const SWMS({Key? key}) : super(key: key);

  //TODO: changes done for onboarding
  const SWMS({Key? key, required this.showHome}) : super(key: key);
  final bool showHome;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Smart Waste Management System',
          // home: HomeScreenWidget(),

          //TODO : changes done for onboarding
          home: showHome ? HomeScreenWidget() : OnBoardingPage(),


          routes: {
            'signUp' : (context)=>SignUpScreen(),
            'login': (context) => const LoginScreen(),
            'register': (context) => const RegisterScreen(),
            'forgotPassword': (context) => const ForgotPasswordScreen(),
            'homePage' : (context) => HomePage(),
            'generateRoutes' : (context) => GenerateRoutesScreen(),
            'realTime' : (context) => RealTimeMonitoringScreen(),
            'statusBins' : (context) => StatusBinsScreen(),
            'addResource' : (context) => AddResourceScreen(),
            'viewData' : (context) => ViewDataScreen(),
            'userPage' : (context) => UserPageScreen(),
            'helpPage' : (context) => HelpPage(),
          },
        ),
      );
}
