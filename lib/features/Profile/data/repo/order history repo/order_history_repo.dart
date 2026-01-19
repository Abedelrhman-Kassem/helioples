import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_details.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/order_history.dart';

abstract class OrderHistoryRepo {
  Future<Either<Failure, List<ItemHistory>>> getOrdersHistory(
    int page,
    String status,
    bool isActive,
    bool includeCanceled,
    int pageSize,
  );
  Future<Either<Failure, OrderDetails>> getOrderDetails(String id);
}
