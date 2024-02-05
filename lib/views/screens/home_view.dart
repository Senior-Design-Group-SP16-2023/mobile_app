import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/profile_view.dart';
import 'package:senior_design/views/screens/workout_view.dart';
import 'package:senior_design/views/screens/dashboard_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: index != 0,
            child: TickerMode(
              enabled: index == 0,
              child: MaterialApp(home: DashboardView()),
            ),
          ),
          Offstage(
            offstage: index != 1,
            child: TickerMode(
              enabled: index == 1,
              child: MaterialApp(home: WorkoutView()),
            ),
          ),
          Offstage(
            offstage: index != 2,
            child: TickerMode(
              enabled: index == 2,
              child: MaterialApp(home: ProfileView()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
