import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Workout Day and Time Widget
class WorkoutDayAndTimeCard extends StatelessWidget {
  final DateTime dayAndTime;

  const WorkoutDayAndTimeCard({Key? key, required this.dayAndTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('MMMM d, y (h:mm a)').format(dayAndTime);
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Date/Time',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Workout Duration Widget
class WorkoutDurationCard extends StatelessWidget {
  final int duration; // Duration in minutes

  const WorkoutDurationCard({Key? key, required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.timer, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Duration',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$duration minutes',
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Workout Type Widget
class WorkoutTypeCard extends StatelessWidget {
  final String type;

  const WorkoutTypeCard({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.directions_run, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Type',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              type,
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Workout Accuracy Widget
class WorkoutAccuracyCard extends StatelessWidget {
  final double accuracy; // Accuracy in percentage

  const WorkoutAccuracyCard({Key? key, required this.accuracy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Accuracy',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$accuracy%',
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// New Widget for Number of Reps
class WorkoutRepsCard extends StatelessWidget {
  final int numberOfReps;

  const WorkoutRepsCard({Key? key, required this.numberOfReps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.fitness_center, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Number of Reps',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$numberOfReps',
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// New Widget for Good/Bad Reps
class WorkoutGoodBadRepsCard extends StatelessWidget {
  final int goodReps;
  final int badReps;

  const WorkoutGoodBadRepsCard(
      {Key? key, required this.goodReps, required this.badReps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.thumbs_up_down, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'Good/Bad Reps',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '$goodReps/$badReps',
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Main View to Combine All Cards
class WorkoutDetailsView extends StatelessWidget {
  final List<Map<String, dynamic>> workouts;

  const WorkoutDetailsView(
      {Key? key, required this.workouts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Safely extract workout details with default values for potential nulls
    final int workoutDuration =
        workouts[0]['duration'] ?? 0; // Default to 0 if null
    const String workoutType = "Bicep Curl"; // Assuming type is always provided
    final double workoutAccuracy =
        workouts[0]['accuracy'] ?? 0; // Default to 100 if null
    final DateTime workoutTime = workouts[0]['timestamp'] ??
        DateTime.now(); // Default to current time if null
    final int numberOfReps = workouts[0]['reps'] ?? 0; // Default to 0 if null
    final int goodReps = workouts[0]['goodReps'] ?? 0; // Default to 0 if null
    final int badReps = workouts[0]['badReps'] ?? 0; // Default to 0 if null

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
              'Workout Details',
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
          ),
          WorkoutTypeCard(type: workoutType),
          WorkoutDayAndTimeCard(dayAndTime: workoutTime),
          WorkoutDurationCard(duration: workoutDuration),
          WorkoutAccuracyCard(accuracy: workoutAccuracy),
          WorkoutRepsCard(numberOfReps: numberOfReps),
          WorkoutGoodBadRepsCard(goodReps: goodReps, badReps: badReps),
        ],
      ),
    );
  }
}
