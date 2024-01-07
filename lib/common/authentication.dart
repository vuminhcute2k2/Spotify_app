import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/controller/profile_controller.dart';
import 'package:music_spotify_app/model/user.dart' as model;


class Auth extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User?  currentUser =  FirebaseAuth.instance.currentUser;
  RxString error = ''.obs;
  Stream<User?> get authenStateChanges => firebaseAuth.authStateChanges();
  Future<String> signUpUser({
    required String email,
    required String fullname,
    required String image,
    required String about,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || fullname.isNotEmpty || password.isNotEmpty) {
        //register user
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(cred.user!.uid);
        //add user to our database
        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
            fullname: fullname,
            password: password,
            followers: [],
            following: [],
            image: image,
            about: about);
        await firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //login user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        // Update the currentUser object
        User? updatedUser = userCredential.user;
        if (updatedUser != null) {
          currentUser = updatedUser;
          print("update user after login");
          print(currentUser);
        }
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  logout() async {
    await firebaseAuth.signOut();
  }
}

