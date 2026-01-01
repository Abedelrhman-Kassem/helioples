class BranchesModel {
  BranchesModel({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final int? statusCode;
  final dynamic errors;

  factory BranchesModel.fromJson(Map<String, dynamic> json) {
    return BranchesModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      statusCode: json["statusCode"],
      errors: json["errors"],
    );
  }
}

class Data {
  Data({
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
  final List<Branches> items;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      page: json["page"],
      pageSize: json["pageSize"],
      totalCount: json["totalCount"],
      totalPages: json["totalPages"],
      items: json["items"] == null
          ? []
          : List<Branches>.from(
              json["items"]!.map((x) => Branches.fromJson(x)),
            ),
    );
  }
}

class Branches {
  Branches({
    required this.id,
    required this.name,
    required this.branchZone,
    required this.longitude,
    required this.latitude,
    required this.locationStr,
  });

  final String? id;
  final String? name;
  final dynamic branchZone;
  final double? longitude;
  final double? latitude;
  final String? locationStr;

  factory Branches.fromJson(Map<String, dynamic> json) {
    return Branches(
      id: json["id"],
      name: json["name"],
      branchZone: json["branchZone"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      locationStr: json["locationStr"],
    );
  }
}
