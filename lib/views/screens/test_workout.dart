import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class TestWorkout extends StatefulWidget {
  const TestWorkout({Key? key}) : super(key: key);

  @override
  State<TestWorkout> createState() => _WorkoutViewState();
}

class _WorkoutViewState extends State<TestWorkout> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Assume you somehow store the data in Firestore
                triggerRegularProcessing(userViewModel.user.email!,
                        userViewModel.user.totalWorkouts! + 1)
                    .then((accuracyList) {
                  print(accuracyList);
                  print(accuracyList.length);
                  print((accuracyList.where((item) => item).length / accuracyList.length)*100);
                  print(DateTime.now());
                });
              },
              child: const Text('TEST'),
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<dynamic>> triggerRegularProcessing(String email, int id) async {
  var url = Uri.parse('https://regularprocessing-kykbcbmk5q-uc.a.run.app/');
  var params = {'email': email, 'workout_num': id.toString()};
  final uri = Uri.parse(url.toString()).replace(queryParameters: params);

  try {
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      return jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  } catch (error) {
    print('An error occurred: $error');
    return [];
  }
}
