import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_details.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/order%20history%20repo/order_history_repo.dart';

class OrderHistoryRepoImp extends OrderHistoryRepo {
  final ApiService api;
  // List<ItemHistory> history = [];
  OrderHistoryRepoImp({required this.api});

  @override
  Future<Either<Failure, List<ItemHistory>>> getOrdersHistory(
    int page,
    String status,
    bool isActive,
    bool includeCanceled,
    int pageSize,
  ) async {
    try {
      var response = await api.get(
        endpoint: AppUrls.getOrdersHistory(
          page: page,
          status: status,
          isActive: isActive,
          includeCanceled: includeCanceled,
          pageSize: pageSize,
        ),
      );
      OrderHistory orderHistory = OrderHistory.fromJson(response);

      return right(orderHistory.data!.items);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, OrderDetails>> getOrderDetails(String id) async {
    try {
      var response = await api.get(endpoint: AppUrls.orderDetailsUrl(id));
      if (response['success'] == true) {
        OrderDetails order = OrderDetails.fromJson(response);
        return right(order);
      } else {
        return left(ServerFailure('Order not found.'));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
