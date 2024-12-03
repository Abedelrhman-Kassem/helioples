class PromoCodeModel {
  PromoCode? promoCode;

  PromoCodeModel.fromJson(Map<String, dynamic> json) {
    promoCode = json['promoCode'] != null
        ? PromoCode.fromJson(json['promoCode'])
        : null;
  }
}

class PromoCode {
  int? id;
  String? code;
  String? name;
  int? amount;
  bool? isPercentage;
  int? durationDays;
  String? createdAt;
  String? updatedAt;

  PromoCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    amount = json['amount'];
    isPercentage = json['isPercentage'];
    durationDays = json['durationDays'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
