class AllCategoriesModel {
  bool? success;
  String? message;
  CategoriesData? data;

  AllCategoriesModel({this.success, this.message, this.data});

  List<CategoryModel> get categories => data?.items ?? [];

  AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CategoriesData.fromJson(json['data']) : null;
  }
}

class CategoriesData {
  int? page;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<CategoryModel>? items;

  CategoriesData({
    this.page,
    this.pageSize,
    this.totalCount,
    this.totalPages,
    this.items,
  });

  CategoriesData.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = <CategoryModel>[];
      json['items'].forEach((v) {
        items!.add(CategoryModel.fromJson(v));
      });
    }
  }
}

class CategoryModel {
  String? id;
  String? name;
  String? description;
  String? enName;
  String? image;
  String? enDescription;
  String? systemName;
  String? systemDescription;
  String? code;
  bool? active;
  bool? homeScreen;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.enName,
    this.image,
    this.enDescription,
    this.systemName,
    this.systemDescription,
    this.code,
    this.active,
    this.homeScreen,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    enName = json['enName'];
    image = json['image'];
    enDescription = json['enDescription'];
    systemName = json['systemName'];
    systemDescription = json['systemDescription'];
    code = json['code'];
    active = json['active'];
    homeScreen = json['homeScreen'];
  }
}
