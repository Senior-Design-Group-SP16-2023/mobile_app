import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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

  Future<List<Map<String, dynamic>>> fetchLastFiveDays(User user) async {
    final now = DateTime.now();
    List<Map<String, dynamic>> daysData = [];

    for (int i = 0; i < 5; i++) {
      DateTime day = now.subtract(Duration(days: i));

      var dayDocSnapshot = await _firestore
          .collection('workouts')
          .doc(user.email)
          .collection("${day.year}_${day.month}")
          .doc("${day.day}")
          .get();

      if (dayDocSnapshot.exists && dayDocSnapshot.data()!.containsKey('workouts')) {
        var dayOfWeek = DateFormat('EEEE').format(day); // Gets day of the week as a string
        var workouts = dayDocSnapshot.data()!['workouts'] as List<dynamic>;
        var maxAccuracy = workouts.fold<int>(0, (max, item) => item['accuracy'] > max ? item['accuracy'] : max);

        daysData.add({
          "date": day,
          "dayOfWeek": dayOfWeek,
          "maxAccuracy": maxAccuracy,
        });
      }
    }

    daysData.sort((a, b) => a["date"].compareTo(b["date"]));
    print(daysData);
    return daysData;
  }

}
