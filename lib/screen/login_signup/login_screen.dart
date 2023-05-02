import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swms/component/form_widget.dart';
import 'package:swms/component/square_tile.dart';
import 'package:swms/services/auth_services.dart';
import '../../common_functions/string_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPassToggle = true;
  late String _emailValue;
  late String _passwordValue;
  final _formKey = GlobalKey<FormState>();

  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailValue, password: _passwordValue).then((value) => Navigator.pushNamed(context, 'homeScreen'));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'verified !',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          backgroundColor: Colors.green,
        ),
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  }

  // error message to user;
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Welcome back, you\'ve been missed!",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      // top: MediaQuery.of(context).size.height * 0.4,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextWidget(
                          onSaved: (email) {
                            debugPrint(email);
                            _emailValue = email!;
                          },
                          labelText: 'Email',
                          hintText: 'Your email id',
                          prefixIcon: const Icon(Icons.email),
                          keyboardType: TextInputType.emailAddress,
                          validator: checkEmailEmpty),
                      const SizedBox(
                        height: 30,
                      ),
                      TextWidget(
                          onSaved: (password) {
                            debugPrint(password);
                            _passwordValue = password!;
                          },
                          labelText: 'Password',
                          hintText: 'your password',
                          prefixIcon: const Icon(Icons.lock),
                          keyboardType: TextInputType.text,
                          inkwell: InkWell(
                            onTap: () {
                              //on calling setState only password text widget will rebuild remaining TextWidget will not rebuild
                              setState(() {
                                isPassToggle = !isPassToggle;
                              });
                            },
                            child: Icon(isPassToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          isObscureText: isPassToggle,
                          validator: checkPasswordEmpty),

                      //forgot password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'forgotPassword');
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 350,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                FocusScope.of(context).unfocus();
                                signUserIn();
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text(
                                //       'verified !',
                                //       style: TextStyle(
                                //           fontSize: 20,
                                //           fontWeight: FontWeight.bold,
                                //           color: Colors.white),
                                //     ),
                                //     backgroundColor: Colors.green,
                                //   ),
                                // );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple, // Background color
                            ),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )),
                      ),

                      const SizedBox(
                        height: 50,
                      ),

                      // or continue with
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'or continue with',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                          Expanded(
                              child: Divider(
                            thickness: 0.5,
                            color: Colors.black,
                          ))
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),

                      //google + apple sign in
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //google button
                          SquareTile(
                              imagePath: 'assets/images/google.png',
                              onTap: () async{
                                final provider =Provider.of<GoogleSignInProvider>(context,listen:false);
                               await provider.googleLogin().then((value) =>Navigator.pop(context));
                              }),
                          SizedBox(
                            width: 25,
                          ),
                          SquareTile(
                              imagePath: 'assets/images/apple.png',
                              onTap: () => AuthService().signInWithGoogle()),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?',
                            style: TextStyle(
                              color: Colors.grey[700],
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, 'register'),
                            child: Text(
                              'Register now',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
