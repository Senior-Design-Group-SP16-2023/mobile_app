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

  Future<void> login(context, dynamic dataToBeProvided) async {
    _authRepository.login(dataToBeProvided).then((value) {
      if (value == 'success') {
        setAuthenticated(true);
        Navigator.of(context).pushNamed(RoutesName.home);
      } else{
      }
    }).onError((error, stackTrace) {
      setAuthenticated(false);
      debugPrint(error.toString());
    });
  }
}
