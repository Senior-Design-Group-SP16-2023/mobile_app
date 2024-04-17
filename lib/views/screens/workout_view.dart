import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/workoutconnect_view.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              'Workout',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            // Reduced bottom padding to decrease space between the image and the next text widget
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 10.0), // Reduced from 20.0 to 10.0
              child:
                  Image.asset('lib/views/widgets/backgrounds/workoutImage.png'),
            ),
          ),
          // The RichText widget with "Type: Bicep Curl" and "Duration: ~10 minutes"
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Type: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Bicep Curl\n',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    TextSpan(
                      text: 'Duration: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '~10 minutes',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WorkoutConnectView()),
                );
              },
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
}
