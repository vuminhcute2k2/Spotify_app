import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as CustomUser;
import 'package:firebase_auth/firebase_auth.dart';

CustomUser.User? currentUser = FirebaseAuth.instance.currentUser;

class StoreServices {
  // get user data
  static getUser(String id) {
    return FirebaseFirestore.instance.collection('users').where('uid', isEqualTo: id).get();
  }
}
