import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/featur_model.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SubCategoriesRepoImp extends SubCategoriesRepo {
  final ApiService api;
  List<SubCatByCatidData> subCategories = [];
  String mainId = "";

  SubCategoriesRepoImp({required this.api});

  @override
  Future<Either<Failure, List<SubCatByCatidData>>> getSubCategories(
    String id,
  ) async {
    try {
      final response = await api.get(
        endpoint: AppUrls.getSubCategoriesUrl(id: id),
      );
      print(response);

      log("success loading sub categories");

      final List<dynamic> rawList = response['data'] ?? [];

      final List<SubCatByCatidData> subCategories =
          rawList.map((item) => SubCatByCatidData.fromJson(item)).toList();

      mainId = id;

      return right(subCategories);
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Products>>> getProductsInSubCategory(
      String subCategoryId, int page,
      {int include = 10}) async {
    log("page $page");
    try {
      var response = await api.get(
        endpoint:
            AppUrls.getProductsInSubCategoryUrl(id: subCategoryId, page: page),
      );
      List<Products> products = [];

      for (var item in response['data']['pagedProducts']['items']) {
        try {
          products.add(Products.fromJson(item));
        } catch (e) {
          log("Error parsing item: $e");
        }
      }
      log("success loading products in sub category");
      return right(products);
    } catch (e, stackTrace) {
      log(stackTrace.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Products>>> getAllProductsOfSubCategory(
      int subCategoryId) async {
    try {
      var response =
          await api.get(endpoint: AppUrls.getSubCategoriesUrl(id: mainId));
      List<Products> products = [];

      for (var item in response['data']['products']) {
        try {
          products.add(Products.fromJson(item));
        } catch (e) {
          print("Error parsing item: $e");
        }
      }
      // print("llllllllllllllll");
      // print(products.length);
      log("prinintg products in the repo ");
      print(products);
      log("after printing products in the repo");
      return right(products);
    } catch (e) {
      // log("error loading products in sub category");
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        // log("error loading products in sub category");
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, FeaturMdel>> getFeatures(String categoryId) async {
    try {
      var response = await api.get(
        endpoint: AppUrls.getFeaturesUrl(categoryId),
      );
      log("success loading features $response");
      return right(FeaturMdel.fromJson(response));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<Products>>> getProductsFeatured(
      String featureId, int page, int pageSize) async {
    try {
      var response = await api.get(
        endpoint: AppUrls.getProductsFeaturedUrl(featureId, page, pageSize),
      );
      log("${AppUrls.getProductsFeaturedUrl(featureId, page, pageSize)}");
      // log("success loading products featured $response");
      List<Products> products = [];
      if (response['data'] != null &&
          response['data']['pagedProducts'] != null &&
          response['data']['pagedProducts']['items'] != null) {
        for (var item in response['data']['pagedProducts']['items']) {
          products.add(Products.fromJson(item));
        }
      }
      return right(products);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
