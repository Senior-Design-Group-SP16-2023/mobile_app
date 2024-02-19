import 'package:flutter/material.dart';
import 'dart:ui'; // Import this for ImageFilter.

class RecentActivity extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const RecentActivity({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Removed Scaffold, directly returning the padding and content.
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(10), // Adjust the border radius as needed
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Ensures the Column wraps its content
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.fitness_center,
                          color:
                              Colors.black), // Adjust icon color for visibility
                      SizedBox(width: 8),
                      Text(
                        'Recent Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .black, // Adjust text color for better visibility on glassy background
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('Accuracy',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text("${data[0]['accuracy']}%",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Column(
                        children: <Widget>[
                          Text('Duration',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text('${data[0]['duration']} min',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                      Container(
                        height: 30,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Column(
                        children: <Widget>[
                          Text('Status',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text('Yes',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
