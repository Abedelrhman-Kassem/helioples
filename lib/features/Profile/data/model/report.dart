class Report {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? message;
  String? imageUrl;

  Report(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.message,
      this.imageUrl});

  Report.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    message = json['message'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phoneNumber'] = phoneNumber;
    data['message'] = message;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
