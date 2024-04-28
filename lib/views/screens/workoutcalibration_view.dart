import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/workouttype_view.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/ble/ble_service.dart';

class WorkoutCalibrateView extends StatefulWidget {
  const WorkoutCalibrateView({Key? key}) : super(key: key);

  @override
  State<WorkoutCalibrateView> createState() => _WorkoutCalibrationViewState();
}

class _WorkoutCalibrationViewState extends State<WorkoutCalibrateView> {
  bool _isStartEnabled = true;
  bool _isNextEnabled = false;

  //function to call the calibration function and then wait 5 seconds before saying calibration is complete
  void calibrateDevice(BLEService bleService) async {
    //call calibration function
    //wait 5 seconds
    bleService.beginCalibration();
    await Future.delayed(const Duration(seconds: 5));
    //set _isNextEnabled to true
    setState(() {
      _isNextEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bleService = Provider.of<BLEService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            bleService.decreasePagesAway();
            bleService.setInWorkoutFlow(false);
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
          Center(
            child: ElevatedButton(
              onPressed: _isStartEnabled
                  ? () {
                      setState(() {
                        _isStartEnabled = false;
                        calibrateDevice(bleService);
                      });
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                minimumSize: const Size(300, 60),
              ),
              child: const Text('Calibrate', style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(
              height: 15.0), // Increased space between 'End' and 'Next'
          Center(
            child: ElevatedButton(
              onPressed: _isNextEnabled
                  ? () {
                      bleService.increasePagesAway();
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
