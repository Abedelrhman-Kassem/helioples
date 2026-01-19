class OrderDetailsModel {
  bool? success;
  String? message;
  OrderDetailsData? data;
  int? statusCode;
  dynamic errors;

  OrderDetailsModel({
    this.success,
    this.message,
    this.data,
    this.statusCode,
    this.errors,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? OrderDetailsData.fromJson(json['data'])
        : null;
    statusCode = json['statusCode'];
    errors = json['errors'];
  }
}

class OrderDetailsData {
  String? id;
  String? userId;
  String? user;
  String? orderNumber;
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
  String? promoCodeId;
  String? promoCode;
  String? reason;
  String? clientOrderState;
  String? adminOrderState;
  String? addressId;
  String? address;
  String? deliverMethod;
  String? deliverTimeIntervalId;
  String? branchId;
  String? branch;
  String? pickupTimeId;
  List<OrderItem>? items;

  OrderDetailsData({
    this.id,
    this.userId,
    this.user,
    this.orderNumber,
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
    this.promoCode,
    this.reason,
    this.clientOrderState,
    this.adminOrderState,
    this.addressId,
    this.address,
    this.deliverMethod,
    this.deliverTimeIntervalId,
    this.branchId,
    this.branch,
    this.pickupTimeId,
    this.items,
  });

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'];
    orderNumber = json['orderNumber'];
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
    promoCode = json['promoCode'];
    reason = json['reason'];
    clientOrderState = json['clientOrderState'];
    adminOrderState = json['adminOrderState'];
    addressId = json['addressId'];
    address = json['address'];
    deliverMethod = json['deliverMethod'];
    deliverTimeIntervalId = json['deliverTimeIntervalId'];
    branchId = json['branchId'];
    branch = json['branch'];
    pickupTimeId = json['pickupTimeId'];
    if (json['items'] != null) {
      items = <OrderItem>[];
      json['items'].forEach((v) {
        items!.add(OrderItem.fromJson(v));
      });
    }
  }
}

class OrderItem {
  String? id;
  String? productId;
  String? product;
  double? priceWhenOrdered;
  int? number;
  String? orderId;
  String? thumbnailImage;

  OrderItem({
    this.id,
    this.productId,
    this.product,
    this.priceWhenOrdered,
    this.number,
    this.orderId,
    this.thumbnailImage,
  });

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    product = json['product'];
    priceWhenOrdered = (json['priceWhenOrdered'] ?? 0) * 1.0;
    number = json['number'];
    orderId = json['orderId'];
    thumbnailImage = json['thumbnailImage'];
  }
}
