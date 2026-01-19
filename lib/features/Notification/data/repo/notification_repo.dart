import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';

abstract class NotificationRepo {
  Future<Either<Failure, bool>> saveDeviceToken({
    required String token,
    required String platform,
  });

  Future<Either<Failure, bool>> deleteDeviceToken(String token);

  Future<Either<Failure, bool>> subscribe({
    required String eventType,
    required String targetType,
    required String targetId,
    required String route,
  });

  Future<Either<Failure, bool>> unsubscribe({
    required String eventType,
    required String targetId,
  });

  Future<Either<Failure, Map<String, dynamic>>> getNotifications({
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, bool>> markAsRead(String notificationId);

  Future<Either<Failure, bool>> markAllAsRead();
}
