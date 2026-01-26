import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_response.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/faqs.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/report.dart';

import 'package:negmt_heliopolis/features/Profile/data/model/customer_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ApiResponse<List<FaqsData>>>> getFaqs(bool isArabic);
  Future<Either<Failure, String>> sendReport(Report report);
  Future<Either<Failure, String>> updateProfile(CustomerModel customer);
  Future<Either<Failure, ApiResponse<CustomerModel>>> getProfile();
}
