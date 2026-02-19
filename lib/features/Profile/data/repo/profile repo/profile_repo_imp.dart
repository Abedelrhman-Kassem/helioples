import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/customer_model.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/faqs.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/notification.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/report.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo.dart';

class ProfileRepoImp extends ProfileRepo {
  final ApiService api;

  ProfileRepoImp({required this.api});

  List<FaqsData> faqs = [];

  List<Alerts> alerts = [];

  @override
  Future<Either<Failure, ApiResponse<List<FaqsData>>>> getFaqs(
    bool isArabic,
  ) async {
    try {
      var response = await api.get(endpoint: AppUrls.faqsUrl(isArabic));

      return right(
        ApiResponse.fromJson(
          response,
          (json) => List<FaqsData>.from(
            (json as List).map((x) => FaqsData.fromJson(x)),
          ),
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> sendReport(Report report) async {
    try {
      // await api.setAuthorizationHeader();

      var response = await api.post(
        endPoints: AppUrls.issueReportUrl(),
        data: FormData.fromMap({
          "Message": report.message,
          if (report.imageUrl != null)
            "Image": await MultipartFile.fromFile(report.imageUrl!),
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return right(response.data['message'] ?? 'Success');
      } else {
        return left(
          ServerFailure('Failed to Submit Report. Please try again.'),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  // @override
  // Future<Either<Failure, List<Alerts>>> getAlerts() async {
  //   try {
  //     var response = await api.get(
  //       endpoint: "api/protected/user/notifications/get",
  //     );

  //     for (var item in response['notifications']) {
  //       var a = Alerts.fromJson(item);
  //       alerts.add(a);
  //     }
  //     return right(alerts);
  //   } catch (e) {
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioError(e));
  //     } else {
  //       return left(ServerFailure(e.toString()));
  //     }
  //   }
  // }

  @override
  Future<Either<Failure, String>> updateProfile(CustomerModel customer) async {
    try {
      var response = await api.put(
        endPoints: AppUrls.updateCustomer,
        data: customer.toJson(),
      );

      if (response.statusCode == 200) {
        return right(response.data['message'] ?? 'Failed to update profile');
      } else {
        return left(
          ServerFailure(response.data['message'] ?? 'Failed to update profile'),
        );
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ApiResponse<CustomerModel>>> getProfile() async {
    try {
      var response = await api.get(endpoint: AppUrls.getProfileUrl);

      return right(
        ApiResponse.fromJson(
          response,
          (json) => CustomerModel.fromJson(json as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
