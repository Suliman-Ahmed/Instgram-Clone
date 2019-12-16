import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instgram_firebase/Screens/feed_screen.dart';
import 'package:instgram_firebase/pages/create_post_screen.dart';
import 'package:instgram_firebase/pages/notify_page_screen.dart';
import 'package:instgram_firebase/pages/profile_page_screen.dart';
import 'package:instgram_firebase/pages/search_page_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';
  final String userId;

  HomeScreen({this.userId});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currectTab = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          FeedScreen(),
          SearchScreen(),
          CreatePostScreen(),
          ActivityScreen(),
          ProfileScreen(userID: widget.userId,)
        ],
        onPageChanged: (int index) {
          setState(() {
            _currectTab = index;
          });
        },
      ),
      // Botttom Navigation Bar
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.black,
        currentIndex: _currectTab,
        onTap: (int index) {
          setState(() {
            _currectTab = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              size: 32.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
