import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/home_slider_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/home_screen_repo.dart';

class HomeScreenRepoImp extends GetHomeScreenRepo {
  final ApiService apiService;

  HomeScreenRepoImp({required this.apiService});

  @override
  Future<Either<Failure, AllCategoriesModel>> getAllCategories({
    required bool homeScreen,
    required int page,
  }) async {
    AllCategoriesModel allCategoriesModel = AllCategoriesModel.fromJson({});
    try {
      allCategoriesModel = AllCategoriesModel.fromJson(
        await apiService.get(
          endpoint: 'api/categories?homeScreen=$homeScreen&page=$page',
        ),
      );

      return right(allCategoriesModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, HomeSliderModel>> getConfigs() async {
    HomeSliderModel homeSliderModel = HomeSliderModel.fromJson({});
    try {
      homeSliderModel = HomeSliderModel.fromJson(
        await apiService.get(
          endpoint: 'api/configs',
        ),
      );

      return right(homeSliderModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SpecialOfferModel>> getSpecialOffers({
    required bool homeScreen,
    required int page,
  }) async {
    SpecialOfferModel specialOfferModel;

    try {
      specialOfferModel = SpecialOfferModel.fromJson(
        await apiService.get(
          endpoint: 'api/offers?homeScreen=$homeScreen&page=$page',
        ),
      );

      return right(specialOfferModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
