import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/promocode_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/promocode_repo.dart';

class PromocodeRepoImp extends PromocodeRepo {
  final ApiService apiService;

  PromocodeRepoImp({required this.apiService});

  @override
  Future<Either<Failure, PromoCodeModel>> checkPromoCode(String code) async {
    PromoCodeModel promoCodeModel;

    try {
      var response = await apiService.post(
        endPoints: 'api/protected/orders/check-promocode',
        data: {'code': code},
      );

      promoCodeModel = PromoCodeModel.fromJson(response.data);

      return right(promoCodeModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
