import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:senior_design/services/auth_repository.dart';
import 'package:senior_design/utils/routes/routes_name.dart';
import 'package:senior_design/view_models/user_view_model.dart';

class AuthViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isSignIn = false;
  String _errorMessage = "";

  bool get isAuthenticated => _isAuthenticated;
  bool get isSignIn => _isSignIn;
  String get errorMessage => _errorMessage;

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  void setErrorMessage(String message, bool isSignIn) {
    _isSignIn = isSignIn;
    _errorMessage = message;
    notifyListeners();
  }

  final _authRepository = AuthRepository();

  Future<void> signIn(context,
      {required String email,
      required String password,
      required UserViewModel userViewModel}) async {
    try {
      await _authRepository.signIn(email: email, password: password);
      setAuthenticated(true);
      await userViewModel.getUserFromFireStore(email);
      if (userViewModel.user.completedSignUp == false) {
        if (userViewModel.user.isPatient == true) {
          Navigator.of(context).pushNamed(RoutesName.patientAccount);
        } else {
          Navigator.of(context).pushNamed(RoutesName.doctorAccount);
        }
      } else {
        Navigator.of(context).pushNamed(RoutesName.home);
      }
      setErrorMessage("", true);
    } on FirebaseAuthException catch (error) {
      setAuthenticated(false);
      String message = "";
      switch (error.code) {
        case 'invalid-email':
          message = "INVALID EMAIL";
          debugPrint("INVALID EMAIL");
          break;
        case 'invalid-credential':
          message = "INVALID CREDENTIAL";
          debugPrint("INVALID CREDENTIAL");
          break;
        default:
          debugPrint(error.code);
      }
      setErrorMessage(message, true);
    }
  }

  Future<void> createAccount(context,
      {required String email,
      required String password,
      required bool? isPatient,
      required UserViewModel userViewModel}) async {
    try {
      await _authRepository.createAccount(email: email, password: password);
      setAuthenticated(true);
      userViewModel.newUserToFireStore();
      if (isPatient == true) {
        Navigator.of(context).pushNamed(RoutesName.patientAccount);
      } else {
        Navigator.of(context).pushNamed(RoutesName.doctorAccount);
      }
      setErrorMessage("", false);
    } on FirebaseAuthException catch (error) {
      setAuthenticated(false);
      String message = "";
      switch (error.code) {
        case 'email-already-in-use':
          message = "EMAIL ALREADY IN USE";
          debugPrint("EMAIL ALREADY IN USE");
          break;
        case 'invalid-email':
          message = "INVALID EMAIL";
          debugPrint("INVALID EMAIL");
          break;
        case 'weak-password':
          message = "WEAK PASSWORD";
          debugPrint("WEAK PASSWORD");
        default:
          debugPrint(error.code);
      }
      setErrorMessage(message, false);
    }
  }
}
