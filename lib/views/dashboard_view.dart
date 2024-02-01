import 'package:flutter/material.dart';
import 'package:senior_design/views/widgets/recent_activity.dart';
import 'package:senior_design/views/widgets/calendar.dart';
import 'package:intl/intl.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    // Format the current date
    String formattedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());

    return Scaffold(
      body: SafeArea( // Use SafeArea to ensure content is not hidden behind status bars or notches
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              RecentActivity(),
              CalendarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
