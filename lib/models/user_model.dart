class User {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  bool? isPatient;
  String? dateOfBirth;
  String? gender;
  String? weight;
  String? height;
  String? injuryType;
  String? dateOfInjury;
  String? pastInjuries;
  String? hospitalName;
  String? hospitalAddress;
  String? hospitalCity;
  String? hospitalState;
  String? hospitalZipCode;
  String? hospitalFloorRoom;
  String? specialization;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isPatient,
    this.dateOfBirth,
    this.gender,
    this.weight,
    this.height,
    this.injuryType,
    this.dateOfInjury,
    this.pastInjuries,
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
    password = json['password'];
    isPatient = json['isPatient'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    weight = json['weight'];
    height = json['height'];
    injuryType = json['injuryType'];
    dateOfInjury = json['dateOfInjury'];
    pastInjuries = json['pastInjuries'];
    hospitalName = json['hospitalName'];
    hospitalAddress = json['hospitalAddress'];
    hospitalCity = json['hospitalCity'];
    hospitalState = json['hospitalState'];
    hospitalZipCode = json['hospitalZipCode'];
    hospitalFloorRoom = json['hospitalFloorRoom'];
    specialization = json['specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['isPatient'] = isPatient;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['weight'] = weight;
    data['height'] = height;
    data['injuryType'] = injuryType;
    data['dateOfInjury'] = dateOfInjury;
    data['pastInjuries'] = pastInjuries;
    data['hospitalName'] = hospitalName;
    data['hospitalAddress'] = hospitalAddress;
    data['hospitalCity'] = hospitalCity;
    data['hospitalState'] = hospitalState;
    data['hospitalZipCode'] = hospitalZipCode;
    data['hospitalFloorRoom'] = hospitalFloorRoom;
    data['specialization'] = specialization;
    return data;
  }
}
