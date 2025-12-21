import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/Product/data/repo/get_product_repo.dart';

class GetProductImp extends GetProduct {
  final ApiService apiService;

  GetProductImp({required this.apiService});

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
    String productId,
    int page,
    int pageSize,
  ) async {
    ProductDetailsModel productModel;

    try {
      productModel = ProductDetailsModel.fromJson(
        await apiService.get(
            endpoint: AppUrls.getProductDetailsUrl(
                id: productId, page: page, pageSize: pageSize)),
      );

      return right(productModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
