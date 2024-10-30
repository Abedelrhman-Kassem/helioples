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
      int page, int id) async {
    try {
      var response =
          await api.get(endpoint: "api/categories/2/sub-categories", headers: {
        "token":
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE4IiwidHlwZSI6InVzZXIiLCJwdXJwb3NlIjoiYXV0aCIsImlhdCI6MTcyODgyMTg0OSwiZXhwIjoxNzI5MjUzODQ5fQ.H1YcyQOzsabWzz-PPPDF-jKIi1-o9jz0_-jFiLvwWDU"
      });

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
      print(subCategories[1]);
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
}
