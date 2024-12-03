import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/Faqs.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/report.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo.dart';

class ProfileRepoImp extends ProfileRepo {
  final ApiService api;
  ProfileRepoImp({required this.api});

  List<Faqs> faqs =[];
  @override
  Future<Either<Failure,List<Faqs>>> getFaqs() async {
    try {
      await api.setAuthorizationHeader();

      var response = await api.get(endpoint: "api/faqs?isArabic=false");
      print(response['faqs']);

      for(var item in response['faqs'])
      {
        var f = Faqs.fromJson(item);
        faqs.add(f);

      }

      return right(faqs);
      

      
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
      
    }
  }

  @override
  Future<Either<Failure, String>> sendReport(Report report) async{
    try {
      // await api.setAuthorizationHeader();

      var response = await api.post(endPoints: "api/report-issue", data: report.toJson());
      print("44444444444444");
      if(response.statusCode == 200)
      {
        return right(response.data['msg']);
      }else{
         return left(ServerFailure('Failed to Submit Report. Please try again.'));
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

