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

  Future<List<Map<String, dynamic>>> fetchWorkoutDataWithId(
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
          String formattedDate =
              DateFormat("MMM d yyyy (h:mm a)").format(dateTime);

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

  Future<List<Map<String, dynamic>>> fetchWorkoutDataWithTime(
      String email, DateTime earliestTs, DateTime latestTs) async {
    List<Map<String, dynamic>> workoutData = [];

    await _firestore
        .collection("workouts")
        .doc(email)
        .collection("data")
        .where('timestamp', isGreaterThanOrEqualTo: earliestTs)
        .where('timestamp', isLessThan: latestTs)
        .get()
        .then(
      (snapshot) {
        for (var docSnapshot in snapshot.docs) {
          workoutData.add({
            "accuracy": docSnapshot.data()['accuracy'],
            "timestamp": docSnapshot.data()['timestamp'].toDate(),
            "workout_id": docSnapshot.data()['workout_id'],
            "duration": docSnapshot.data()['duration'],
            "repList": docSnapshot.data()['repList'],
            "numberOfReps": docSnapshot.data()['numberOfReps']
          });
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    return workoutData;
  }

  Future<List<String>> fetchAllPatients(User user) async {
    List<String> patients = [];
    DocumentSnapshot documentSnapshot =
        await _firestore.collection("patients").doc(user.email).get();
    if (documentSnapshot.exists) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      for (var element in data["patients"]) {
        patients.add(element.toString());
      }
    }
    return patients;
  }

  Future<String> addPatient(String patientEmail, User doctor) async {
    String message = "";
    //Check if the given patient exists as a user
    DocumentSnapshot patientSnapshot =
        await _firestore.collection("users").doc(patientEmail).get();
    if (patientSnapshot.exists) {
      //Check if the given patient is a valid patient (a patient who completed signup)
      bool? isPatientValid =
          patientSnapshot["isPatient"] && patientSnapshot["completedSignUp"];
      if (!isPatientValid) {
        message = "Given user is not a valid patient.";
      } else {
        //Check if the doctor has any patients
        DocumentSnapshot doctorSnapshot =
            await _firestore.collection("patients").doc(doctor.email).get();
        if (doctorSnapshot.exists) {
          var patients =
              List.from(doctorSnapshot.get("patients") as List<dynamic>);
          //Check if the given patient is already a patient of the doctor
          if (patients.contains(patientEmail)) {
            message = "Patient already added.";
          } else {
            patients.add(patientEmail);
            await _firestore
                .collection("patients")
                .doc(doctor.email)
                .update({"patients": patients});
            message = "Patient added.";
          }
        } else {
          Map<String, dynamic> data = {
            "patients": [patientEmail]
          };
          await _firestore.collection("patients").doc(doctor.email).set(data);
          message = "Patient added.";
        }
      }
    } else {
      message = "Given patient does not exist.";
    }
    return message;
  }

  Future<void> addNewWorkout(
      User user, int workoutNum, Map<String, dynamic> workoutDetails) {
    DocumentReference doc_ref = _firestore
        .collection('workouts')
        .doc(user.email)
        .collection('data')
        .doc("workout_$workoutNum");
    return doc_ref.set({
      'accuracy': workoutDetails['accuracy'],
      'duration': workoutDetails['duration'],
      'timestamp': workoutDetails['timestamp'],
      'numberOfReps': workoutDetails['numberOfReps'],
      'repList': workoutDetails['repList'],
      'workout_id': workoutNum
    });
  }

  //golden write to goldens/test@gmail.com/idealworkouts
// write as a document


  Future<void> addMostRecentWorkout(String email, Map<String, dynamic> data) {
   final map = {
     "most_recent": data
   };
    return _firestore
        .collection("workouts").doc(email).set(map);
  }

}
