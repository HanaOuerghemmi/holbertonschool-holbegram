import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostStorage {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


Future<String> uploadImageToStorage(Uint8List image, String imagePath) async {
  try {
    Reference storageReference = FirebaseStorage.instance.ref().child(imagePath);
    UploadTask uploadTask = storageReference.putData(image);
    await uploadTask.whenComplete(() => null);

    String downloadURL = await storageReference.getDownloadURL();

    return downloadURL;
  } catch (error) {
    print("Error uploading image: $error");
    throw error; // You can handle the error as needed
  }
}

  Future<String> uploadPost(String caption, String uid, String username,
      String profImage, Uint8List image) async {
    try {
      // Upload the image to Firebase Storage and get the download URL
         String imageUrl = await uploadImageToStorage(image, '');


      // Create a new document in the 'posts' collection
      DocumentReference postRef = await _firestore.collection('posts').add({
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'postUrl': imageUrl,
      });

      return "Ok"; // Return "Ok" on success
    } catch (error) {
      return error.toString(); // Return the error message on failure
    }
  }

  Future<void> deletePost(String postId) async {
    try {
      // Delete the document with the specified postId from the 'posts' collection
      await _firestore.collection('posts').doc(postId).delete();
    } catch (error) {
      throw error; // Throw an error if deletion fails
    }
  }
}
