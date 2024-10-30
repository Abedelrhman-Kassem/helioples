class OrderDetails {
  int? id;
  int? userId;
  Null? arriveTime;
  int? tips;
  Null? alternativeProduct;
  double? subTotal;
  int? vat;
  int? deliveryFees;
  int? promoCodeDiscount;
  double? total;
  String? paymentMethod;
  bool? paid;
  bool? chooseForMe;
  Null? promoCodeId;
  String? clientOrderState;
  String? adminOrderState;
  Null? addressId;
  String? deliverMethod;
  String? updatedAt;
  String? createdAt;
  Null? branchId;
  Null? promoCode;
  Null? address;
  List<Items>? items;

  OrderDetails(
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
      this.chooseForMe,
      this.promoCodeId,
      this.clientOrderState,
      this.adminOrderState,
      this.addressId,
      this.deliverMethod,
      this.updatedAt,
      this.createdAt,
      this.branchId,
      this.promoCode,
      this.address,
      this.items});

  OrderDetails.fromJson(Map<String, dynamic> json) {
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
    chooseForMe = json['chooseForMe'];
    promoCodeId = json['promoCodeId'];
    clientOrderState = json['clientOrderState'];
    adminOrderState = json['adminOrderState'];
    addressId = json['addressId'];
    deliverMethod = json['deliverMethod'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
    branchId = json['branchId'];
    promoCode = json['promoCode'];
    address = json['address'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
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
    data['chooseForMe'] = this.chooseForMe;
    data['promoCodeId'] = this.promoCodeId;
    data['clientOrderState'] = this.clientOrderState;
    data['adminOrderState'] = this.adminOrderState;
    data['addressId'] = this.addressId;
    data['deliverMethod'] = this.deliverMethod;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    data['branchId'] = this.branchId;
    data['promoCode'] = this.promoCode;
    data['address'] = this.address;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  double? priceWhenOrdered;
  int? number;
  int? orderId;
  int? productId;

  Items(
      {this.id,
      this.priceWhenOrdered,
      this.number,
      this.orderId,
      this.productId});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceWhenOrdered = json['priceWhenOrdered'];
    number = json['number'];
    orderId = json['orderId'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['priceWhenOrdered'] = this.priceWhenOrdered;
    data['number'] = this.number;
    data['orderId'] = this.orderId;
    data['productId'] = this.productId;
    return data;
  }
}