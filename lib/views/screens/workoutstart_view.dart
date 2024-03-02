import 'package:flutter/material.dart';

class WorkoutStartView extends StatefulWidget {
  const WorkoutStartView({Key? key}) : super(key: key);

  @override
  State<WorkoutStartView> createState() => _WorkoutStartViewState();
}

class _WorkoutStartViewState extends State<WorkoutStartView> {
  get selectedDay => null;

  @override
  Widget build(BuildContext context) {
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
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              'Start Workout',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => {},
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
