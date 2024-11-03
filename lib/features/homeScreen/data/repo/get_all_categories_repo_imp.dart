import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/get_all_categories_repo.dart';

class GetCategoriesImp extends GetCategories {
  final ApiService apiService;

  GetCategoriesImp({required this.apiService});

  @override
  Future<Either<Failure, AllCategoriesModel>> getAllCategories() async {
    AllCategoriesModel allCategoriesModel = AllCategoriesModel.fromJson({});
    try {
      allCategoriesModel = AllCategoriesModel.fromJson(
        await apiService.get(endpoint: 'api/categories'),
      );

      return right(allCategoriesModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
