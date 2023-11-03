import 'package:flutter/material.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/Pages/methods/post_storage.dart';
import 'package:holbegram/screens/Pages/widgets/feeds_list.dart';
import 'package:holbegram/screens/Pages/widgets/posts_card.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
 
 List<dynamic> postsIds = [];
 
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    postsIds = userProvider.user!.saved;
    return Scaffold(
appBar: AppBar(
        
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontSize: 40,
            fontFamily: 'Billabong', // Assuming you have the 'Billabong' font
          ),
          
        ),
        
      ),
      body: FutureBuilder(
        future: PostStorage().getPosts(postsIds).then((value) => postsIds = value ?? []),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final posts = snapshot.data;

          if (posts!.isEmpty) {
            return Center(child: Text('No posts available.'));
          }
          return ListView.separated(
            
            itemCount: posts.length,
           separatorBuilder: (context, index) {
             return SizedBox(height: 7);
           },
            itemBuilder: (context, index) {
              final Post post = Post.fromSnap(posts[index]);
              return Image.network(
                post.postUrl,
                height: 350,
                fit: BoxFit.cover,
              );
            },

          );
        }
      ),
    );
    
    
  }
}

