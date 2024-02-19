import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/views/widgets/backgrounds/background.dart';
import 'package:senior_design/views/widgets/backgrounds/background_name.dart';
import 'package:senior_design/view_models/user_view_model.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:senior_design/view_models/auth_view_model.dart';

class CreateAccountView extends HookWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isPatientState = useState(true);
    final disableButton = useState(true);
    final passwordVisible = useState(false);

    useEffect(() {
      void checkFields() {
        if (firstNameController.text.isNotEmpty &&
            lastNameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          disableButton.value = false;
        } else {
          disableButton.value = true;
        }
      }

      firstNameController.addListener(checkFields);
      lastNameController.addListener(checkFields);
      emailController.addListener(checkFields);
      passwordController.addListener(checkFields);
      return () {
        firstNameController.removeListener(checkFields);
        lastNameController.removeListener(checkFields);
        emailController.removeListener(checkFields);
        passwordController.removeListener(checkFields);
      };
    });

    return Scaffold(
      extendBodyBehindAppBar: true, // Make body extend behind AppBar
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            userViewModel.clearUser();
            Navigator.of(context).pop();
            authViewModel.setErrorMessage("", true);
        }, // This line will handle the back navigation
        ),
        title: const Text('Back'), // Optionally, you can also add a title here
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
                top: kToolbarHeight + 20.0,
                left: 20.0,
                right: 20.0,
                bottom: 20.0),
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
                    child: CupertinoSegmentedControl<bool>(
                      children: const {
                        true: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Patient'),
                        ),
                        false: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Doctor'),
                        ),
                      },
                      onValueChanged: (bool val) {
                        isPatientState.value = val;
                      },
                      groupValue: isPatientState.value,
                      borderColor: Theme.of(context).primaryColor,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor: Colors.grey.shade300,
                      pressedColor:
                          Theme.of(context).primaryColor.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(height: 24.0),
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
                  const SizedBox(height: 12.0),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Change the icon based on password visibility
                          passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          // Update the password visibility state
                          passwordVisible.value = !passwordVisible.value;
                        },
                      ),
                    ),
                    obscureText: !passwordVisible.value,
                  ),
                  const SizedBox(height: 15.0),
                  if(authViewModel.errorMessage.isNotEmpty && !authViewModel.isSignIn)
                    Column(
                      children: [
                        Text(
                          authViewModel.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red
                          ),
                        ),
                        const SizedBox(height: 15.0),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: disableButton.value
                        ? null
                        : () {
                            userViewModel.setAccountInfo(
                              firstNameController.text,
                              lastNameController.text,
                              emailController.text,
                              isPatientState.value,
                            );
                            authViewModel.createAccount(
                              context,
                              email: emailController.text,
                              password: passwordController.text,
                              isPatient: userViewModel.user.isPatient,
                              userViewModel: userViewModel,
                            );
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
