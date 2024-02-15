import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senior_design/models/user_model.dart';

class FireStoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNewUser(User user) {
    return _firestore.collection('users').doc(user.email).set(user.toJson());
  }

  Future<User> fetchUser(String userId) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userId).get();
    return User.fromJson(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> updateUser(User user) {
    return _firestore.collection('users').doc(user.email).update(user.toJson());
  }
}
