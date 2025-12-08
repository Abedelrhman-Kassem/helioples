import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/send_otp_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/models/login_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class LogInRepoImp extends LogInRepo {
  final ApiService apiService;
  LogInRepoImp({required this.apiService});

  @override
  Future<Either<Failure, LoginModel>> signIn(String phone) async {
    try {
      final formattedPhone = phone;
      final data = {
        "phone": formattedPhone,
      };

      var response =
          await apiService.post(endPoints: AppUrls.login, data: data);

      if (response.statusCode == 200) {
        // ===== 1) تحقق من OTP قبل ما ترجع Right =====
        final otpResult = await SendOtpHelper.verifyPhone('+2$phone');

        return otpResult.fold(
          (err) {
            // OTP Failed → رجّع Left ووقف
            return left(ServerFailure("Failed to send OTP"));
          },
          (otpData) {
            // OTP Success → كمل
            Map<String, dynamic> finalResponse = {
              "verificationId": otpData.verificationId,
              "phoneNumber": formattedPhone,
              "success": response.data['success'],
              "message": response.data['message'],
              "data": response.data['data'],
            };

            showCustomGetSnack(
              isGreen: true,
              text: LocaleKeys.login_screen_verification_sent.tr(),
            );

            return right(LoginModel.fromJson(finalResponse));
          },
        );
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (e, s) {
      log('Exception during signIn: $s');
      if (e is DioException) {
        log('DioException during signIn: ${e.message}');
        return left(ServerFailure.fromDioError(e));
      } else {
        log('Exception during signIn: ${e.toString()}');
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
