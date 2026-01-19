/// Order delivery method enum
enum OrderDeliverMethod {
  onBranch, // 0
  delivery, // 1
}

/// Order payment method enum
enum OrderPaymentMethod {
  cashOnDelivery, // 0
  cardOnDelivery, // 1
  card, // 2
}

/// Alternative product handling enum
enum AlternativeProductType {
  call, // 0
  remove, // 1
}

/// Extension to convert OrderDeliverMethod to API string
extension OrderDeliverMethodExtension on OrderDeliverMethod {
  String toApiString() {
    switch (this) {
      case OrderDeliverMethod.onBranch:
        return 'OnBranch';
      case OrderDeliverMethod.delivery:
        return 'Delivery';
    }
  }

  int toApiInt() {
    switch (this) {
      case OrderDeliverMethod.onBranch:
        return 0;
      case OrderDeliverMethod.delivery:
        return 1;
    }
  }
}

/// Extension to convert OrderPaymentMethod to API string
extension OrderPaymentMethodExtension on OrderPaymentMethod {
  String toApiString() {
    switch (this) {
      case OrderPaymentMethod.cashOnDelivery:
        return 'cashOnDelivery';
      case OrderPaymentMethod.cardOnDelivery:
        return 'cardOnDelivery';
      case OrderPaymentMethod.card:
        return 'card';
    }
  }

  int toApiInt() {
    switch (this) {
      case OrderPaymentMethod.cashOnDelivery:
        return 1;
      case OrderPaymentMethod.cardOnDelivery:
        return 2;
      case OrderPaymentMethod.card:
        return 3;
    }
  }
}

/// Extension to convert AlternativeProductType to API string
extension AlternativeProductTypeExtension on AlternativeProductType {
  String toApiString() {
    switch (this) {
      case AlternativeProductType.call:
        return 'call';
      case AlternativeProductType.remove:
        return 'remove';
    }
  }

  int toApiInt() {
    switch (this) {
      case AlternativeProductType.call:
        return 0;
      case AlternativeProductType.remove:
        return 1;
    }
  }
}

class CreateOrderModel {
  OrderDeliverMethod? deliverMethod;
  OrderPaymentMethod? paymentMethod;
  double? tips;
  AlternativeProductType? alternativeProduct;
  String? branchId;
  String? addressId;
  UseOnceAddress? useOnceAddress;
  bool? chooseForMe;
  String? promoCodeId;
  String? deliverTimeIntervalId;
  String? pickupTimeId;
  String? arriveTime;
  String? reason;
  List<Item>? items;

  CreateOrderModel({
    this.deliverMethod,
    this.paymentMethod,
    this.tips,
    this.alternativeProduct,
    this.branchId,
    this.addressId,
    this.useOnceAddress,
    this.chooseForMe,
    this.promoCodeId,
    this.deliverTimeIntervalId,
    this.pickupTimeId,
    this.arriveTime,
    this.reason,
    this.items,
  });

  /// Check if this is a delivery order
  bool get isDelivery => deliverMethod == OrderDeliverMethod.delivery;

  Map<String, dynamic> toDeliveryJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['deliverMethod'] = deliverMethod?.toApiInt();
    if (addressId != null) {
      data['addressId'] = addressId;
    }
    if (useOnceAddress != null) {
      data['useOnceAddress'] = useOnceAddress!.toJson();
    } else {
      data['useOnceAddress'] = null;
    }
    data['deliverTimeIntervalId'] = deliverTimeIntervalId;
    data['paymentMethod'] = paymentMethod?.toApiInt();
    data['tips'] = tips ?? 0;
    if (promoCodeId != null) {
      data['promoCodeId'] = promoCodeId;
    }
    data['chooseForMe'] = chooseForMe ?? false;
    data['alternativeProduct'] = alternativeProduct?.toApiInt();
    if (arriveTime != null) {
      data['arriveTime'] = arriveTime;
    }
    if (reason != null) {
      data['reason'] = reason;
    }
    return data;
  }

  Map<String, dynamic> toPickUpJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['deliverMethod'] = deliverMethod?.toApiInt();
    data['paymentMethod'] = paymentMethod?.toApiInt();
    data['branchId'] = branchId;
    if (pickupTimeId != null) {
      data['pickupTimeId'] = pickupTimeId;
    }
    if (promoCodeId != null) {
      data['promoCodeId'] = promoCodeId;
    }
    data['chooseForMe'] = chooseForMe ?? false;
    data['alternativeProduct'] = alternativeProduct?.toApiInt();
    if (arriveTime != null) {
      data['arriveTime'] = arriveTime;
    }
    if (reason != null) {
      data['reason'] = reason;
    }
    return data;
  }
}

class UseOnceAddress {
  double? latitude;
  double? longitude;
  String? locationStr;

  UseOnceAddress({this.latitude, this.longitude, this.locationStr});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['locationStr'] = locationStr;
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
