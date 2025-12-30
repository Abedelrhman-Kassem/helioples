import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/maps/model/address_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/address_repo.dart';

class GetAddressessImp extends GetAddressesReop {
  ApiService apiService;
  GetAddressessImp(this.apiService);

  @override
  Future<Either<Failure, AddressModel>> getAddressess() async {
    AddressModel addressModel = AddressModel.fromJson({});
    try {
      addressModel = AddressModel.fromJson(
        await apiService.get(endpoint: AppUrls.getAddressesUrl()),
      );

      return right(addressModel);
    } catch (e, st) {
      log("${e.toString()}\n$st");
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> updateAddress({
    required Address address,
  }) async {
    try {
      final response = await apiService.put(
        endPoints: AppUrls.updateAddressesUrl(address.id!),
        data: address.toJson(),
      );

      final data = response.data as Map<String, dynamic>;
      final message =
          data['message'] as String? ?? 'Address updated successfully';

      if (data['success'] == true) {
        return right(message);
      } else {
        return left(ServerFailure(message));
      }
    } catch (e) {
      if (e is DioException) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic> && errorData['message'] != null) {
          return left(ServerFailure(errorData['message'] as String));
        }
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
