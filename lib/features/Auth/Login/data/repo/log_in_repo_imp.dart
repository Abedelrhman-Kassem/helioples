import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo.dart';

class LogInRepoImp extends LogInRepo {
  final ApiService apiService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  LogInRepoImp({required this.apiService});

  @override
  Future<Either<Failure, Map<String, dynamic>>> signIn(
      String phone, String password) async {
    String? verificationId;
    String? resendToken;
    try {
      // await apiService.setAuthorizationHeader();
      final formattedPhone = '+2$phone';
      // print("b3d el phone");
      final data = {
        'phone': formattedPhone,
        'password': password,
      };

      var response = await apiService.post(endPoints: 'auth/login', data: data);

      if (response.statusCode == 200) {
        final token = response.data['token'];
        // final res = await SendOtpHelper.verifyPhone('+2$phone');
        // res.fold(
        //   (err) => {
        //     showCustomGetSnack(
        //       duration: const Duration(minutes: 10),
        //       isGreen: false,
        //       text: " failed send otp $err",
        //     )
        //   },
        //   (data) => {
        //     showCustomGetSnack(
        //         isGreen: true,
        //         text: LocaleKeys.login_screen_verification_sent.tr()),
        //     // log('data: ${data.verificationId}'),
        //     verificationId = data.verificationId,
        //     resendToken = data.resendToken.toString()
        //   },
        // );
        // print("token-----");
        // print(response.data['token']);
        // print("token-----");

        await _storage.write(key: 'token', value: token);

        // await apiService.setAuthorizationHeader();

        return right({
          'token': token,
          'verificationId': verificationId,
          'resendToken': resendToken,
        });
      } else {
        return left(ServerFailure('Failed to sign in. Please try again.'));
      }
    } catch (e) {
      if (e is DioException) {
        log('DioException during signIn: ${e.message}');
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
