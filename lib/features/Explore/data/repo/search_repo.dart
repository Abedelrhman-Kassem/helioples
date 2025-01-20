import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Explore/data/models/search_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, SearchModel>> search({
    required String query,
    required int page,
  });
}
