// import 'package:dartz/dartz.dart';
// import 'package:petowner_frontend/core/errors/failure.dart';
// import 'package:petowner_frontend/features/pet%20walking/data/model/walking_request.dart';

// abstract class WalkingRepo {
//   Future<Either<Failure, String>> sendWalkingrequest(
//       WalkingRequest walkingRequest);
// }

import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:dartz/dartz.dart';

abstract class GetCategories {
  Future<Either<Failure,AllCategoriesModel>> getAllCategories();
}
