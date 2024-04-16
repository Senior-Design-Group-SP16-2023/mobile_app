import 'package:flutter/material.dart';
import 'dart:async'; // Import this to use Timer

class WorkoutStartView extends StatefulWidget {
  const WorkoutStartView({Key? key}) : super(key: key);

  @override
  State<WorkoutStartView> createState() => _WorkoutStartViewState();
}

class _WorkoutStartViewState extends State<WorkoutStartView> {
  Timer? _timer; // Timer for the stopwatch
  Duration _duration = Duration.zero; // Initial duration of the stopwatch
  bool _isRunning = false; // To track whether the stopwatch is running

  void _startTimer() {
    if (_timer != null) _timer!.cancel(); // If there's an existing timer, cancel it
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration += const Duration(seconds: 1);
      });
    });
    setState(() {
      _isRunning = true;
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
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
                _duration.toString().split('.').first.padLeft(8, "0"), // Display the stopwatch time
                style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
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
                    onPressed: !_isRunning ? _startTimer : null, // Start the timer if not already running
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      minimumSize: const Size(100, 60),
                    ),
                    child: const Text('Start', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: ElevatedButton(
                    onPressed: _isRunning ? _stopTimer : null, // Stop the timer if running
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
              onPressed: !_isRunning && _duration != Duration.zero ? () {
                // Proceed only if the timer is not running and has been started at least once
                Navigator.of(context).pop(); // Example navigation, modify as needed
              } : null,
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
    );
  }

  @override
  void dispose() {
    _timer?.cancel(); // Clean up the timer when the widget is disposed
    super.dispose();
  }
}
