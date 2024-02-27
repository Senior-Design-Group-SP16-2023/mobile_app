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
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              'Connect to Device',
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
          ),
          instructionStep('1', 'Open Settings App'),
          instructionStep('2', 'Go to Bluetooth'),
          instructionStep('3', 'Turn on Device(s)'),
          instructionStep('4', 'Search for "XXX"'),
          instructionStep('5', 'Select Device(s) to Pair'),
          instructionStep('6', 'Return to Recover'),
          SizedBox(
              height:
                  20.0), // Space between the last instruction and the Next button
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WorkoutCalibrateView()),
                );
              },
              child: Text('Next',
                  style: TextStyle(fontSize: 18)), // Increase font size
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 15.0), // Increase button padding
                minimumSize: Size(300, 60), // Increase button size
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget instructionStep(String number, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: CircleAvatar(
              radius: 12.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              child: Text(number,
                  style:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(child: Text(text, style: TextStyle(fontSize: 18.0))),
        ],
      ),
    );
  }
}
