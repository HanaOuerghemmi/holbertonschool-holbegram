
import 'package:flutter/material.dart';

class PostsCard extends StatelessWidget {
  final String photoUrl;
  final String userName;
  final String caption;
   final String postUrl;
   final Function() saveFunction;
  const PostsCard({super.key, required this.photoUrl, required this.userName, required this.postUrl, required this.saveFunction, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        
        child: Column(
          
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                  CircleAvatar(
                          radius: 20,
                          backgroundImage: 
                              NetworkImage(photoUrl),
                              
                        ),
                        SizedBox(width: 15,),
                         Text(userName),
                ],
              ),
                 
                  IconButton(
                    onPressed: (){}, 
                    icon: Icon(Icons.more_horiz))
    
            ],),
             Text(caption),
             SizedBox(height: 10,),
             Container(
                          width: 350,
                          height: 350,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                              image: NetworkImage(postUrl
                               
                                ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.messenger_outline),
                                ),
                                IconButton(
                                  onPressed: (){},
                                  icon: Icon(Icons.send),
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: saveFunction,
                              icon: Icon(Icons.bookmark_outline_outlined),
                            ),
                          ],
                        ),
                        
                        Align(alignment: Alignment.centerLeft,
                          child: Text("0 Liked"))
                      ],
                    ),
                  )
                );
               
         
   
  }
}