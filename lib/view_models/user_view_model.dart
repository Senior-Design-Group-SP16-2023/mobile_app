import 'package:flutter/cupertino.dart';
import 'package:senior_design/models/user_model.dart';


class UserViewModel with ChangeNotifier {
  User _user = User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setFirstName(String firstName) {
    _user.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    _user.lastName = lastName;
    notifyListeners();
  }

  void setEmail(String email) {
    _user.email = email;
    notifyListeners();
  }

  void setIsPatient(bool isPatient) {
    _user.isPatient = isPatient;
    notifyListeners();
  }

  void setPassword(String password) {
    _user.password = password;
    notifyListeners();
  }




}