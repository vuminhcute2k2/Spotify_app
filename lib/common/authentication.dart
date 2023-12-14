import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:get/get.dart';
import 'package:music_spotify_app/model/user.dart' as model;

class Auth extends GetxController{
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currenUser => _firebaseAuth.currentUser;
  RxString error = ''.obs;
  Stream<User?> get authenStateChanges => _firebaseAuth.authStateChanges();
  Future<String> signUpUser({
    required String email,
    required String fullname,
    // required Timestamp createAt,
    // required String image,
    required String password,
    //required String confirmpassword,
  })async{
    String res ="Some error occurred";
    try{
      if(email.isNotEmpty ||fullname.isNotEmpty ||password.isNotEmpty  ){
        //register user
       UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
       
       print(cred.user!.uid);
       //add user to our database
      model.User user = model.User(email: email, uid:cred.user!.uid, fullname: fullname,password: password, followers: [], following: []);
      await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
       res = "success";

      }
    }
    catch(err){
      res= err.toString();
    }
    return res;
  }

  //login user
  Future<String>  loginUser({
    required String email,
    required String password,
  })async {
    String res = "Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
       res = "success";
      }else{
        res ="Please enter all the fields";
      }
    }
    catch(err){
      res = err.toString();
    }
    return res;
  }
  logout()async{
    await _firebaseAuth.signOut();
  }

}
