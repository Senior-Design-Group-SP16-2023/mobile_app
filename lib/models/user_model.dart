class User {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  bool? isPatient;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isPatient,
  });

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    isPatient = json['isPatient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['password'] = password;
    data['isPatient'] = isPatient;
    return data;
  }






}