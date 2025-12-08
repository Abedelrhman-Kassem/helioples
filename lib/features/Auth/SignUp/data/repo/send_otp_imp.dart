import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/send_otp_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/send_otp_repo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/sign_up_cubit/sent_otp_states.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';

class SendOtpRepoImpl implements SendOtpRepo {
  final ApiService apiService;
  SendOtpRepoImpl(this.apiService);
  @override
  Future<Either<Failure, OtpModel>> sendOtp(RegisterModel registerModel) async {
    try {
      final res = await SendOtpHelper.verifyPhone('+2${registerModel.phone}');
      return res.fold((err) => left(ServerFailure(err)),
          (data) => right(OtpModel(registerModel, data.verificationId)));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, ApiResponse>> checkUser(
      RegisterModel registerModel) async {
    try {
      final res = await apiService.post(
        endPoints: AppUrls.check,
        data: {'phone': registerModel.phone},
      );
      return right(ApiResponse.fromJson(
        res.data,
        (raw) {},
      ));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
