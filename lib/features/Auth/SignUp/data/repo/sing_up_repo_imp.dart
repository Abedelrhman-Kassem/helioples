import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/send_otp_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Auth/Verfication_and_register/data/model/register_model.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/sign_up_repo.dart';

class SignUpRepoImp extends SignUpRepo {
  final ApiService apiService;

  SignUpRepoImp({required this.apiService});

  // @override
  // Future<Either<Failure, Map<String, dynamic>>> signUp(
  //     RegisterModel registerModel) async {
  //   String? verificationId;
  //   String? resendToken;
  //   try {
  //     // await apiService.setAuthorizationHeader();
  //     var response = await apiService.post(
  //         endPoints: AppUrls.register, data: registerModel.toJson());
  //     if (response.statusCode == 200) {
  //       final res = await SendOtpHelper.verifyPhone('+2${registerModel.phone}');
  //       res.fold(
  //         (err) => {
  //           showCustomGetSnack(
  //             duration: const Duration(minutes: 10),
  //             isGreen: false,
  //             text: " failed send otp $err",
  //           )
  //         },
  //         (data) => {
  //           showCustomGetSnack(
  //               isGreen: true,
  //               text: LocaleKeys.login_screen_verification_sent.tr()),
  //           // log('data: ${data.verificationId}'),
  //           verificationId = data.verificationId,
  //           resendToken = data.resendToken.toString()
  //         },
  //       );
  //       return right({
  //         'resonse': response.data['msg'],
  //         'verificationId': verificationId,
  //       });
  //     } else {
  //       return left(ServerFailure('Failed to sign up. Please try again.'));
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       return left(ServerFailure.fromDioError(e));
  //     } else {
  //       return left(ServerFailure(e.toString()));
  //     }
  //   }
  // }
  @override
  Future<Either<Failure, Map<String, dynamic>>> sendOtp(
      RegisterModel registerModel) async {
    try {
      final res = await SendOtpHelper.verifyPhone('+2${registerModel.phone}');
      return res.fold(
          (err) => left(ServerFailure(err)),
          (data) => right({
                'model': registerModel,
                'verificationId': data.verificationId,
              }));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, String>> setLocation(double long, double lat) async {
    try {
      // await apiService.setAuthorizationHeader();
      Map<String, dynamic> data = {
        'longitude': long,
        'latitude': lat,
      };

      var response = await apiService.post(
          endPoints: 'api/protected/user/addresses/2/update', data: data);
      if (response.statusCode == 200) {
        return right(response.data['msg']);
      } else {
        return left(ServerFailure('Failed to set the location'));
      }
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
