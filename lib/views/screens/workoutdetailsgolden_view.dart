import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 1. Workout Day and Time Widget
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
            const SizedBox(
                height: 16), // Adjust space between title and date as needed
            Text(
              formattedDate,
              style: const TextStyle(
                  fontSize: 22,
                  color: Colors.blue), // Use a larger font size for the date
            ),
          ],
        ),
      ),
    );
  }
}

// 2. Workout Duration Widget
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

// 3. Workout Type Widget
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

class WorkoutAverageDurationCard extends StatelessWidget {
  final double averageDuration;

  const WorkoutAverageDurationCard({Key? key, required this.averageDuration})
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
                  'Average Duration',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${averageDuration.toStringAsFixed(2)} minutes',
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

class WorkoutDetailsGoldenView extends StatelessWidget {
  final DateTime selectedDay;
  final List<Map<String, dynamic>> workouts;

  const WorkoutDetailsGoldenView(
      {Key? key, required this.selectedDay, required this.workouts})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CHANGE HERE!!!!
    final int workoutDuration = workouts[0]['duration']; // in minutes
    const String workoutType = "Bicep Curl";
    final int workoutAccuracy = workouts[0]['accuracy']; // in percentage
    final DateTime workoutTime = workouts[0]['timestamp'];
    final double averageDuration = workouts[0]['averageDuration']?.toDouble() ?? 0.0;  // Default to 0.0 if null
    final int numberOfReps = workouts[0]['reps'] ?? 0;  // Default to 0 if null

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
          const WorkoutTypeCard(type: workoutType),
          WorkoutDayAndTimeCard(dayAndTime: workoutTime),
          WorkoutDurationCard(duration: workoutDuration),
          WorkoutRepsCard(numberOfReps: numberOfReps),
          WorkoutAverageDurationCard(averageDuration: averageDuration)
        ],
      ),
    );
  }
}