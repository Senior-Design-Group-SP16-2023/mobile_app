import 'package:flutter/material.dart';
import 'package:senior_design/utils/routes/routes_name.dart';
import 'package:senior_design/views/widgets/backgrounds/background.dart';
import 'package:senior_design/views/widgets/backgrounds/background_name.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BackgroundImage(
        imagePath: BackgroundName.loginBackground,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(), // Add a Spacer to push everything towards the bottom
              const Text(
                'Welcome to Recover',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 8.0), // Increased space for aesthetic purposes
              Text(
                // Adding the subtitle
                'Physical Therapy. Done right.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0, // Adjust font size as needed
                  fontWeight: FontWeight.normal, // Adjust font weight as needed
                  color: Colors.grey[600], // Adjust color as needed
                ),
              ),
              const SizedBox(
                  height: 48.0), // Increased space for aesthetic purposes
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RoutesName.signin);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Sign In', style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                ),
              ),
              const SizedBox(height: 24.0), // Spacing between buttons
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RoutesName.createAccount);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Create Account', style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              Spacer(
                  flex:
                      1), // Optionally, adjust the flex to manage the space distribution
            ],
          ),
        ),
      ),
    );
  }
}
