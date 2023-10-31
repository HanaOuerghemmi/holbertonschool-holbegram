import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? uid;
  String? email;
  String? username;
  String? bio;
  String? photoUrl;
  List<dynamic>? follwers;
  List<dynamic>? follwing;
  List<dynamic>? posts;
  List<dynamic>? saved;
  String? searchKey;
  Users({
    this.uid,
    this.email,
    this.username,
    this.bio,
    this.photoUrl,
    this.follwers,
    this.follwing,
    this.posts,
    this.saved,
    this.searchKey,
  });

  // static Users fromSnap(DocumentSnapshot snap) {
  //   Object? data = snap.data();

  //   return Users(
  //     uid: data['uid'],
  //     email: data['email'],
  //     username: data['username'],
  //     bio: data['bio'],
  //     photoUrl: data['photoUrl'],
  //     followers: data['followers'],
  //     following: data['following'],
  //     posts: data['posts'],
  //     saved: data['saved'],
  //     searchKey: data['searchKey'],
  //   );
  // }

Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'bio': bio,
      'photoUrl': photoUrl,
      'followers': follwers,
      'following': follwing,
      'posts': posts,
      'saved': saved,
      'searchKey': searchKey,
    };
  }
}
