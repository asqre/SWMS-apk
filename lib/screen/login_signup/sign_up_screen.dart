import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:swms/services/auth_services.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            CircleAvatar(
              backgroundImage: AssetImage('assets/icons/icon.webp'),
              radius: 100,
            ),
            // Image.asset('assets/icons/icon.webp',
            //   height:400,
            //   width: 400,
            // ),
            Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hey There,\nWelcome Back',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Login to your account to continue',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Colors.red,
              ),
              label: Text(
                'Sign Up with Google',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'login');
              },
              child: Text(
                'Already have an account? Log in',
                style: TextStyle(
                    color: Colors.black54,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
