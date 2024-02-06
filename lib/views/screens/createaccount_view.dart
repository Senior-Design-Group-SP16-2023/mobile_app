import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/auth_view_model.dart';
import 'package:senior_design/utils/routes/routes_name.dart';
import 'package:senior_design/views/widgets/backgrounds/background.dart';
import 'package:senior_design/views/widgets/backgrounds/background_name.dart';
import 'package:senior_design/view_models/user_view_model.dart';


class CreateAccountView extends StatelessWidget{
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      extendBodyBehindAppBar: true, // Make body extend behind AppBar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context)
              .pop(), // This line will handle the back navigation
        ),
        title: Text('Back'), // Optionally, you can also add a title here
        // align the title to the right of the icon
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0, // Removes the shadow under the app bar.
        backgroundColor: Colors
            .transparent, // Sets the AppBar background color to transparent
        foregroundColor: Colors.black, // Sets the icon color
      ),
      body: BackgroundImage(
          imagePath: BackgroundName.loginBackground,
          child: Padding(
        padding: const EdgeInsets.only(
            top: kToolbarHeight + 20.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: SingleChildScrollView(
          // Use SingleChildScrollView to avoid overflow when keyboard appears
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 120.0), // Space at the top
              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: CupertinoSegmentedControl<String>(
                  children: {
                    'Patient': Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('Patient'),
                    ),
                    'Doctor': Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Text('Doctor'),
                    ),
                  },
                  onValueChanged: (String value) {
                    setState(() {
                      _selectedRole = value;
                    });
                  },
                  groupValue: _selectedRole,
                  borderColor: Theme.of(context).primaryColor,
                  selectedColor: Theme.of(context).primaryColor,
                  unselectedColor: Colors.grey.shade300,
                  pressedColor: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: _firstNameController,
                onChanged: (value){
                  userViewModel.setFirstName(value);
                },
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _lastNameController,
                onChanged: (value){
                  userViewModel.setLastName(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _emailController,
                onChanged: (value){
                  userViewModel.setEmail(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  // if patient is selected, navigate to patient account screen
                  if (userViewModel.user.isPatient == true) {
                    Navigator.of(context).pushNamed(RoutesName.patientAccount);
                  }
                  // if doctor is selected, navigate to doctor account screen
                  if (userViewModel.user.isPatient == false) {
                    Navigator.of(context).pushNamed(RoutesName.doctorAccount);
                  }
                  // Logic to handle account creation
                  // Make sure to handle the role as part of the account creation
                  // Map<String, String> data = {
                  //   'role': _selectedRole ?? 'Patient', // Default to 'Patient' if nothing is selected
                  //   'firstName': _firstNameController.text,
                  //   'lastName': _lastNameController.text,
                  //   'email': _emailController.text,
                  //   'password': _passwordController.text,
                  // };
                  // authViewModel.createAccount(context, data);
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Next', style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 24.0), // Space at the bottom
            ],
          ),
        ),
      )),
    );
  }
}
