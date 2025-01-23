import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_details.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/order%20history%20repo/order_history_repo.dart';

class OrderHistoryRepoImp extends OrderHistoryRepo {
  final ApiService api;
  List<OrderHistory> history = [];
  OrderHistoryRepoImp({required this.api});

  @override
  Future<Either<Failure, List<OrderHistory>>> getOrdersHistory(
      int page, String status) async {
   

    try {
       await api.setAuthorizationHeader();
      var response = await api.get(
          endpoint: "api/protected/orders/history?page=0&status=Pending",

);
log("response : ${response}");
      


      for (var item in response['orders']) {

        var h = OrderHistory.fromJson(item);

        history.add(h);

      }

      return right(history);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, OrderDetails>> getOrderDetails(int id) async {

    try {

      await api.setAuthorizationHeader();
      print("b3d el token");
      print("id : $id");


      var response = await api.get(endpoint: "api/protected/orders/$id/get") ; 
      print("b3d el response");

      if(response['order'] != null && response['order'].isNotEmpty)
      {
        var item = response['order'];
        OrderDetails order = OrderDetails.fromJson(item) ; 
        return right(order) ; 
      } else 
      {
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
