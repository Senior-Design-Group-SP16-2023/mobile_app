import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:senior_design/services/auth_repository.dart';
import 'package:senior_design/utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  void setAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

  final _authRepository = AuthRepository();

  Future<void> signIn(context, {required String email, required String password}) async {
    try{
      await _authRepository.signIn(email: email, password: password);
      setAuthenticated(true);
      Navigator.of(context).pushNamed(RoutesName.home);
    } on FirebaseAuthException catch (error){
      setAuthenticated(false);
      switch(error.code){
        case 'invalid-email':
          debugPrint("INVALID EMAIL");
          break;
        case 'invalid-credential':
          debugPrint("INVALID CREDENTIAL");
          break;
        default:
          debugPrint(error.code);
      }
    }
  }

  Future<void> createAccount(context, {required String email, required String password, required bool? isPatient}) async {
    try {
      await _authRepository.createAccount(email: email, password: password);
      setAuthenticated(true);
      if(isPatient == true) {
        Navigator.of(context).pushNamed(RoutesName.patientAccount);
      } else {
        Navigator.of(context).pushNamed(RoutesName.doctorAccount);
      }
    } on FirebaseAuthException catch (error) {
      setAuthenticated(false);
      switch (error.code) {
        case 'email-already-in-use':
          debugPrint("EMAIL ALREADY IN USE");
          break;
        case 'invalid-email':
          debugPrint("INVALID EMAIL");
          break;
        case 'weak-password':
          debugPrint("WEAK PASSWORD");
        default:
          debugPrint(error.code);
      }
    }
  }
}
