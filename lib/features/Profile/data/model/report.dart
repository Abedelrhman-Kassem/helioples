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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['message'] = this.message;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}