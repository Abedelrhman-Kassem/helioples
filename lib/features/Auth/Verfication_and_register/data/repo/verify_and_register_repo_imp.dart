import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/send_otp_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/repo/verify_and_register_repo.dart';

class VerifyAndRegisterRepoImp extends VerifyAndRegisterRepo {
  final ApiService apiService;

  VerifyAndRegisterRepoImp({required this.apiService});
  @override
  Future<Either<String, bool>> verifayCode(
      String verificationId, String smsCode) async {
    try {
      final result = await SendOtpHelper.signInWithSmsCode(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      return result;
    } on Exception catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> signUp(
      RegisterModel registerModel) async {
    try {
      var response = await apiService.post(
          endPoints: AppUrls.register, data: registerModel.toJson());
      if (response.statusCode == 200) {
        return right(ApiResponse.fromJson(response.data, (json) => json));
      }
      return left(ServerFailure('Failed to sign up. Please try again.'));
    } catch (e) {
      if (e is DioException) {
        log("------------------------DioException ${e.message}");
        return left(ServerFailure.fromDioError(e));
      } else {
        log("========= ${e.toString()} ");
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
