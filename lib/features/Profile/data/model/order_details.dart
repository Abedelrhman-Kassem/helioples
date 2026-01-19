class OrderDetails {
  OrderDetails({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final dynamic message;
  final OrderDetailsData? data;
  final int? statusCode;
  final dynamic errors;

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : OrderDetailsData.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class OrderDetailsData {
  OrderDetailsData({
    required this.id,
    required this.userId,
    required this.user,
    required this.orderNumber,
    required this.arriveTime,
    required this.tips,
    required this.alternativeProduct,
    required this.subTotal,
    required this.vat,
    required this.deliveryFees,
    required this.promoCodeDiscount,
    required this.total,
    required this.paymentMethod,
    required this.paid,
    required this.chooseForMe,
    required this.promoCodeId,
    required this.promoCode,
    required this.reason,
    required this.clientOrderState,
    required this.adminOrderState,
    required this.addressId,
    required this.address,
    required this.deliverMethod,
    required this.states,
    required this.deliverTimeIntervalId,
    required this.deliverTimeInterval,
    required this.useOnceAddress,
    required this.branchId,
    required this.branch,
    required this.pickupTimeId,
    required this.pickupTime,
    required this.items,
  });

  final String? id;
  final String? userId;
  final String? user;
  final String? orderNumber;
  final dynamic arriveTime;
  final double? tips;
  final String? alternativeProduct;
  final double? subTotal;
  final double? vat;
  final double? deliveryFees;
  final double? promoCodeDiscount;
  final double? total;
  final String? paymentMethod;
  final bool? paid;
  final bool? chooseForMe;
  final dynamic promoCodeId;
  final String? promoCode;
  final dynamic reason;
  final String? clientOrderState;
  final String? adminOrderState;
  final String? addressId;
  final String? address;
  final String? deliverMethod;
  final dynamic states;
  final String? deliverTimeIntervalId;
  final String? deliverTimeInterval;
  final dynamic useOnceAddress;
  final String? branchId;
  final String? branch;
  final dynamic pickupTimeId;
  final String? pickupTime;
  final List<Item> items;

  factory OrderDetailsData.fromJson(Map<String, dynamic> json) {
    return OrderDetailsData(
      id: json["id"],
      userId: json["userId"],
      user: json["user"],
      orderNumber: json["orderNumber"],
      arriveTime: json["arriveTime"],
      tips: json["tips"]?.toDouble(),
      alternativeProduct: json["alternativeProduct"],
      subTotal: json["subTotal"]?.toDouble(),
      vat: json["vat"]?.toDouble(),
      deliveryFees: json["deliveryFees"]?.toDouble(),
      promoCodeDiscount: json["promoCodeDiscount"]?.toDouble(),
      total: json["total"]?.toDouble(),
      paymentMethod: json["paymentMethod"],
      paid: json["paid"],
      chooseForMe: json["chooseForMe"],
      promoCodeId: json["promoCodeId"],
      promoCode: json["promoCode"],
      reason: json["reason"],
      clientOrderState: json["clientOrderState"],
      adminOrderState: json["adminOrderState"],
      addressId: json["addressId"],
      address: json["address"],
      deliverMethod: json["deliverMethod"],
      states: json["states"],
      deliverTimeIntervalId: json["deliverTimeIntervalId"],
      deliverTimeInterval: json["deliverTimeInterval"],
      useOnceAddress: json["useOnceAddress"],
      branchId: json["branchId"],
      branch: json["branch"],
      pickupTimeId: json["pickupTimeId"],
      pickupTime: json["pickupTime"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }
}

class Item {
  Item({
    required this.id,
    required this.productId,
    required this.product,
    required this.priceWhenOrdered,
    required this.number,
    required this.orderId,
    required this.order,
    required this.thumbnailImage,
  });

  final String? id;
  final String? productId;
  final String? product;
  final int? priceWhenOrdered;
  final int? number;
  final String? orderId;
  final dynamic order;
  final String? thumbnailImage;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      productId: json["productId"],
      product: json["product"],
      priceWhenOrdered: json["priceWhenOrdered"],
      number: json["number"],
      orderId: json["orderId"],
      order: json["order"],
      thumbnailImage: json["thumbnailImage"],
    );
  }
}
