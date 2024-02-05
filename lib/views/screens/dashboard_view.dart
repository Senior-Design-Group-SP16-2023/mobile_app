import 'package:flutter/material.dart';
import 'package:senior_design/views/widgets/graph.dart';
import 'package:senior_design/views/widgets/recent_activity.dart';
import 'package:senior_design/views/widgets/calendar.dart';
import 'package:senior_design/views/widgets/dashboard_header.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    // Format the current date

    return Scaffold(
      body: SafeArea( // Use SafeArea to ensure content is not hidden behind status bars or notches
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardHeader(),
              RecentActivity(),
              CalendarWidget(),
              RecentActivityWithBarChart(),
            ],
          ),
        ),
      ),
    );
  }
}
