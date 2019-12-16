import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App Bar
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text('Instgram',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Lobster',
              fontSize: 25.0,
            )),
      ),
      // Body
      body: Center(
        child: Text('Activity Screen'),
      ),
    );
  }
}
