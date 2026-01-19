class CustomerModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? birthdate;
  final String? phone;
  final String? image;

  CustomerModel({
    this.id,
    this.firstName,
    this.lastName,
    this.birthdate,
    this.phone,
    this.image,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      birthdate: json['birthdate'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate,
    };
  }
}
