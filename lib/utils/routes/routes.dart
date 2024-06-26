import 'package:senior_design/utils/routes/routes_name.dart';
import 'package:senior_design/views/screens/createaccount_view.dart';
import 'package:senior_design/views/screens/doctoraccount_view.dart';
import 'package:senior_design/views/screens/home_view.dart';
import 'package:senior_design/views/screens/patientaccount_view.dart';
import 'package:senior_design/views/screens/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:senior_design/views/screens/welcome_view.dart';
import 'package:senior_design/views/screens/workoutcalibration_view.dart';
import 'package:senior_design/views/screens/workoutconnect_view.dart';
import 'package:senior_design/views/screens/workoutdetails_view.dart';
import 'package:senior_design/views/screens/workouttype_view.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case RoutesName.welcome:
        return MaterialPageRoute(builder: (context) => const WelcomeView());
      case RoutesName.signin:
        return MaterialPageRoute(builder: (context) => const SignInView());
      case RoutesName.createAccount:
        return MaterialPageRoute(
            builder: (context) => const CreateAccountView());
      case RoutesName.patientAccount:
        return MaterialPageRoute(
            builder: (context) => const PatientAccountView());
      case RoutesName.doctorAccount:
        return MaterialPageRoute(
            builder: (context) => const DoctorAccountView());
      case RoutesName.workoutDetails:
        final workouts = settings.arguments as List<Map<String, dynamic>>;
        final isFromWorkout = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (context) => WorkoutDetailsView(
                workouts: workouts, isFromWorkout: isFromWorkout));
      case RoutesName.workoutConnect:
        return MaterialPageRoute(
            builder: (context) => const WorkoutConnectView());
      case RoutesName.workoutCalibrate:
        return MaterialPageRoute(
            builder: (context) => const WorkoutCalibrateView());
      case RoutesName.workoutSelect:
        return MaterialPageRoute(builder: (context) => const WorkoutTypeView());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("No route defined."),
            ),
          );
        });
    }
  }
}
