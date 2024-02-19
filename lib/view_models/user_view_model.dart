import 'package:flutter/cupertino.dart';
import 'package:senior_design/models/user_model.dart';
import 'package:senior_design/services/firestore_repository.dart';

class UserViewModel with ChangeNotifier {
  User _user = User();

  final FireStoreRepository _fireStoreRepository = FireStoreRepository();

  User get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = User();
    notifyListeners();
  }

  void setFirstName(String? firstName) {
    _user.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String? lastName) {
    _user.lastName = lastName;
    notifyListeners();
  }

  void setEmail(String? email) {
    _user.email = email;
    notifyListeners();
  }

  void setIsPatient(bool? isPatient) {
    _user.isPatient = isPatient;
    notifyListeners();
  }

  void setDateOfBirth(String? dateOfBirth) {
    _user.dateOfBirth = dateOfBirth;
    notifyListeners();
  }

  void setGender(String? gender) {
    _user.gender = gender;
    notifyListeners();
  }

  void setWeight(String? weight) {
    _user.weight = weight;
    notifyListeners();
  }

  void setHeight(String? height) {
    _user.height = height;
    notifyListeners();
  }

  void setInjuryType(String? injuryType) {
    _user.injuryType = injuryType;
    notifyListeners();
  }

  void setDateOfInjury(String? dateOfInjury) {
    _user.dateOfInjury = dateOfInjury;
    notifyListeners();
  }

  void setPastInjuries(String? pastInjuries) {
    _user.pastInjuries = pastInjuries;
    notifyListeners();
  }

  void setHospitalName(String? hospitalName) {
    _user.hospitalName = hospitalName;
    notifyListeners();
  }

  void setHospitalAddress(String? hospitalAddress) {
    _user.hospitalAddress = hospitalAddress;
    notifyListeners();
  }

  void setHospitalCity(String? hospitalCity) {
    _user.hospitalCity = hospitalCity;
    notifyListeners();
  }

  void setHospitalState(String? hospitalState) {
    _user.hospitalState = hospitalState;
    notifyListeners();
  }

  void setHospitalZipCode(String? hospitalZipCode) {
    _user.hospitalZipCode = hospitalZipCode;
    notifyListeners();
  }

  void setHospitalFloorRoom(String? hospitalFloorRoom) {
    _user.hospitalFloorRoom = hospitalFloorRoom;
    notifyListeners();
  }

  void setSpecialization(String? specialization) {
    _user.specialization = specialization;
    notifyListeners();
  }

  void setDoctorInfo(
      String? hospitalName,
      String? hospitalAddress,
      String? hospitalCity,
      String? hospitalState,
      String? hospitalZipCode,
      String? hospitalFloorRoom,
      String? specialization) {
    _user.hospitalName = hospitalName;
    _user.hospitalAddress = hospitalAddress;
    _user.hospitalCity = hospitalCity;
    _user.hospitalState = hospitalState;
    _user.hospitalZipCode = hospitalZipCode;
    _user.hospitalFloorRoom = hospitalFloorRoom;
    _user.specialization = specialization;
    _user.completedSignUp = true;
    notifyListeners();
  }

  void setPatientInfo(
      String? dateOfBirth,
      String? gender,
      String? weight,
      String? height,
      String? injuryType,
      String? dateOfInjury,
      String? pastInjuries) {
    _user.dateOfBirth = dateOfBirth;
    _user.gender = gender;
    _user.weight = weight;
    _user.height = height;
    _user.injuryType = injuryType;
    _user.dateOfInjury = dateOfInjury;
    _user.pastInjuries = pastInjuries;
    _user.totalWorkouts = 0;
    _user.completedSignUp = true;
    notifyListeners();
  }

  void setAccountInfo(
      String firstName, String lastName, String email, bool? isPatient) {
    _user.firstName = firstName;
    _user.lastName = lastName;
    _user.email = email;
    _user.isPatient = isPatient;
    notifyListeners();
  }

  void newUserToFireStore() {
    _fireStoreRepository.addNewUser(_user);
  }

  void updateUserInFireStore() {
    _fireStoreRepository.updateUser(_user);
  }

  Future<void> getUserFromFireStore(String email) async {
    User user = await _fireStoreRepository.fetchUser(email);
    setUser(user);
  }

  Future<List<Map<String, dynamic>>> fetchWorkoutData(int numberOfWorkouts) async{
    return await _fireStoreRepository.fetchWorkoutData(user, numberOfWorkouts);
  }
}
