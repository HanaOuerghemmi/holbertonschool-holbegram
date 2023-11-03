import 'package:flutter/material.dart';
import 'package:holbegram/screens/Pages/widgets/feeds_list.dart';
import 'package:holbegram/screens/Pages/widgets/posts_card.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        
        title: Row(
          children: [
            const Text(
              "Holbegram",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'Billabong', // Assuming you have the 'Billabong' font
              ),
              
            ),
            Image.asset(
              'assets/images/img.png',
              width: 50,
              height: 50,
            ),
          ],
        ),
        actions: [
         IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message_outlined,
              color: Colors.black,
            ),
          ), // Replace with your custom logo widget
        ],
      ),
      body: FeedsList(),
    );
    
    
  }
}

