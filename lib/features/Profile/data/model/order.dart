import 'dart:ffi';

class Order {
  int? id;
  int? userId;
  DateTime? arriveTime;
  int? tips;
  String? alternativeProduct;
  double? subTotal;
  int? vat;
  int? deliveryFees;
  int? promoCodeDiscount;
  double? total;
  String? paymentMethod;
  bool? paid;
  int? promoCodeId;
  String? clientOrderState;
  String? adminOrderState;
  int? addressId;
  String? deliverMethod;
  String? updatedAt;
  String? createdAt;

  Order(
      {this.id,
      this.userId,
      this.arriveTime,
      this.tips,
      this.alternativeProduct,
      this.subTotal,
      this.vat,
      this.deliveryFees,
      this.promoCodeDiscount,
      this.total,
      this.paymentMethod,
      this.paid,
      this.promoCodeId,
      this.clientOrderState,
      this.adminOrderState,
      this.addressId,
      this.deliverMethod,
      this.updatedAt,
      this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['arriveTime'] = this.arriveTime;
    data['tips'] = this.tips;
    data['alternativeProduct'] = this.alternativeProduct;
    data['subTotal'] = this.subTotal;
    data['vat'] = this.vat;
    data['deliveryFees'] = this.deliveryFees;
    data['promoCodeDiscount'] = this.promoCodeDiscount;
    data['total'] = this.total;
    data['paymentMethod'] = this.paymentMethod;
    data['paid'] = this.paid;
    data['promoCodeId'] = this.promoCodeId;
    data['clientOrderState'] = this.clientOrderState;
    data['adminOrderState'] = this.adminOrderState;
    data['addressId'] = this.addressId;
    data['deliverMethod'] = this.deliverMethod;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}