import 'dart:ffi';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/Pages/methods/post_storage.dart';
import 'package:holbegram/screens/Pages/widgets/posts_card.dart';
import 'package:provider/provider.dart';

class FeedsList extends StatefulWidget {
  const FeedsList({super.key});

  @override
  State<FeedsList> createState() => _FeedsListState();
}

class _FeedsListState extends State<FeedsList> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('datePublished', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget(snapshot.error!);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!.docs;

          return SingleChildScrollView(
              child:Container(
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.separated(
              
                  separatorBuilder: ((context, index) {
                    return const SizedBox(
                      height: 15,
                    );
                  }),
                  itemCount: data.length,
                  itemBuilder: ((context, index) {
                    final document = snapshot.data!.docs[index];
                    final itemData = document.data() as Map<String, dynamic>;
                    final Post post = Post.fromJson(itemData);
                    return 
                 PostsCard(
                    photoUrl: post.profImage,
                    userName: itemData['username'],
                    caption: post.caption,
                    postUrl: post.postUrl,
                    saveFunction: () async {
                                String res = await PostStorage().addToFavorite(
                                    idPost: post.uid,
                                    idUser: userProvider.user!.uid);
                                userProvider.refreshUser();
                                if (res == "Saved") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(res),
                                  ));
                                }
                              },
                    
                    );
                  }
                    )
                ),
              ),
          );

        });
         

        }
        
  }

