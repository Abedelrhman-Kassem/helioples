import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/delivery_repo.dart';

class CreateOrderImp extends CreateOrder {
  final ApiService apiService;

  CreateOrderImp({required this.apiService});

  @override
  Future<Either<Failure, OrderDetailsModel>> createOrder(
      Map<String, dynamic> data) async {
    OrderDetailsModel orderDetailsModel;

    try {
      var response = await apiService.post(
        endPoints: 'api/protected/orders/create',
        headers: {
          'token':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE4IiwidHlwZSI6InVzZXIiLCJwdXJwb3NlIjoiYXV0aCIsImlhdCI6MTcyODMxMzY0NCwiZXhwIjoxNzI4NzQ1NjQ0fQ.Ru2kMDgnQOie3KxX_0xJlJGPiKugb8GqimPllhozTi0',
        },
        data: data,
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
