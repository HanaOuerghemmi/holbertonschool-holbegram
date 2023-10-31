import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:holbegram/screens/home.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

@override
  void initState() {
    _pageController = PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedPage(),
          SearchPage(),
          AddImagePage(),
          FavoritePage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Search',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: Colors.red,
                
              ),
              textAlign: TextAlign.center,
            ),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.add),
            title: Text(
              'Add',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: Colors.red,
                
              ),
              textAlign: TextAlign.center,
            ),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite),
            title: Text(
              'Favorite',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: Colors.red,
                
              ),
              textAlign: TextAlign.center,
            ),
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Profile',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'Billabong',
                color: Colors.red,
                
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}


class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Search Page'),
    );
  }
}

class AddImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Add Image Page'),
    );
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Favorite Page'),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page'),
    );
  }
}
