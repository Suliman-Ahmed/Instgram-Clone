import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_firebase/models/user_model.dart';
import 'package:instgram_firebase/services/database_service.dart';
import 'package:instgram_firebase/services/storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  EditProfileScreen(this.user);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  File _profileImage;
  String _name = '';
  String _bio = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _name = widget.user.name;
    _bio = widget.user.bio;
  }

  //Chose image fro, Glallery
  _handleImageFromGallery() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  // Update Database
  _submit() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        _isLoading = true;
      });

      // Update user in data base
      String imageUrl = _profileImage.toString();

      if (_profileImage == null) {
        imageUrl = widget.user.profileImageUrl;
      } else {
        imageUrl = await StorageService.uploadUserProfileImage(
            widget.user.profileImageUrl, _profileImage);
      }

      User user = User(
        id: widget.user.id,
        name: _name,
        bio: _bio,
        profileImageUrl: imageUrl,
      );
      // Database Updated
      DatabaseService.updateUser(user);
      print('Updated');
      Navigator.pop(context);
    }
  }

  //Display profile image
  _displayProfileImage() {
    // no new profile image
    if (_profileImage == null) {
      if (widget.user.profileImageUrl.isEmpty) {
        return AssetImage('assets/img/user_placeholder.png');
      } else {
        return CachedNetworkImageProvider(widget.user.profileImageUrl);
      }
    } else {
      //New profile image
      return FileImage(_profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // App Bar
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      // Body
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            _isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Colors.blue[200],
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Profile Image
                      CircleAvatar(
                          radius: 60.0,
                          backgroundImage: _displayProfileImage()),
                      FlatButton(
                        onPressed: () => _handleImageFromGallery(),
                        child: Text(
                          'Chnage profile image',
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 16.0),
                        ),
                      ),
                      /////////////////////////////////////////////////////
                      // Username
                      TextFormField(
                        initialValue: _name,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            size: 30.0,
                          ),
                          labelText: 'Name',
                        ),
                        validator: (input) => input.trim().length < 1
                            ? 'Please enter a valid name'
                            : null,
                        onSaved: (input) => _name = input,
                      ),
                      /////////////////////////////////////////////////////////////
                      // Bio
                      TextFormField(
                        initialValue: _bio,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.book,
                            size: 30.0,
                          ),
                          labelText: 'Bio',
                        ),
                        validator: (input) => input.trim().length > 150
                            ? 'Bio must be less than 150 characters'
                            : null,
                        onSaved: (input) => _bio = input,
                      ),
                      ///////////////////////////////////////////////////////
                      // Submit Button
                      Container(
                        margin: EdgeInsets.all(40),
                        height: 30,
                        width: 250,
                        child: FlatButton(
                          onPressed: _submit,
                          child: Text('Save Changes'),
                          textColor: Colors.white,
                          color: Colors.blue,
                        ),
                      ),
                      /////////////////////////////////////////////////
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
