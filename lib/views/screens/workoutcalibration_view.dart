import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/workouttype_view.dart';

class WorkoutCalibrateView extends StatefulWidget {
  const WorkoutCalibrateView({Key? key}) : super(key: key);

  @override
  State<WorkoutCalibrateView> createState() => _WorkoutCalibrationViewState();
}

class _WorkoutCalibrationViewState extends State<WorkoutCalibrateView> {
  bool _isStartEnabled = true;
  bool _isEndEnabled = false;
  bool _isNextEnabled = false;

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
              'Calibrate Device',
              style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
            ),
          ),
          instructionStep('1', 'Place Device(s) on Arm'),
          instructionStep('2', 'Rest Arm by Side in Natural Position'),
          instructionStep('3', 'Grab Dumbell Weight in Arm'),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: ElevatedButton(
                    onPressed: _isStartEnabled
                        ? () {
                            setState(() {
                              _isStartEnabled = false;
                              _isEndEnabled = true;
                            });
                          }
                        : null,
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
                    onPressed: _isEndEnabled
                        ? () {
                            setState(() {
                              _isEndEnabled = false;
                              _isNextEnabled = true;
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      minimumSize: const Size(100, 60),
                    ),
                    child: const Text('End', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
              height: 40.0), // Increased space between 'End' and 'Next'
          Center(
            child: ElevatedButton(
              onPressed: _isNextEnabled
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WorkoutTypeView()),
                      );
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
