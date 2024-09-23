import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/user.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/sign_up_repo.dart';

class SignUpRepoImp extends SignUpRepo {
  final ApiService apiService;

  SignUpRepoImp({required this.apiService});

  @override
  Future<Either<Failure, String>> signUp(User user) async {
    try {
      // await apiService.setAuthorizationHeader();
      var response = await apiService.post(endPoints: 'auth/register', data: user.toJson());
      if (response.statusCode == 200) {
        return right(response.data['msg']);
      } else {
        return left(ServerFailure('Failed to sign up. Please try again.'));
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
  Future<Either<Failure,String>> setLocation(double long , double lat) async
  {
    try {
      // await apiService.setAuthorizationHeader(); 
       Map<String, dynamic> data = {
      'longitude': long,
      'latitude': lat,
    };

     var response = await apiService.post(endPoints: 'api/protected/user/update-location', data: data) ;
     if(response.statusCode == 200)
     {
      return right(response.data['msg']);
     }else
     {
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
