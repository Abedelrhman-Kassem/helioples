import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo.dart';

class LogInRepoImp extends LogInRepo
{ final ApiService apiService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
 LogInRepoImp({required this.apiService});

  @override
  Future<Either<Failure, String>> signIn(String phone , String password) async {
    try {
       // await apiService.setAuthorizationHeader();
        final formattedPhone = '+20$phone';
       final data = {
        'phone': formattedPhone , 
        'password':password,
        };
       var response = await apiService.post(endPoints: 'auth/login', data: data );
       if (response.statusCode == 200) {
                final token = response.data['token'];
        await _storage.write(key: 'token', value: token);

        await apiService.setAuthorizationHeader();
        return right(response.data['msg']);
      } else {
        return left(ServerFailure('Failed to sign in. Please try again.'));
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