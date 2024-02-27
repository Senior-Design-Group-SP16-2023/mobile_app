import 'package:flutter/material.dart';
import '../widgets/recent_activity.dart'; // Make sure these imports match the location of your widgets
import '../widgets/calendar.dart';
import '../widgets/graph.dart';

class UserDetailPage extends StatelessWidget {
  final String userName;

  const UserDetailPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }, // This line will handle the back navigation
        ),
        title: const Text('Back'), // Optionally, you can also add a title here
        // align the title to the right of the icon
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0, // Removes the shadow under the app bar.
        backgroundColor: Colors
            .transparent, // Sets the AppBar background color to transparent
        foregroundColor: Colors.black, // Sets the icon color
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              userName,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          RecentActivity(
            data: [
              {
                'accuracy': 90,
                'duration': 30,
              },
            ],
          ),
          CalendarWidget(),
          RecentActivityGraphWidget(),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
