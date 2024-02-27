import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/views/screens/workoutcalibration_view.dart';
import '../../view_models/user_view_model.dart';

class WorkoutConnectView extends StatefulWidget {
  const WorkoutConnectView({Key? key}) : super(key: key);

  @override
  State<WorkoutConnectView> createState() => _WorkoutConnectViewState();
}

class _WorkoutConnectViewState extends State<WorkoutConnectView> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }, // This line will handle the back navigation
        ),
        title: const Text('Back'), // Optionally, you can also add a title here
        // align the title to the right of the icon
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0, // Removes the shadow under the app bar.
        backgroundColor: Colors
            .transparent, // Sets the AppBar background color to transparent
        foregroundColor: Colors.black, // Sets the icon color
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              'Connect to Device',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WorkoutCalibrateView()), // Replace WorkoutConnect with your actual WorkoutConnect page class name
                );
              },
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
