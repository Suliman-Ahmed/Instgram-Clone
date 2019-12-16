import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instgram_firebase/models/user_model.dart';
import 'package:instgram_firebase/pages/edit_profile_screen.dart';
import 'package:instgram_firebase/utilites/constants.dart';

class ProfileScreen extends StatefulWidget {
  final String userID;

  ProfileScreen({this.userID});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

        backgroundColor: Colors.white38,
        
        // Body
        body: FutureBuilder(
          future: userRef.document(widget.userID).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            User user = User.fromDoc(snapshot.data);
            print(user.name);
            return ListView(
              padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    // Profile Image
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: user.profileImageUrl.isEmpty
                          ? AssetImage('assets/img/user_placeholder.png')
                          : CachedNetworkImageProvider(user.profileImageUrl),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //Post
                              Column(
                                children: <Widget>[
                                  Text(
                                    '12',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'posts',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),

                              // Followers
                              Column(
                                children: <Widget>[
                                  Text(
                                    '502',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'followers',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),

                              //Following
                              Column(
                                children: <Widget>[
                                  Text(
                                    '100',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'following',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                  child: Column(
                    children: <Widget>[
                      // Name
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      // Bio
                      Container(
                        padding: EdgeInsets.only(bottom: 20, top: 5),
                        height: 80.0,
                        width: MediaQuery.of(context).size.width - 20,
                        child: Text(
                          user.bio,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //Edit Button
                Container(
                  height: 30,
                  width: 200.0,
                  child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditProfileScreen(user),
                      ),
                    ),
                    child: Text('Edit Profile'),
                  ),
                ),

                Divider()
              ],
            );
          },
        ));
  }
}
