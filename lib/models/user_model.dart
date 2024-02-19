class User {
  String? firstName;
  String? lastName;
  String? email;
  bool? isPatient;
  String? dateOfBirth;
  String? gender;
  String? weight;
  String? height;
  String? injuryType;
  String? dateOfInjury;
  String? pastInjuries;
  int? totalWorkouts;
  String? hospitalName;
  String? hospitalAddress;
  String? hospitalCity;
  String? hospitalState;
  String? hospitalZipCode;
  String? hospitalFloorRoom;
  String? specialization;
  bool completedSignUp = false;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.isPatient,
    this.dateOfBirth,
    this.gender,
    this.weight,
    this.height,
    this.injuryType,
    this.dateOfInjury,
    this.pastInjuries,
    this.totalWorkouts,
    this.hospitalName,
    this.hospitalAddress,
    this.hospitalCity,
    this.hospitalState,
    this.hospitalZipCode,
    this.hospitalFloorRoom,
    this.specialization,
  });

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    isPatient = json['isPatient'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    weight = json['weight'];
    height = json['height'];
    injuryType = json['injuryType'];
    dateOfInjury = json['dateOfInjury'];
    pastInjuries = json['pastInjuries'];
    totalWorkouts = json['totalWorkouts'];
    hospitalName = json['hospitalName'];
    hospitalAddress = json['hospitalAddress'];
    hospitalCity = json['hospitalCity'];
    hospitalState = json['hospitalState'];
    hospitalZipCode = json['hospitalZipCode'];
    hospitalFloorRoom = json['hospitalFloorRoom'];
    specialization = json['specialization'];
    completedSignUp = json['completedSignUp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['isPatient'] = isPatient;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['weight'] = weight;
    data['height'] = height;
    data['injuryType'] = injuryType;
    data['dateOfInjury'] = dateOfInjury;
    data['pastInjuries'] = pastInjuries;
    data['totalWorkouts'] = totalWorkouts;
    data['hospitalName'] = hospitalName;
    data['hospitalAddress'] = hospitalAddress;
    data['hospitalCity'] = hospitalCity;
    data['hospitalState'] = hospitalState;
    data['hospitalZipCode'] = hospitalZipCode;
    data['hospitalFloorRoom'] = hospitalFloorRoom;
    data['specialization'] = specialization;
    data['completedSignUp'] = completedSignUp;
    return data;
  }
}
