import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

signUpUser(
    {required String name,
    required String phone,
    required String email,
    required String password}) async {
  User? userId = FirebaseAuth.instance.currentUser;

  try {
    await FirebaseFirestore.instance.collection('users').doc(userId!.uid).set(
      {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'createdAt': DateTime.now(),
        'userId': userId.uid,
      }).then((value) => {
        FirebaseAuth.instance.signOut(),
      debugPrint('Successful'),
    });
  } on FirebaseAuthException catch (e) {
    debugPrint('Error $e');
  }
}
