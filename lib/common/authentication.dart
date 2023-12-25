import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:get/get.dart';
import 'package:music_spotify_app/model/user.dart' as model;

class Auth extends GetxController{
  final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // User? get currentUser => firebaseAuth.currentUser;
  User? currentUser = FirebaseAuth.instance.currentUser;
  RxString error = ''.obs;
  Stream<User?> get authenStateChanges => firebaseAuth.authStateChanges();
  Future<String> signUpUser({
    required String email,
    required String fullname,
    // required Timestamp createAt,
    required String image,
    required String password,
    //required String confirmpassword,
  })async{
    String res ="Some error occurred";
    try{
      if(email.isNotEmpty ||fullname.isNotEmpty ||password.isNotEmpty  ){
        //register user
       UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
       
       print(cred.user!.uid);
       //add user to our database
      model.User user = model.User(email: email, uid:cred.user!.uid, fullname: fullname,password: password, followers: [], following: [],image: image );
      await firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);
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
       await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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
    await firebaseAuth.signOut();
  }

}
