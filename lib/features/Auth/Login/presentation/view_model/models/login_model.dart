class LoginModel {
  final bool success;
  final String message;
  final String? data;
  String? verificationId;
  String? phoneNumber;

  LoginModel(
      {required this.success,
      required this.message,
      required this.data,
      required this.verificationId,
      required this.phoneNumber});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        data: json["data"],
        verificationId: json["verificationId"] ?? '',
        phoneNumber: json["phoneNumber"] ?? '',
      );
}
