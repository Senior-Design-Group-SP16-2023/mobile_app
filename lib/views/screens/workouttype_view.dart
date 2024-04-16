import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/test_workout.dart';

class WorkoutTypeView extends StatefulWidget {
  const WorkoutTypeView({Key? key}) : super(key: key);

  @override
  State<WorkoutTypeView> createState() => _WorkoutTypeViewState();
}

class _WorkoutTypeViewState extends State<WorkoutTypeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
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
              'Workout Type',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Reduce the padding to bring the buttons closer together
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0), // Adjust vertical padding
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TestWorkout()),
                );
              }, // Increase font size
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0), // Increase button padding
                minimumSize:
                    const Size(double.infinity, 60), // Increase button size
              ),
              child: const Text('In Office', style: TextStyle(fontSize: 18)),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TestWorkout()),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text('At Home', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
