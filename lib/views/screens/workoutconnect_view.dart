import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/workoutcalibration_view.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/ble/ble_service.dart';

class WorkoutConnectView extends StatefulWidget {
  const WorkoutConnectView({Key? key}) : super(key: key);

  @override
  State<WorkoutConnectView> createState() => _WorkoutConnectViewState();
}

class _WorkoutConnectViewState extends State<WorkoutConnectView> {
  @override
  Widget build(BuildContext context) {
    final bleService = Provider.of<BLEService>(context);
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
              'Connect to Device',
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
          ),
          instructionStep('1', 'Open Settings App'),
          instructionStep('2', 'Go to Bluetooth'),
          instructionStep('3', 'Turn on Device(s)'),
          instructionStep('4', 'Search for "SP16 Device"'),
          instructionStep('5', 'Select Device(s) to Pair'),
          instructionStep('6', 'Return to Recover'),
          const SizedBox(
              height:
                  20.0), // Space between the last instruction and the Next button
          Center(
              child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  bleService.startScan();
                }, // Increase font size
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0), // Increase button padding
                  minimumSize: const Size(300, 60), // Increase button size
                ),
                child: const Text('Connect',
                    style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: !bleService.isReadyToWorkout
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const WorkoutCalibrateView()),
                        );
                      }, // Increase font size
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0), // Increase button padding
                  minimumSize: const Size(300, 60), // Increase button size
                ),
                child: const Text('Next', style: TextStyle(fontSize: 18)),
              ),
            ],
          )),
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
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: CircleAvatar(
              radius: 12.0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
              child: Text(number,
                  style: const TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 18.0))),
        ],
      ),
    );
  }
}
