import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instgram_firebase/models/user_model.dart';
import 'package:instgram_firebase/pages/profile_page_screen.dart';
import 'package:instgram_firebase/services/database_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;

  _buildUserTile(User user) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            userID: user.id,
          ),
        ),
      ),
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: user.profileImageUrl.isEmpty
            ? AssetImage('assets/img/user_placeholder.png')
            : CachedNetworkImageProvider(user.profileImageUrl),
      ),
      title: Text(user.name),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15.0),
              border: InputBorder.none,
              hintText: 'Search...',
              prefixIcon: Icon(
                Icons.search,
                size: 30.0,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () => print('Clear'),
              ),
              filled: true,
            ),
            onSubmitted: (input) {
              print(input);
              setState(() {
                _users = DatabaseService.searchUser(input);
              });
            },
          ),
          backgroundColor: Colors.white,
        ),
        body: FutureBuilder(
          future: _users,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.documents.length == 0) {
              return Center(
                child: Text('No Users found!! please try Again'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index) {
                User user = User.fromDoc(snapshot.data.documents[index]);
                return _buildUserTile(user);
              },
            );
          },
        ));
  }
}
