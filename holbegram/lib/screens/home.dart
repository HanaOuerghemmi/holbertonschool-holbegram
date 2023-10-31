import 'package:flutter/material.dart';
import 'package:holbegram/widgets/bottom_nav.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BottomNav(),

      
    );
  }
}



class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        
        title: const Text(
          "Holbegram",
          style: TextStyle(
            fontFamily: 'Billabong', // Assuming you have the 'Billabong' font
          ),
          
        ),
        actions: <Widget>[
          Icon(Icons.add), // Replace with your custom logo widget
          Icon(Icons.message), // Replace with your custom logo widget
        ],
      ),
      body: Center(
      child: Text('Feed Page'),
    ),
    );
    
    
  }
}