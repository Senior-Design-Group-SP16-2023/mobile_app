import 'package:flutter/material.dart';
import 'package:senior_design/views/widgets/recent_activity.dart'; // Make sure these imports match the location of your widgets
import 'package:senior_design/views/widgets/calendar.dart';
import 'package:senior_design/views/widgets/graph.dart';

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    userName,
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.blue),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Remove User"),
                          content: const Text(
                              "Are you sure you want to remove this user?"),
                          actions: <Widget>[
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: const Text("Remove"),
                              onPressed: () {
                                // Here, add your logic to remove the user
                                Navigator.of(context).pop(); // Close the dialog
                                // Navigator.of(context).pop(); // Optionally, navigate back after deletion
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const RecentActivity(
            data: [
              {
                'accuracy': 90,
                'duration': 30,
              },
            ],
          ),
          const CalendarWidget(),
          RecentActivityGraphWidget(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
