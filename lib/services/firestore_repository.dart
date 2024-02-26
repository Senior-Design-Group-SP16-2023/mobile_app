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

  Future<List<Map<String, dynamic>>> fetchWorkoutData(
      User user, int numberOfWorkouts) async {
    List<Map<String, dynamic>> workoutData = [];

    await _firestore
        .collection("workouts")
        .doc(user.email)
        .collection("data")
        .where('workout_id',
            isGreaterThan: user.totalWorkouts! - numberOfWorkouts)
        .where('workout_id', isLessThanOrEqualTo: user.totalWorkouts)
        .get()
        .then(
      (snapshot) {
        for (var docSnapshot in snapshot.docs) {
          DateTime dateTime = docSnapshot.data()['timestamp'].toDate();
          String formattedDate = DateFormat("MMM d (h:mm a)").format(dateTime);

          workoutData.add({
            "accuracy": docSnapshot.data()['accuracy'],
            "timestamp": formattedDate,
            "workout_id": docSnapshot.data()['workout_id'],
            "duration": docSnapshot.data()['duration']
          });
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    workoutData.sort((a, b) => a["workout_id"].compareTo(b["workout_id"]));
    print(workoutData);
    return workoutData;
  }

  Future<List<DateTime>> fetchWorkoutDataWithTime(
      User user, DateTime earliestTs, DateTime latestTs) async {
    Set<DateTime> workoutData = {};

    await _firestore
        .collection("workouts")
        .doc(user.email)
        .collection("data")
        .where('timestamp', isGreaterThanOrEqualTo: earliestTs)
        .where('timestamp', isLessThanOrEqualTo: latestTs)
        .get()
        .then(
      (snapshot) {
        for (var docSnapshot in snapshot.docs) {
          DateTime dateTime = docSnapshot.data()['timestamp'].toDate();
          workoutData.add(dateTime);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return workoutData.toList();
  }
}
