import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';
import 'package:negmt_heliopolis/features/Notification/data/repo/notification_repo.dart';

class NotificationRepoImp extends NotificationRepo {
  final ApiService api;

  NotificationRepoImp({required this.api});

  @override
  Future<Either<Failure, bool>> saveDeviceToken({
    required String token,
    required String platform,
  }) async {
    try {
      var authToken = await ServicesHelper.getLocal('token');
      if (authToken == null) {
        return left(ServerFailure('Token not found'));
      }

      await api.post(
        endPoints: AppUrls.saveDeviceTokenUrl,
        data: {'token': token, 'platform': platform},
      );
      await ServicesHelper.saveLocal('fcm_token', token);
      log('Device token saved successfully');
      return right(true);
    } catch (e) {
      log('Error saving device token: $e');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteDeviceToken(String token) async {
    try {
      await api.delete(endPoints: AppUrls.deleteDeviceTokenUrl(token));
      await ServicesHelper.removeLocal('fcm_token');
      log('Device token deleted successfully');
      return right(true);
    } catch (e) {
      log('Error deleting device token: $e');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> subscribe({
    required String eventType,
    required String targetType,
    required String targetId,
    required String route,
  }) async {
    try {
      await api.post(
        endPoints: AppUrls.subscribeUrl,
        data: {
          'eventType': eventType,
          'targetType': targetType,
          'targetId': targetId,
          'route': route,
        },
      );
      log('Subscribed successfully');
      return right(true);
    } catch (e) {
      log('Error subscribing: $e');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> unsubscribe({
    required String eventType,
    required String targetId,
  }) async {
    try {
      await api.post(
        endPoints: AppUrls.unsubscribeUrl,
        data: {'eventType': eventType, 'targetId': targetId},
      );
      log('Unsubscribed successfully');
      return right(true);
    } catch (e) {
      log('Error unsubscribing: $e');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getNotifications({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await api.get(
        endpoint: AppUrls.getNotificationsUrl(page, pageSize),
      );
      log('Notifications fetched successfully');
      return right(response);
    } catch (e) {
      log('Error fetching notifications: $e');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markAsRead(String notificationId) async {
    try {
      await api.patch(endPoints: AppUrls.markAsReadUrl(notificationId));
      log('Notification marked as read');
      return right(true);
    } catch (e) {
      log('Error marking notification as read: $e');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> markAllAsRead() async {
    try {
      await api.patch(endPoints: AppUrls.markAllAsReadUrl);
      log('All notifications marked as read');
      return right(true);
    } catch (e) {
      log('Error marking all notifications as read: $e');
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
