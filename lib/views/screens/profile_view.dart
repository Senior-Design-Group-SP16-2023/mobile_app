import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final userInfoMap = userToMap(userViewModel);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Ensures left alignment
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    // This shapes the card with rounded corners
                    borderRadius: BorderRadius.circular(
                        10), // Match the borderRadius as in your provided code
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Ensures left alignment within the card
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment
                              .start, // Ensures the row content is left-aligned
                          children: [
                            Icon(Icons.person, color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              'General Information',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ...userInfoMap.entries.map((entry) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Ensures left alignment for each entry
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black, // Default text color
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '${entry.key}: ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: entry.value.toString(),
                                        style: const TextStyle(
                                            color: Colors
                                                .blue), // Value text color
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (entry != userInfoMap.entries.last)
                                const Divider(),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Map<String, dynamic> userToMap(UserViewModel userViewModel) {
    if (userViewModel.user.isPatient!) {
      return {
        'First Name': userViewModel.user.firstName,
        'Last Name': userViewModel.user.lastName,
        'Email Address': userViewModel.user.email,
        'Date of Birth': userViewModel.user.dateOfBirth,
        'Gender': userViewModel.user.gender,
        'Weight': userViewModel.user.weight,
        'Height': userViewModel.user.height,
        'Injury Type': userViewModel.user.injuryType,
        'Date of Injury': userViewModel.user.dateOfInjury,
        'Past Injuries': userViewModel.user.pastInjuries,
        'Total Workouts': userViewModel.user.totalWorkouts,
      };
    } else if (!userViewModel.user.isPatient!) {
      return {
        'First Name': userViewModel.user.firstName,
        'Last Name': userViewModel.user.lastName,
        'Email Address': userViewModel.user.email,
        'Hospital Name': userViewModel.user.hospitalName,
        'Hospital Address': userViewModel.user.hospitalAddress,
        'Hospital City': userViewModel.user.hospitalCity,
        'Hospital State': userViewModel.user.hospitalState,
        'Hospital Zip Code': userViewModel.user.hospitalZipCode,
        'Hospital Floor Room': userViewModel.user.hospitalFloorRoom,
        'Specialization': userViewModel.user.specialization,
      };
    } else {
      return <String, dynamic>{};
    }
  }
}
