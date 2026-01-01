import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Cart/data/model/update_cart_model.dart';
import 'package:negmt_heliopolis/features/Cart/data/repo/get_prices_repo.dart';

class GetPricesRepoImp extends GetPricesRepo {
  final ApiService apiService;

  GetPricesRepoImp({required this.apiService});

  @override
  Future<Either<Failure, UpdateCartModel>> getCartProducts(
    List<Map<String, dynamic>> infoProducts,
  ) async {
    UpdateCartModel updateCartModel;

    try {
      var response = await apiService.post(
        endPoints: AppUrls.updateCartUrl(),
        data: infoProducts,
      );

      updateCartModel = UpdateCartModel.fromJson(response.data);

      return right(updateCartModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
