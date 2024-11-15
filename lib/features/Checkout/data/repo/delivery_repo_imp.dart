import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/delivery_repo.dart';

class CreateOrderImp extends CreateOrder {
  final ApiService apiService;

  CreateOrderImp({required this.apiService});

  @override
  Future<Either<Failure, OrderDetailsModel>> createOrder(
      CreateOrderModel data) async {
    OrderDetailsModel orderDetailsModel;

    try {
      var response = await apiService.post(
        endPoints: 'api/protected/orders/create',
        data: data.toJson(),
      );

      // Deserialize response data to OrderDetailsModel
      orderDetailsModel = OrderDetailsModel.fromJson(response.data);

      return right(orderDetailsModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }
}
