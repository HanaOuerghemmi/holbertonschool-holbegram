import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:uuid/uuid.dart';

import '../screens/login_screen.dart';
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  Future<String> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill all the fields';
    }

    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return 'success';
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return 'Please fill all the fields';
    }
    try {
      String photoUrl ="";
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
                User? user = userCredential.user;

           if(file != null){
      photoUrl=  await uploadImageToStorage(false, user!.uid, file ) ;
       }
      Users users = Users(
        email: email,
        username: username,
        uid: user!.uid,
        bio: "",
        photoUrl:photoUrl,
        follwers: [],
        follwing: [],
        posts: [],
        saved: [],
        searchKey: "",
      );
    
      
      await _firestore.collection("users").doc(user!.uid).set(users.toJson());
      return "success";
    } catch (error) {
      return error.toString();
    }
  }
  
   Future<User?> getCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.currentUser;
    return user;
  }
   Future<Users?> getUserDetails() async {
    try {
      final currentUser = await getCurrentUser();
      if (currentUser != null) {
        final userId = currentUser.uid;
        final userData = await FirebaseFirestore.instance.collection('users').doc(userId).get();

        if (userData != null) {
          final user = Users.fromSnap(userData);
          return user;
        }
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
    return null;
  }



  Future<String> uploadImageToStorage(
    bool isPost,
    String childName,
    Uint8List file,
  ) async {
    Reference ref =_storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    UploadTask uploadTask = ref.putData(
      file,
      SettableMetadata(contentType: 'image/png'),
      );
      
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

 Future<void> logOut() async {
  try {
   await _auth.signOut();
                
  } catch (e) {
    print("Error logging out: $e");
  }
}
}


