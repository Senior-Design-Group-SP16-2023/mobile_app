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
  final int duration; // Duration in seconds

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
              '$duration seconds',
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
              '${accuracy.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// Repetitions Widget
class RepetitionsCard extends StatelessWidget {
  final List<dynamic> repList;
  const RepetitionsCard({Key? key, required this.repList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate list of colors for each circle
    List<Color> colors = List.generate(repList.length, (index) {
      if (repList[index]) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    });

    List<Widget> circleWidgets = List.generate(repList.length, (index) {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: colors[index],
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child:
            Text('${index + 1}', style: const TextStyle(color: Colors.white)),
      );
    });

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
                  'Repetitions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8, // horizontal spacing
              runSpacing: 8, // vertical spacing
              children: circleWidgets,
            )
          ],
        ),
      ),
    );
  }
}

class WorkoutDetailsView extends StatefulWidget {
  final List<Map<String, dynamic>> workouts;
  final bool isFromWorkout;

  const WorkoutDetailsView(
      {Key? key, required this.workouts, required this.isFromWorkout})
      : super(key: key);

  @override
  _WorkoutDetailsViewState createState() => _WorkoutDetailsViewState();
}

class _WorkoutDetailsViewState extends State<WorkoutDetailsView> {
  String dropdownValue = '1'; // Initial dropdown value
  late Map<String, dynamic> selectedWorkout;

  @override
  void initState() {
    super.initState();
    selectedWorkout = widget.workouts[0];
  }

  @override
  Widget build(BuildContext context) {
    final List<String> dropdownItems = List.generate(
        widget.workouts.length, (index) => (index + 1).toString());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.check),
          onPressed: () => widget.isFromWorkout
              ? popMultiple(context, 5)
              : Navigator.of(context).pop(),
        ),
        title: const Text('Done'),
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Workout Details',
                  style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      int index = int.parse(dropdownValue) - 1;
                      selectedWorkout = widget.workouts[index];
                    });
                  },
                  items: dropdownItems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const WorkoutTypeCard(type: "Bicep Curl"),
          WorkoutDayAndTimeCard(
              dayAndTime: selectedWorkout['timestamp'] ?? DateTime.now()),
          WorkoutDurationCard(duration: selectedWorkout['duration'] ?? 0),
          WorkoutAccuracyCard(accuracy: selectedWorkout['accuracy'] ?? 0.0),
          RepetitionsCard(repList: selectedWorkout['repList'] ?? []),
        ],
      ),
    );
  }
}

void popMultiple(BuildContext context, int count) {
  int popCount = 0;
  Navigator.popUntil(context, (route) {
    return popCount++ >= count;
  });
}
