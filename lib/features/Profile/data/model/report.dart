class Report {
  String? message;
  String? imageUrl;

  Report({this.message, this.imageUrl});

  Report.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    imageUrl = json['Image'];
  }
}
