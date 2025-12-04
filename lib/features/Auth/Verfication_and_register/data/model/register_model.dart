class RegisterModel {
  final String firstName;
  final String lastName;
  final String birthdate;
  final String phone;
  final String? image;

  RegisterModel(
      {required this.firstName,
      required this.lastName,
      required this.birthdate,
      required this.phone,
      this.image});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthdate: json['birthdate'],
      phone: json['phone'],
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['birthdate'] = birthdate;
    data['phone'] = phone;
    data['image'] = image ?? '';
    return data;
  }
}
