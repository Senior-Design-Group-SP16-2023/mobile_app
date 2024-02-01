import 'package:flutter/material.dart';

class RecentActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Removed Scaffold, directly returning the padding and content.
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensures the Column wraps its content
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.fitness_center),
                    SizedBox(width: 8),
                    Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
                        Text('Accuracy', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('0%', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey,
                    ),
                    Column(
                      children: <Widget>[
                        Text('Duration', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('0 min', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    Container(
                      height: 30,
                      width: 1,
                      color: Colors.grey,
                    ),
                    Column(
                      children: <Widget>[
                        Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Yes', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
