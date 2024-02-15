import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:senior_design/view_models/auth_view_model.dart';
import 'package:senior_design/views/widgets/backgrounds/background.dart';
import 'package:senior_design/views/widgets/backgrounds/background_name.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class SignInView extends HookWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userViewModel = Provider.of<UserViewModel>(context);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final disableButton = useState(true);

    useEffect(() {
      void checkFields() {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          disableButton.value = false;
        } else {
          disableButton.value = true;
        }
      }

      emailController.addListener(checkFields);
      passwordController.addListener(checkFields);
      return () {
        emailController.removeListener(checkFields);
        passwordController.removeListener(checkFields);
      };
    });

    return Scaffold(
      extendBodyBehindAppBar: true, // Make body extend behind AppBar
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).pop();
            authViewModel.setErrorMessage("", true);
          },
        ),
        title: Text('Back'), // Optionally, you can also add a title here
        // align the title to the right of the icon
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.transparent, // Ensure AppBar is transparent
        foregroundColor: Colors.black, // Set icon color
      ),
      body: BackgroundImage(
        imagePath: BackgroundName.loginBackground,
        child: Padding(
          padding: const EdgeInsets.only(
              top: kToolbarHeight + 20.0,
              left: 20.0,
              right: 20.0,
              bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              const Text(
                'Sign in to Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Ensure text is visible on background
                ),
              ),
              const SizedBox(height: 24.0),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white, // Adding fill color for visibility
                  filled: true,
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white, // Adding fill color for visibility
                  filled: true,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: disableButton.value
                    ? null
                    : () {
                        authViewModel.signIn(
                          context,
                          email: emailController.text,
                          password: passwordController.text,
                          userViewModel: userViewModel,
                        );
                      },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Sign in', style: TextStyle(fontSize: 18)),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              if(authViewModel.errorMessage.isNotEmpty && authViewModel.isSignIn)
                Column(
                  children: [
                    const SizedBox(height: 15.0),
                    Text(
                      authViewModel.errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                    ),
                  ],
                ),
              TextButton(
                onPressed: () {/* Forgot Password? action */},
                child: const Text('Forgot Password?',
                    style: TextStyle(color: Colors.blue)),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
