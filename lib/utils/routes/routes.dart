import 'package:senior_design/utils/routes/routes_name.dart';
import 'package:senior_design/views/screens/home_view.dart';
import 'package:senior_design/views/screens/login_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => HomeView());
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => LoginView());
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text("no route defined"),
            ),
          );
        });
    }
  }
}
