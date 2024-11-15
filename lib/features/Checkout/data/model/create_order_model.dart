class CreateOrderModel {
  String? deliverMethod;
  String? paymentMethod;
  double? tips;
  String? alternativeProduct;
  String? branchId;
  int? addressId;
  bool? chooseForMe;
  String? promoCode;
  List<Items>? items;

  CreateOrderModel({
    this.deliverMethod,
    this.paymentMethod,
    this.tips,
    this.alternativeProduct,
    this.branchId,
    this.addressId,
    this.chooseForMe,
    this.promoCode,
    this.items,
  });

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    deliverMethod = json['deliverMethod'];
    paymentMethod = json['paymentMethod'];
    tips = json['tips'];
    alternativeProduct = json['alternativeProduct'];
    branchId = json['branchId'];
    addressId = json['addressId'];
    chooseForMe = json['chooseForMe'];
    promoCode = json['promoCode'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliverMethod'] = deliverMethod;
    data['paymentMethod'] = paymentMethod;
    data['tips'] = tips;
    data['alternativeProduct'] = alternativeProduct;
    data['branchId'] = branchId;
    data['addressId'] = addressId;
    data['chooseForMe'] = chooseForMe;
    data['promoCode'] = promoCode;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  late int productId;
  late int number;

  Items({required this.productId, required this.number});

  Items.fromJson(Map<String, dynamic> json) {
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
