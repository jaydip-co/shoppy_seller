

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shoppy_seller/Services/DatabaseService.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInWithEmailAndPassword(String Email,String Password) async {
    final user = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
    print(user.user.email);
    // _auth.createUserWithEmailAndPassword(email: null, password: null);
  }
  // Future sendPassword(){
  //   _auth.currentUser.sendEmailVerification();
  // }
  Future<String> RegisterWithEmailAndPassword(String Email,String Password) async {
    try{
    final user = await _auth.createUserWithEmailAndPassword(email: Email, password: Password);
    print(user.user.email);
    return "Done";
    }
    catch(e){
      if(e.code =='email-already-in-use'){
        return 'User with this email already exits';
      }
      print(e.code);
    }
  }
  Future SignOut() async {
    await _auth.signOut();
  }
}