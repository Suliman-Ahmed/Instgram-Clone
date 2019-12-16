import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram_firebase/models/user_model.dart';
import 'package:instgram_firebase/utilites/constants.dart';

class DatabaseService {
  static void updateUser(User user) {
    userRef.document(user.id).updateData(
        {'name': user.name, 'bio': user.bio, 'imageUrl': user.profileImageUrl});
  }

  static Future<QuerySnapshot> searchUser(String name) async {
    User names;
    Future<QuerySnapshot> user =
        userRef.where('name', isGreaterThanOrEqualTo: name).getDocuments();

    return user;
  }
}
