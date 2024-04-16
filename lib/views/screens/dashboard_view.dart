import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/user_view_model.dart';
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
    final userViewModel = Provider.of<UserViewModel>(context);
    final now = DateTime.now();

    return Scaffold(
      body: SafeArea( // Use SafeArea directly here
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // insert a space between the top of the screen and the content
              DashboardHeader(),
              FutureBuilder(
                  future: userViewModel.fetchWorkoutData(1),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return RecentActivity(data: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
              FutureBuilder(
                  future: userViewModel.fetchWorkoutsInMonth(
                      DateTime(now.year, now.month, 1), now),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return CalendarWidget(
                          userViewModel: userViewModel,
                          workoutData: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
              FutureBuilder(
                  future: userViewModel.fetchWorkoutData(5),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return RecentActivityGraphWidget(
                          userViewModel: userViewModel, data: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    }
                    return const CircularProgressIndicator();
                  }),
              // insert a space between the content and the bottom of the screen
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
