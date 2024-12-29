import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/model/offer_item_model.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/repo/get_offer_item_repo.dart';

class GetOfferItemImp extends GetOfferItemRepo {
  final ApiService apiService;
  GetOfferItemImp(this.apiService);

  @override
  Future<Either<Failure, SpecialOfferItemModel>> getSpecialOfferItem({
    required int id,
    required int page,
  }) async {
    SpecialOfferItemModel specialOfferItemModel;

    try {
      specialOfferItemModel = SpecialOfferItemModel.fromJson(
        await apiService.get(
          endpoint: 'api/offers/$id?page=$page',
        ),
      );

      return right(specialOfferItemModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
