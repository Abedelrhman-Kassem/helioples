import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/features/maps/repo/add_address_repo.dart';

class AddAddressRepoImpl extends AddAddressRepo {
  final ApiService apiService;

  AddAddressRepoImpl(this.apiService);

  @override
  Future<Either<Failure, String>> addAddress({required Address address}) async {
    try {
      final response = await apiService.post(
        endPoints: AppUrls.addAddressesUrl(),
        data: address.toJson(),
      );

      final data = response.data as Map<String, dynamic>;
      final message =
          data['message'] as String? ?? 'Address created successfully';

      if (data['success'] == true) {
        return right(message);
      } else {
        return left(ServerFailure(message));
      }
    } catch (e) {
      if (e is DioException) {
        // Try to extract message from error response
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic> && errorData['message'] != null) {
          return left(ServerFailure(errorData['message'] as String));
        }
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, String>> updateAddress({
  //   required Address address,
  // }) async {
  //   try {
  //     final response = await apiService.put(
  //       endPoints: AppUrls.updateAddressesUrl(address.id!),
  //       data: address.toJson(),
  //     );

  //     final data = response.data as Map<String, dynamic>;
  //     final message =
  //         data['message'] as String? ?? 'Address updated successfully';

  //     if (data['success'] == true) {
  //       return right(message);
  //     } else {
  //       return left(ServerFailure(message));
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       final errorData = e.response?.data;
  //       if (errorData is Map<String, dynamic> && errorData['message'] != null) {
  //         return left(ServerFailure(errorData['message'] as String));
  //       }
  //       return left(ServerFailure.fromDioError(e));
  //     }
  //     return left(ServerFailure(e.toString()));
  //   }
  // }
}
