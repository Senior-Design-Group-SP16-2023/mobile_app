import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class TestWorkout extends StatefulWidget {
  const TestWorkout({Key? key}) : super(key: key);

  @override
  State<TestWorkout> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<TestWorkout> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Collect data from Bluetooth
                // Measure the time between start and stop
                // Store the data in Firestore under most recent workout
                triggerRegularProcessing(userViewModel.user.email!)
                    .then((accuracyList) {
                  // Increment number of workouts
                  userViewModel
                      .setTotalWorkouts(userViewModel.user.totalWorkouts! + 1);
                  userViewModel.updateUserInFireStore();
                  // Store the new workout in Firestore
                  Map<String, dynamic> workoutDetails = {
                    'accuracy': (accuracyList.where((item) => item).length /
                            accuracyList.length) *
                        100,
                    'duration': 10, // CHANGE THIS
                    'timestamp': DateTime.now(),
                    'numberOfReps': accuracyList.length,
                    'repList': accuracyList,
                    'workout_id': userViewModel.user.totalWorkouts
                  };
                  userViewModel.addNewWorkout(
                      userViewModel.user.totalWorkouts!, workoutDetails);
                });
              },
              child: const Text('TEST'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<dynamic>> triggerRegularProcessing(String email) async {
  var url = Uri.parse('https://regularprocessing-kykbcbmk5q-uc.a.run.app/');
  var params = {'email': email};
  final uri = Uri.parse(url.toString()).replace(queryParameters: params);

  try {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  } catch (error) {
    print('An error occurred: $error');
    return [];
  }
}
