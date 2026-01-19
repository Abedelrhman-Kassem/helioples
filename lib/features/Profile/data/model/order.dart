class Order {
  String? id;
  int? userId;
  DateTime? arriveTime;
  double? tips;
  String? alternativeProduct;
  double? subTotal;
  double? vat;
  double? deliveryFees;
  double? promoCodeDiscount;
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

  Order({
    this.id,
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
    this.createdAt,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    arriveTime = json['arriveTime'];
    tips = (json['tips'] != null) ? json['tips'] * 1.0 : 0;
    alternativeProduct = json['alternativeProduct'];
    subTotal = (json['subTotal'] != null) ? json['subTotal'] * 1.0 : 0;
    vat = (json['vat'] != null) ? json['vat'] * 1.0 : 0;
    deliveryFees = (json['deliveryFees'] != null)
        ? json['deliveryFees'] * 1.0
        : 0;
    promoCodeDiscount = (json['promoCodeDiscount'] != null)
        ? json['promoCodeDiscount'] * 1.0
        : 0;
    total = (json['total'] != null) ? json['total'] * 1.0 : 0;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['arriveTime'] = arriveTime;
    data['tips'] = tips;
    data['alternativeProduct'] = alternativeProduct;
    data['subTotal'] = subTotal;
    data['vat'] = vat;
    data['deliveryFees'] = deliveryFees;
    data['promoCodeDiscount'] = promoCodeDiscount;
    data['total'] = total;
    data['paymentMethod'] = paymentMethod;
    data['paid'] = paid;
    data['promoCodeId'] = promoCodeId;
    data['clientOrderState'] = clientOrderState;
    data['adminOrderState'] = adminOrderState;
    data['addressId'] = addressId;
    data['deliverMethod'] = deliverMethod;
    data['updatedAt'] = updatedAt;
    data['createdAt'] = createdAt;
    return data;
  }
}
