import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Liked/data/models/liked_model.dart';
import 'package:negmt_heliopolis/features/Liked/data/repo/liked_repo.dart';

class LikedRepoImp extends LikedRepo {
  final ApiService apiService;

  LikedRepoImp(this.apiService);

  @override
  Future<Either<Failure, LikedModel>> getAllLikedProducts(int page) async {
    LikedModel likedModel = LikedModel.fromJson({});

    try {
      likedModel = LikedModel.fromJson(
        await apiService.get(endpoint: 'api/protected/user/likes?page=$page'),
      );

      return right(likedModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }

      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Response<dynamic>> postLikedProduct(int prodcutId) async {
    try {
      var result = await apiService.post(
        endPoints: 'api/protected/products/like',
        data: {"productId": prodcutId},
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
