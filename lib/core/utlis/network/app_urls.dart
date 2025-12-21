class AppUrls {
  static const String _baseUrl = 'http://144.172.109.90:5000/api/v1';
  //                         Auth
  static const String register = '$_baseUrl/Auth/register';
  static const String login = '$_baseUrl/Auth/login';
  static const String check = '$_baseUrl/Auth/check';
  //                         Categories
  static String getCategoriesUrl({int? page, bool? homeScreen, int? pageSize}) {
    final params = <String, String>{};

    if (homeScreen != null) params['HomeScreen'] = homeScreen.toString();
    if (page != null) params['Page'] = page.toString();
    if (pageSize != null) params['PageSize'] = pageSize.toString();

    final uri = Uri.parse('$_baseUrl/Categories').replace(
      queryParameters: params.isEmpty ? null : params,
    );

    return uri.toString();
  }

  static String getSubCategoriesUrl({required String id, bool active = true}) {
    final uri = Uri.parse('$_baseUrl/SubCategory/category/$id?Active=$active');

    return uri.toString();
  }

  static String getProductsInSubCategoryUrl(
      {required String id,
      bool active = true,
      int page = 1,
      int pageSize = 10}) {
    final uri = Uri.parse(
        '$_baseUrl/Product/subcategory/$id?Page=$page&PageSize=$pageSize&Active=$active');

    return uri.toString();
  }

//                         Product
  static String getProductDetailsUrl(
      {required String id, int page = 1, int pageSize = 10}) {
    final uri = Uri.parse(
        '$_baseUrl/Product/$id?Page=$page&PageSize=$pageSize&Active=true');

    return uri.toString();
  }

  //                         Liked
  // static String getLikedProductsUrl({int page = 1, int pageSize = 10}) {
  //   final uri = Uri.parse(
  //       '$_baseUrl/Liked?Page=$page&PageSize=$pageSize&Active=true');

  //   return uri.toString();
  // }

  static const String postLikedProductUrl = '$_baseUrl/Likes/toggle';
}
