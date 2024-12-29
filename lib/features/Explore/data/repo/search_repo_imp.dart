import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Explore/data/models/search_model.dart';
import 'package:negmt_heliopolis/features/Explore/data/repo/search_repo.dart';

class SearchRepoImp extends SearchRepo {
  final ApiService apiService;
  CancelToken? _cancelToken;

  SearchRepoImp(this.apiService);

  @override
  Future<Either<Failure, SearchModel>> search({
    required String query,
    required int page,
  }) async {
    SearchModel searchModel;

    _cancelToken?.cancel("Cancelled due to a new request");
    _cancelToken = CancelToken();

    try {
      var res = await apiService.get(
        endpoint: 'api/products/search?q=$query&page=$page',
        cancelToken: _cancelToken,
      );

      searchModel = SearchModel.fromJson(res);
      return right(searchModel);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
