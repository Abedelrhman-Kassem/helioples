class User {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? birthdate;
  String? phone;

  User(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.birthdate,
      this.phone});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthdate = json['birthdate'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['birthdate'] = birthdate;
    data['phone'] = phone;
    return data;
  }
}