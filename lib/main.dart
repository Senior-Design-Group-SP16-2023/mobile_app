import 'package:flutter/material.dart';
import 'utils/routes/routes.dart';
import 'utils/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/auth_view_model.dart';
import 'package:senior_design/view_models/user_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.welcome,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
