import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/addpatient_view.dart';
import 'package:senior_design/views/screens/profile_view.dart';
import 'package:senior_design/views/screens/workout_view.dart';
import 'package:senior_design/views/screens/dashboard_view.dart';
import 'package:senior_design/view_models/user_view_model.dart';
import 'package:provider/provider.dart';
import 'doctordashboardsearch_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    UserViewModel userViewModel = Provider.of<UserViewModel>(context);

    if (userViewModel.user.isPatient! == true) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Offstage(
              offstage: index != 0,
              child: TickerMode(
                enabled: index == 0,
                child: const MaterialApp(home: DashboardView()),
              ),
            ),
            Offstage(
              offstage: index != 1,
              child: TickerMode(
                enabled: index == 1,
                child: const MaterialApp(home: WorkoutView()),
              ),
            ),
            Offstage(
              offstage: index != 2,
              child: TickerMode(
                enabled: index == 2,
                child: const MaterialApp(home: ProfileView()),
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
          items: const <BottomNavigationBarItem>[
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
    } else {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            Offstage(
              offstage: index != 0,
              child: TickerMode(
                enabled: index == 0,
                child: MaterialApp(
                  home: FutureBuilder(
                      future: userViewModel.fetchAllPatients(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return SearchPage(patientNames: snapshot.data!);
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        }
                        return const CircularProgressIndicator();
                      }),
                ),
              ),
            ),
            Offstage(
              offstage: index != 1,
              child: TickerMode(
                enabled: index == 1,
                child: const MaterialApp(home: AddPatientView()),
              ),
            ),
            Offstage(
              offstage: index != 2,
              child: TickerMode(
                enabled: index == 2,
                child: const MaterialApp(home: ProfileView()),
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              label: 'Add Patient',
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
}
