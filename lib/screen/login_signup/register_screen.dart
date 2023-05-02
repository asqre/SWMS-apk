import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swms/bloc/sign_up_services.dart';
import '../../common_functions/string_validator.dart';
import '../../component/form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPassToggle = true;
  late String _emailValue;
  late String _nameValue;
  late String _phoneValue;
  late String _passwordValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent
        // gradient: LinearGradient(colors: [
        //   hexStringToColor("CB2B93"),
        //   hexStringToColor("9546C4"),
        //   hexStringToColor("5E61F4")
        // ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        // image: DecorationImage(
        //   image: AssetImage('assets/images/register.png'),
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 30),
                child: const Text(
                  'Create\nAccount',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 35, right: 35),
                        child: Column(
                          children: [
                            TextWidget(
                                onSaved: (name) {
                                  debugPrint(name);
                                  _nameValue = name!;
                                },
                                labelText: 'Name',
                                hintText: 'Your full name',
                                prefixIcon: const Icon(Icons.person),
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r"[a-zA-Z]+|\s"))
                                ],
                                validator: checkNameEmpty),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                                onSaved: (phone) {
                                  debugPrint(phone);
                                  _phoneValue = phone!;
                                },
                                labelText: 'Phone No.',
                                hintText: 'Your phone no',
                                prefixIcon: const Icon(Icons.call),
                                keyboardType: TextInputType.number,
                                validator: checkPhoneEmpty),
                            const SizedBox(
                              height: 10,
                            ),
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
                              height: 10,
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
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: 350,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState != null &&
                                        _formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      FocusScope.of(context).unfocus();
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                              email: _emailValue,
                                              password: _passwordValue)
                                          .then(
                                            (value) => {
                                              log("user Created"),
                                              signUpUser(
                                                  name: _nameValue,
                                                  phone: _phoneValue,
                                                  email: _emailValue,
                                                  password: _passwordValue),
                                              // Navigator.pushNamed(
                                              //     context, 'login'),
                                              log('data Added'),
                                            },
                                          );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'please login here...',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.pushNamed(context, 'login');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.black, // Background color
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              _formKey.currentState!.reset();
                              FocusScope.of(context).unfocus();
                            },
                            child: const Text(
                              'clear',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, 'login'),
                            style: const ButtonStyle(),
                            child: const Text(
                              'Sign in',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
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
