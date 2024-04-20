import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/user_view_model.dart';
import 'package:senior_design/views/screens/workoutdetails_view.dart';
import 'package:senior_design/views/screens/workoutdetailsgolden_view.dart';

class WorkoutStartView extends StatefulWidget {
  final bool isGolden;
  const WorkoutStartView({Key? key, required this.isGolden}) : super(key: key);

  @override
  State<WorkoutStartView> createState() => _WorkoutStartViewState();
}

class _WorkoutStartViewState extends State<WorkoutStartView> {
  Timer? _timer; // Timer for the stopwatch
  Duration _duration = Duration.zero; // Initial duration of the stopwatch
  bool _isRunning = false; // To track whether the stopwatch is running

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration += const Duration(seconds: 1);
      });
    });
    setState(() {
      _isRunning = true;
      // Here we disable the ability to go back
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return WillPopScope(
      onWillPop: () async => false, // Prevent back navigation on Android
      child: Scaffold(
        appBar: AppBar(
          leading: _isRunning
              ? null
              : IconButton(
                  // Disable back button when running
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
          title: const Text('Back'),
          centerTitle: false,
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
              child: Text(
                'Start Workout',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  _duration
                      .toString()
                      .split('.')
                      .first
                      .padLeft(8, "0"), // Display the stopwatch time
                  style: const TextStyle(
                      fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                    child: ElevatedButton(
                      onPressed: !_isRunning
                          ? _startTimer
                          : null, // Start the timer if not already running
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        minimumSize: const Size(100, 60),
                      ),
                      child:
                          const Text('Start', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                    child: ElevatedButton(
                      onPressed: _isRunning
                          ? _stopTimer
                          : null, // Stop the timer if running
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        minimumSize: const Size(100, 60),
                      ),
                      child: const Text('Stop', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0), // Space between buttons
            Center(
              child: ElevatedButton(
                onPressed: !_isRunning && _duration != Duration.zero
                    ? () {
                        print("DURATION" + _duration.toString());
                        // Collect data from Bluetooth
                        // Store the data in Firestore under most recent workout
                        triggerRegularProcessing(userViewModel)
                            .then((workoutDetails) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => widget.isGolden
                                    ? WorkoutDetailsGoldenView(
                                        workouts: [workoutDetails])
                                    : WorkoutDetailsView(
                                        workouts: [workoutDetails])),
                          );
                        });
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  minimumSize: const Size(300, 60),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when the widget is disposed
    super.dispose();
  }
}

Future<Map<String, dynamic>> triggerRegularProcessing(
    UserViewModel userViewModel) async {
  // Set the parameters
  String? email = userViewModel.user.email;
  var url = Uri.parse('https://regularprocessing-kykbcbmk5q-uc.a.run.app/');
  var params = {'email': email};
  final uri = Uri.parse(url.toString()).replace(queryParameters: params);

  // Send a request and get a response
  var accuracyList = [];
  try {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      accuracyList = jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (error) {
    print('An error occurred: $error');
  }

  Map<String, dynamic> workoutDetails = {};
  if (accuracyList.isEmpty) {
    return workoutDetails;
  } else {
    // Increment number of workouts
    userViewModel.setTotalWorkouts(userViewModel.user.totalWorkouts! + 1);
    userViewModel.updateUserInFireStore();
    // Store the new workout in Firestore
    workoutDetails = {
      'accuracy':
          (accuracyList.where((item) => item).length / accuracyList.length) *
              100,
      'duration': 10, // CHANGE THIS
      'timestamp': DateTime.now(),
      'numberOfReps': accuracyList.length,
      'repList': accuracyList,
      'workout_id': userViewModel.user.totalWorkouts
    };
    userViewModel.addNewWorkout(
        userViewModel.user.totalWorkouts!, workoutDetails);
    return workoutDetails;
  }
}
