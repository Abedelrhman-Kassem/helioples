class OrderDetailsModel {
  OrderModel? order;
  String? error;

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? OrderModel.fromJson(json['order']) : null;
    error = json['error'];
  }
}

class OrderModel {
  int? id;
  int? userId;
  dynamic arriveTime;
  int? tips;
  dynamic alternativeProduct;
  double? subTotal;
  int? vat;
  int? deliveryFees;
  int? promoCodeDiscount;
  double? total;
  String? paymentMethod;
  bool? paid;
  String? promoCodeId;
  String? clientOrderState;
  String? adminOrderState;
  int? addressId;
  String? deliverMethod;
  String? updatedAt;
  String? createdAt;

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    arriveTime = json['arriveTime'];
    tips = json['tips'];
    alternativeProduct = json['alternativeProduct'];
    subTotal = json['subTotal'];
    vat = json['vat'];
    deliveryFees = json['deliveryFees'];
    promoCodeDiscount = json['promoCodeDiscount'];
    total = json['total'];
    paymentMethod = json['paymentMethod'];
    paid = json['paid'];
    promoCodeId = json['promoCodeId'];
    clientOrderState = json['clientOrderState'];
    adminOrderState = json['adminOrderState'];
    addressId = json['addressId'];
    deliverMethod = json['deliverMethod'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }
}
