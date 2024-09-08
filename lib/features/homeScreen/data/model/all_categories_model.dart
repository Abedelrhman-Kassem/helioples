class AllCategoriesModel {
  List<CategoryModel>? categories;

  AllCategoriesModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = List.from(json['categories'])
          .map((e) => CategoryModel.fromJson(e))
          .toList();
    }
  }
}

class CategoryModel {
  late final int id;
  late final String name;
  late final String description;
  late final Null image;
  late final bool active;
  late final int subCategoriesNum;
  late final String createdAt;
  late final String updatedAt;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = null;
    active = json['active'];
    subCategoriesNum = json['subCategoriesNum'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
