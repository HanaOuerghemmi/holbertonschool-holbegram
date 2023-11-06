import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:holbegram/methods/auth_methods.dart';

class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key});

  List<dynamic> postsIds = [];

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
  widget.postsIds = userProvider.user!.posts;
   Future<List<DocumentSnapshot>?> getPosts() async {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection('posts');
    if (widget.postsIds.isNotEmpty) {
      
      final query = collection.where(FieldPath.documentId, whereIn: widget.postsIds);
      final querySnapshot = await query.get();
      return querySnapshot.docs;
    } else {
      return null; 
    }
  }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          
          style: TextStyle(
            fontFamily: 'Billabong', // Assuming you have the 'Billabong' font
            fontSize: 40,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await AuthMethods().logOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    ((route) => false));
              },
              icon: const Icon(Icons.logout_rounded))
          // Replace with your custom logo widget
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: userProvider.user!.photoUrl != ""
                        ? NetworkImage(userProvider.user!.photoUrl)
                        : Image.asset("assets/images/img.png").image,
                  ),
                  FollwItem(
                      text: "Posts",
                      count: userProvider.user!.posts.length.toString()),
                  FollwItem(
                      text: "Followers",
                      count: userProvider.user!.follwers.length.toString()),
                  FollwItem(
                      text: "Following",
                      count: userProvider.user!.follwing.length.toString()),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                child: Text(
                  "${userProvider.user!.username}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50,),
              SizedBox(
                height: 600,
                child: FutureBuilder(
                  future: getPosts().then((value) => widget.postsIds = value ?? []),
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
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: posts!.length,
                  itemBuilder: (context, index) {
                    final Post post = Post.fromSnap(posts[index]);
                    return Image.network(
                      post.postUrl,
                      fit: BoxFit.cover,
                    );
                  },
                );
                  }
                ),
  
              )
              
            ],

          ),
        ),
      ),
    );
  }
}

class FollwItem extends StatelessWidget {
  final String text;
  final String count;
  const FollwItem({super.key, required this.text, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

// class StoragePosts extends StatelessWidget {
//   const StoragePosts({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('posts').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return ErrorWidget(snapshot.error!);
//         }

//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         final data = snapshot.data!.docs;

//         return SizedBox(
//           height: 800,
//           child: GridView.builder(
//             itemCount: snapshot.data!.docs.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3, 
//     crossAxisSpacing: 5, 
//     mainAxisSpacing:2,
              
//             ),
//             itemBuilder: (context, index) {
//               // Replace 'post.postUrl' with the appropriate URL for each image
//               String imageUrl = snapshot.data!.docs[index]['postUrl'];
//               final document = snapshot.data!.docs[index];
//               final itemData = document.data() as Map<String, dynamic>;
//               final Post post = Post.fromJson(itemData);
        
//               return Container(
                
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               );
//             },
            
//           ),
//         );
//       },
//     );
//   }
// }
