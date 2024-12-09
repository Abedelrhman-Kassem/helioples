class OrderDetailsModel {
  Order? order;
  String? error;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    error = json['error'];
  }
}

class Order {
  int? id;
  int? userId;
  String? arriveTime;
  double? tips;
  String? alternativeProduct;
  double? subTotal;
  double? vat;
  double? deliveryFees;
  double? promoCodeDiscount;
  double? total;
  String? paymentMethod;
  bool? paid;
  bool? chooseForMe;
  int? promoCodeId;
  String? reason;
  String? clientOrderState;
  String? adminOrderState;
  int? addressId;
  String? deliverMethod;
  String? updatedAt;
  String? createdAt;
  int? branchId;
  int? deliverTimeIntervalId;

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    arriveTime = json['arriveTime'];
    tips = (json['tips'] ?? 0) * 1.0;
    alternativeProduct = json['alternativeProduct'];
    subTotal = (json['subTotal'] ?? 0) * 1.0;
    vat = (json['vat'] ?? 0) * 1.0;
    deliveryFees = (json['deliveryFees'] ?? 0) * 1.0;
    promoCodeDiscount = (json['promoCodeDiscount'] ?? 0) * 1.0;
    total = (json['total'] ?? 0) * 1.0;
    paymentMethod = json['paymentMethod'];
    paid = json['paid'];
    chooseForMe = json['chooseForMe'];
    promoCodeId = json['promoCodeId'];
    reason = json['reason'];
    clientOrderState = json['clientOrderState'];
    adminOrderState = json['adminOrderState'];
    addressId = json['addressId'];
    deliverMethod = json['deliverMethod'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    branchId = json['branchId'];
    deliverTimeIntervalId = json['deliverTimeIntervalId'];
  }
}
