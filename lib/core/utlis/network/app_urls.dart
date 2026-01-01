import 'dart:developer';

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

    final uri = Uri.parse(
      '$_baseUrl/Categories',
    ).replace(queryParameters: params.isEmpty ? null : params);

    return uri.toString();
  }

  static String getSubCategoriesUrl({required String id, bool active = true}) {
    final uri = Uri.parse('$_baseUrl/SubCategory/category/$id?Active=$active');

    return uri.toString();
  }

  static String getProductsInSubCategoryUrl({
    required String id,
    bool active = true,
    int page = 1,
    int pageSize = 10,
  }) {
    final uri = Uri.parse(
      '$_baseUrl/SubCategory/$id?Page=$page&PageSize=$pageSize&Active=true',
    );

    return uri.toString();
  }

  //                         Product
  static String getProductDetailsUrl({
    required String id,
    int page = 1,
    int pageSize = 10,
  }) {
    final uri = Uri.parse(
      '$_baseUrl/Product/$id?Page=$page&PageSize=$pageSize&Active=true',
    );

    return uri.toString();
  }

  //                         Liked
  static const String postLikedProductUrl = '$_baseUrl/Likes/toggle';

  //                         Offers
  static String getOffersUrl(int page, bool? homeScreen, int pageSize) {
    final params = <String, String>{
      'Page': page.toString(),
      'PageSize': pageSize.toString(),
      'Active': 'true',
    };

    if (homeScreen != null) params['HomeScreen'] = homeScreen.toString();

    final uri = Uri.parse(
      '$_baseUrl/Offers',
    ).replace(queryParameters: params.isEmpty ? null : params);
    log(uri.toString());
    return uri.toString();
  }

  static String getOfferItemUrl(String id, int page, int pageSize) =>
      '$_baseUrl/Offers/$id?Page=$page&PageSize=$pageSize&Active=true';

  //                         Slider
  static String getSliderUrl(int page, int pageSize) =>
      '$_baseUrl/ImageSlider?Page=$page&PageSize=$pageSize&Active=true';

  static String getFeaturesUrl(String categoryId) =>
      '$_baseUrl/Featured/category/$categoryId';

  static String getProductsFeaturedUrl(
    String featureId,
    int page,
    int pageSize,
  ) =>
      '$_baseUrl/Featured/$featureId?Page=$page&PageSize=$pageSize&Active=true';

  //                         Address
  static String getAddressesUrl() => '$_baseUrl/Address/user';
  static String addAddressesUrl() => '$_baseUrl/Address';
  static String updateAddressesUrl(String id) => '$_baseUrl/Address/$id';

  //                          Update Cart
  static String updateCartUrl() => '$_baseUrl/Product/update-cart';

  //                         Time
  static String deliveryTimeUrl() =>
      'http://144.172.109.90:5000/api/DeliveryTime';
  static String pickupTimeUrl() => 'http://144.172.109.90:5000/api/PickupTime';

  //                         promo code
  static String promoCodeUrl() => 'http://144.172.109.90:5000/api/PromoCode';

  //                         branches
  static String branchesUrl() => 'http://144.172.109.90:5000/api/Branch';
}
