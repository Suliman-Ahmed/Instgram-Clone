import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instgram_firebase/Screens/feed_screen.dart';
import 'package:instgram_firebase/Screens/home_screen.dart';
import 'package:instgram_firebase/Screens/signup_screen.dart';

import 'Screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget _getScreenID() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen(userId: snapshot.data.uid);
        } else {
          print('There is nodata');
          return LoginScreen();
        }
      },
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instgram Clone',
      theme: ThemeData(
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
          color: Colors.black
        )
      ),
      debugShowCheckedModeBanner: false,
      home: _getScreenID(),
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        SignupScreen.id: (context) => SignupScreen(),
        FeedScreen.id: (context) => FeedScreen(),
        HomeScreen.id: (context) => HomeScreen()
      },
    );
  }
}
