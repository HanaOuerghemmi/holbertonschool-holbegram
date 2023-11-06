import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:holbegram/models/posts.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(

          decoration: BoxDecoration(
            color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15), // You can adjust the border radius as needed
        
      ),
          child: TextField(
            
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
            hintText: 'Search',
            
            prefixIcon: Icon(Icons.search, color: Colors.grey, size: 32,),
             // Remove the standard border
          ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return ErrorWidget(snapshot.error!);
            }
    
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
    
            final data = snapshot.data!.docs;
    
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.custom(
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    const QuiltedGridTile(4, 4),
                    const QuiltedGridTile(2, 2),
                    const QuiltedGridTile(2, 2),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final document = snapshot.data!.docs[index];
                    final itemData = document.data() as Map<String, dynamic>;
                    final Post post = Post.fromJson(itemData);
                    return Container(
                      child: Image.network(
                        post.postUrl,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  childCount: snapshot.data!.docs.length,
                ),
              ),
            );
      },
    ),
    );
  }
}