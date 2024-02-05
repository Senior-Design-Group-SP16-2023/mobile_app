import 'package:flutter/cupertino.dart';

class WorkoutView extends StatefulWidget {
  const WorkoutView({Key? key}) : super(key: key);

  @override
  State<WorkoutView> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<WorkoutView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Workout'),
    );
  }
}
