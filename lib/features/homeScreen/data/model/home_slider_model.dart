class HomeSliderModel {
  HomeSliderModel({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final DataSlider? data;
  final int? statusCode;
  final dynamic errors;

  factory HomeSliderModel.fromJson(Map<String, dynamic> json) {
    return HomeSliderModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : DataSlider.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class DataSlider {
  DataSlider({
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.itemSlider,
  });

  final int? page;
  final int? pageSize;
  final int? totalCount;
  final int? totalPages;
  final List<ItemSlider> itemSlider;

  factory DataSlider.fromJson(Map<String, dynamic> json) {
    return DataSlider(
      page: json["page"],
      pageSize: json["pageSize"],
      totalCount: json["totalCount"],
      totalPages: json["totalPages"],
      itemSlider: json["items"] == null
          ? []
          : List<ItemSlider>.from(
              json["items"]!.map((x) => ItemSlider.fromJson(x))),
    );
  }
}

class ItemSlider {
  ItemSlider({
    required this.id,
    required this.active,
    required this.imageUrl,
    required this.sortOrder,
    required this.actionType,
    required this.targetId,
  });

  final String? id;
  final bool? active;
  final String? imageUrl;
  final int? sortOrder;
  final int? actionType;
  final dynamic targetId;

  factory ItemSlider.fromJson(Map<String, dynamic> json) {
    return ItemSlider(
      id: json["id"],
      active: json["active"],
      imageUrl: json["imageUrl"],
      sortOrder: json["sortOrder"],
      actionType: json["actionType"],
      targetId: json["targetId"],
    );
  }
}
