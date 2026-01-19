import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Liked/data/models/liked_model.dart';

abstract class LikedRepo {
  Future<Either<Failure, LikedModel>> getAllLikedProducts({
    required int page,
    required int pageSize,
  });

  Future<Response<dynamic>> postLikedProduct(String prodcutId);
}
