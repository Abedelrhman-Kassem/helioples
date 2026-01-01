class CreateOrderModel {
  String? deliverMethod;
  String? paymentMethod;
  double? tips;
  String? alternativeProduct;
  String? branchId;
  String? addressId;
  bool? chooseForMe;
  String? promoCode;
  String? deliverTimeId;
  List<Item>? items;

  CreateOrderModel({
    this.deliverMethod,
    this.paymentMethod,
    this.tips,
    this.alternativeProduct,
    this.branchId,
    this.addressId,
    this.chooseForMe,
    this.promoCode,
    this.deliverTimeId,
    this.items,
  });

  Map<String, dynamic> toDeliveryJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliverMethod'] = deliverMethod;
    data['paymentMethod'] = paymentMethod;
    data['tips'] = tips;
    data['alternativeProduct'] = alternativeProduct;
    data['addressId'] = addressId;
    data['chooseForMe'] = chooseForMe;
    data['promoCode'] = promoCode;
    data['deliverTimeId'] = deliverTimeId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toPickUpJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliverMethod'] = deliverMethod;
    data['paymentMethod'] = paymentMethod;
    data['alternativeProduct'] = alternativeProduct;
    data['branchId'] = branchId;
    data['chooseForMe'] = chooseForMe;
    data['promoCode'] = promoCode;
    // data['deliverTimeId'] = deliverTimeId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Item {
  late String productId;
  late int number;

  Item({required this.productId, required this.number});

  Item.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['number'] = number;
    return data;
  }
}
