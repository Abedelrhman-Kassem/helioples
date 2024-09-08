import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/get_all_categories_repo.dart';

class GetCategoriesImp extends GetCategories {
  @override
  Future<Either<Failure,AllCategoriesModel>> getAllCategories() async {
    ApiService apiService = ApiService();
    AllCategoriesModel allCategoriesModel = AllCategoriesModel.fromJson({});
    try {
      allCategoriesModel = AllCategoriesModel.fromJson(
        await apiService.get(endpoint: 'api/categories'));
        print("--------");
        print(allCategoriesModel.categories?[0].name);
          print("--------");

    return right(allCategoriesModel);
      
    } catch (e) {
      if (e is DioException) {
  
        return left(ServerFailure.fromDioError(e));
      }
     
      return left(ServerFailure(e.toString()));
    }

    
  }
}

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:petowner_frontend/core/errors/failure.dart';
// import 'package:petowner_frontend/core/utils/networking/api_service.dart';
// import 'package:petowner_frontend/features/pet%20walking/data/model/walking_request.dart';
// import 'package:petowner_frontend/features/pet%20walking/data/repo/walking_request_repo.dart';

// class WalkingRepoImp extends WalkingRepo {
//   WalkingRepoImp({required this.apiService});
//   ApiService apiService;

//   @override
//   Future<Either<Failure, String>> sendWalkingrequest(
//       WalkingRequest walkingRequest) async {
//     try {
//       print("ana abl el token");
//       await apiService.setAuthorizationHeader();
//       print("ana b3d el token");

//       // final startAdjusted =
//       //     walkingRequest.startTime!.add(const Duration(hours: 3)).toUtc();
//       // final endAdjusted =
//       //     walkingRequest.endTime!.add(const Duration(hours: 3)).toUtc();
//       // walkingRequest.endTime = endAdjusted;
//       // walkingRequest.startTime = startAdjusted;

//       var response = await apiService.post(
//           endPoints: "PetOwner/makeWalkingRequest",
//           data: walkingRequest.toJson());
//       print("ana b3d el response");
//       if (response.statusCode == 201) {
//         print("ana abl el right");
//         return right(response.data['message']);
//       } else {
//         return left(
//             ServerFailure('Failed to send the request. Please try again.'));
//       }
//     } catch (e) {
//       if (e is DioException) {
//         return left(ServerFailure.fromDioError(e));
//       } else {
//         return left(ServerFailure(e.toString()));
//       }
//     }
//   }
// }
