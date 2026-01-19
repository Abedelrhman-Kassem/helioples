class FaqsModel {
  FaqsModel({required this.data});

  final List<FaqsData> data;

  factory FaqsModel.fromJson(Map<String, dynamic> json) {
    return FaqsModel(
      data: json["data"] == null
          ? []
          : List<FaqsData>.from(json["data"]!.map((x) => FaqsData.fromJson(x))),
    );
  }
}

class FaqsData {
  String? id;
  String? question;
  String? answer;

  FaqsData({this.id, this.question, this.answer});

  FaqsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}
