class OrderHistory {
  OrderHistory({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final dynamic message;
  final OrderHistoryData? data;
  final int? statusCode;
  final dynamic errors;

  factory OrderHistory.fromJson(Map<String, dynamic> json) {
    return OrderHistory(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : OrderHistoryData.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class OrderHistoryData {
  OrderHistoryData({
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.items,
  });

  final int? page;
  final int? pageSize;
  final int? totalCount;
  final int? totalPages;
  final List<ItemHistory> items;

  factory OrderHistoryData.fromJson(Map<String, dynamic> json) {
    return OrderHistoryData(
      page: json["page"],
      pageSize: json["pageSize"],
      totalCount: json["totalCount"],
      totalPages: json["totalPages"],
      items: json["items"] == null
          ? []
          : List<ItemHistory>.from(
              json["items"]!.map((x) => ItemHistory.fromJson(x)),
            ),
    );
  }
}

class ItemHistory {
  ItemHistory({
    required this.id,
    required this.createdAt,
    required this.arriveTime,
    required this.alternativeProduct,
    required this.total,
    required this.paymentMethod,
    required this.paid,
    required this.clientOrderState,
    required this.address,
    required this.deliverMethod,
    required this.branch,
    required this.itemsCount,
  });

  final String? id;
  final DateTime? createdAt;
  final dynamic arriveTime;
  final String? alternativeProduct;
  final double? total;
  final String? paymentMethod;
  final bool? paid;
  final String? clientOrderState;
  final String? address;
  final String? deliverMethod;
  final String? branch;
  final int? itemsCount;

  factory ItemHistory.fromJson(Map<String, dynamic> json) {
    return ItemHistory(
      id: json["id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      arriveTime: json["arriveTime"],
      alternativeProduct: json["alternativeProduct"],
      total: json["total"],
      paymentMethod: json["paymentMethod"],
      paid: json["paid"],
      clientOrderState: json["clientOrderState"],
      address: json["address"] ?? json["branch"],
      deliverMethod: json["deliverMethod"].toString(),
      branch: json["branch"],
      itemsCount: json["itemsCount"],
    );
  }
}
