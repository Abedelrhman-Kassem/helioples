import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/home_slider_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';

abstract class GetHomeScreenRepo {
  Future<Either<Failure, AllCategoriesModel>> getAllCategories({
    required bool homeScreen,
    required int page,
  });

  Future<Either<Failure, HomeSliderModel>> getConfigs();

  Future<Either<Failure, SpecialOfferModel>> getSpecialOffers({
    required bool homeScreen,
    required int page,
  });
}
