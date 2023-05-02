import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../common_functions/string_validator.dart';
import '../../component/form_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late String _emailValue;
  final _formKey = GlobalKey<FormState>();

  void forgotUserPassword() async{
    showDialog(context: context, builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
    try {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailValue)
          .then((value) => {
        debugPrint('Email sent'),
        Navigator.pushNamed(context, 'login'),
      });
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      debugPrint('Error $e');
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.green,
        title: Center(
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forgot Password'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: Icon(
                    Icons.lock_reset_outlined,
                    size: 150,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextWidget(
                      onSaved: (email) {
                        debugPrint(email);
                        _emailValue = email!;
                      },
                      labelText: 'Email',
                      hintText: 'Your email id',
                      prefixIcon: const Icon(Icons.email),
                      keyboardType: TextInputType.emailAddress,
                      validator: checkEmailEmpty),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState != null &&
                          _formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScope.of(context).unfocus();
                        forgotUserPassword();
                      }
                    },
                    child: Text("Forgot Password"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
