import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/home_slider_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/home_screen_repo.dart';

class HomeScreenRepoImp extends GetHomeScreenRepo {
  final ApiService apiService;

  HomeScreenRepoImp({required this.apiService});

  @override
  Future<Either<Failure, AllCategoriesModel>> getAllCategories({
    bool? homeScreen,
    required int page,
    required int pageSize,
  }) async {
    // log(
    //   "start getAllCategories",
    //   time: DateTime.now(),
    //   zone: Zone.current,
    // );
    AllCategoriesModel allCategoriesModel = AllCategoriesModel.fromJson({});
    try {
      log("url ${AppUrls.getCategoriesUrl(
        homeScreen: homeScreen,
        page: page,
        pageSize: pageSize,
      )}");
      var response = await apiService.get(
        endpoint: AppUrls.getCategoriesUrl(
          homeScreen: homeScreen,
          page: page,
          pageSize: pageSize,
        ),
      );
      log("response $response");
      allCategoriesModel = AllCategoriesModel.fromJson(response);
      // log("allCategories SUCCESS");
      // log("allCategories ${allCategoriesModel.categories.length}");

      return right(allCategoriesModel);
    } catch (e) {
      if (e is DioException) {
        log("e $e");
        return left(ServerFailure.fromDioError(e));
      }

      log("e $e");
      return left(ServerFailure(e.toString()));
    }
  }

  int page = 1;
  int pageSize = 5;
  @override
  Future<Either<Failure, HomeSliderModel>> getConfigs() async {
    HomeSliderModel homeSliderModel = HomeSliderModel.fromJson({});
    try {
      homeSliderModel = HomeSliderModel.fromJson(
        await apiService.get(
          endpoint: AppUrls.getSliderUrl(page, pageSize),
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
    bool? homeScreen,
    required int page,
  }) async {
    SpecialOfferModel specialOfferModel;

    try {
      final response = await apiService.get(
        endpoint: AppUrls.getOffersUrl(
          page,
          homeScreen,
          10,
        ),
      );
      specialOfferModel = SpecialOfferModel.fromJson(response);

      return right(specialOfferModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
