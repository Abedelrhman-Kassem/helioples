// ignore: file_names
class Faqs {
  int? id;
  bool? arabic;
  String? question;
  String? answer;
  String? createdAt;

  Faqs({this.id, this.arabic, this.question, this.answer, this.createdAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arabic = json['arabic'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arabic'] = this.arabic;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['createdAt'] = this.createdAt;
    return data;
  }
}