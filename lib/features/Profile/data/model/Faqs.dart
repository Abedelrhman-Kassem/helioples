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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arabic'] = arabic;
    data['question'] = question;
    data['answer'] = answer;
    data['createdAt'] = createdAt;
    return data;
  }
}
