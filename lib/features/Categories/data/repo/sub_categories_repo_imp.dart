import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';

import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo.dart';

class SubCategoriesRepoImp extends SubCategoriesRepo {
  final ApiService api;
  List<SubCategories> subCategories = [];

  SubCategoriesRepoImp({required this.api});

  @override
  Future<Either<Failure, List<SubCategories>>> getSubCategories(
       int id) async {
    try {
      await api.setAuthorizationHeader();
      var response =
          await api.get(endpoint: "api/categories/1/sub-categories", );

      print(response['subCategories']);

      for (var item in response['subCategories']) {
        try {
          print("Parsing item: $item");
          var sub = SubCategories.fromJson(item);
          print("Parsed successfully: $sub");
          subCategories.add(sub);
        } catch (e) {
          print("Error parsing item: $e");
        }
      }
      print("***********");
      //print(subCategories[1]);
      print("*********");
      return right(subCategories);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
  
  @override
  Future<Either<Failure, List<Products>>> getProductsInSubCategory(int subCategoryId, int page) async  {

    try {
      await api.setAuthorizationHeader() ; 

      var response = await api.get(endpoint: "api/categories/1/sub-categories/$subCategoryId?page=$page");
      List<Products> products = [];

      for (var item in response['subCategory']['products']) {
        try {
          products.add(Products.fromJson(item));
        } catch (e) {
          print("Error parsing item: $e");
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
