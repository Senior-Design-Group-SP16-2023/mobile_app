import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const RecentActivity({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Card(
        elevation: 5, // Adds shadow similar to the ProfileView card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the Column wraps its content
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Row(
                    children: [
                      Icon(Icons.fitness_center, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    data.isNotEmpty ? "${data[0]['timestamp']}" : "",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Text('Accuracy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      Text(data.isNotEmpty ? "${data[0]['accuracy']}%" : "", style: const TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                  Container(height: 30, width: 1, color: Colors.grey),
                  Column(
                    children: <Widget>[
                      const Text('Duration', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      Text(data.isNotEmpty ? '${data[0]['duration']} min' : "", style: const TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                  Container(height: 30, width: 1, color: Colors.grey),
                  Column(
                    children: <Widget>[
                      const Text('Type', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                      Text(data.isNotEmpty ? 'Bicep Curl' : "", style: const TextStyle(fontSize: 18, color: Colors.black)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
