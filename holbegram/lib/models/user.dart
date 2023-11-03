import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String uid;
  String email;
  String username;
  String bio;
  String photoUrl;
  List<dynamic> follwers;
  List<dynamic> follwing;
  List<dynamic> posts;
  List<dynamic> saved;
  String searchKey;
  Users({
    required this.uid,
    required this.email,
    required this.username,
    required this.bio,
    required this.photoUrl,
    required this.follwers,
    required this.follwing,
    required this.posts,
    required this.saved,
    required this.searchKey,
  });

   static Users fromSnap(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;

     return Users(
       uid: data['uid'],
       email: data['email'],
       username: data['username'],
       bio: data['bio'],
       photoUrl: data['photoUrl'],
       follwers: data['followers'] ?? [],
       follwing: data['following'] ?? [],
       posts: data['posts'] ?? [],
       saved: data['saved'] ?? [],
       searchKey: data['searchKey'],
     );
   }

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
