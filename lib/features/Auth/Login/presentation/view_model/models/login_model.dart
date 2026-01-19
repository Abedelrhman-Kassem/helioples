class LoginModel {
  final bool success;
  final String message;
  final LoginData? data;
  String? verificationId;
  String? phoneNumber;

  LoginModel({
    required this.success,
    required this.message,
    required this.data,
    required this.verificationId,
    required this.phoneNumber,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"] ?? false,
    message: json["message"] ?? "",
    data: json["data"] != null ? LoginData.fromJson(json["data"]) : null,
    verificationId: json["verificationId"] ?? '',
    phoneNumber: json["phoneNumber"] ?? '',
  );
}

class LoginData {
  final String? name;
  final String? lastname;
  final String? token;
  final String? birthdate;

  LoginData({this.name, this.lastname, this.token, this.birthdate});

  factory LoginData.fromJson(dynamic json) {
    if (json is String) {
      return LoginData(token: json);
    }
    return LoginData(
      name: json["name"],
      lastname: json["lastname"],
      token: json["token"],
      birthdate: json["birthdate"],
    );
  }
}
