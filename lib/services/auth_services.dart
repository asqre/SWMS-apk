import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final googleSignIn = GoogleSignIn();
  //Google sign in
  signInWithGoogle() async{
    // begin interactive sign in process
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    //obtain the details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    // create a new credential for user
    final credential  = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //finally, lets signin
    return await FirebaseAuth.instance.signInWithCredential(credential).then((value) => debugPrint('success'));
  }

  Future logout() async{

    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}


class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn =GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async{
    try {
      final googleUser = await googleSignIn.signIn();
      if(googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken:  googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future logout() async{
    await googleSignIn.disconnect();  //TODO : handle Googlesignin.disconnect. To get login with multiple user popup while sign in
    await FirebaseAuth.instance.signOut();

    // Todo: changes done for onboarding
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('showHome', false);



    notifyListeners();
  }

}