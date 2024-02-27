import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddPatientView extends HookWidget {
  const AddPatientView({super.key});

  @override
  Widget build(BuildContext context) {
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();

    return Scaffold(
      body: ListView(
        // Use ListView for consistent alignment and scrolling
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
            child: Text(
              'Add Patient',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Your form fields and the 'Add' button go here
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20.0), // Consistent padding for form fields
            child: Column(
              children: [
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement the logic for adding a patient here
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Add', style: TextStyle(fontSize: 18)), // Text updated to 'Sign in' with fontSize 18
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // Padding and minimumSize properties removed to match the provided style
                    minimumSize: Size(double.infinity, 60), // Increase button size
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
