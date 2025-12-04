import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/faqs.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/notification.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/report.dart';

abstract class ProfileRepo {
  Future<Either<Failure, List<Faqs>>> getFaqs();
  Future<Either<Failure, String>> sendReport(Report report);
  Future<Either<Failure, List<Alerts>>> getAlerts();
}
