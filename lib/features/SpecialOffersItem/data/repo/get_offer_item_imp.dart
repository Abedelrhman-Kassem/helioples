import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/model/offer_item_model.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/repo/get_offer_item_repo.dart';

class GetOfferItemImp extends GetOfferItemRepo {
  final ApiService apiService;
  GetOfferItemImp(this.apiService);

  @override
  Future<Either<Failure, SpecialOfferItemModel>> getSpecialOfferItem({
    required String id,
    required int page,
    required int pageSize,
  }) async {
    SpecialOfferItemModel specialOfferItemModel;

    try {
      final response = await apiService.get(
        endpoint: AppUrls.getOfferItemUrl(id, page, pageSize),
      );
      specialOfferItemModel = SpecialOfferItemModel.fromJson(
        response,
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
