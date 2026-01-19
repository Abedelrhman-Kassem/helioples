import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:negmt_heliopolis/features/Profile/data/model/report.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/report%20cubit/report_states.dart';

class ReportCubit extends Cubit<SubmitReportState> {
  final ProfileRepoImp repo;

  ReportCubit(this.repo) : super(SubmitReportInitial());

  Future<void> submitReport(Report report) async {
    emit(SubmitReportLoading());

    var result = await repo.sendReport(report);

    result.fold(
      (failure) => emit(SubmitReportFailure(failure.errorMessage)),
      (status) => emit(SubmitReportSuccess(status)),
    );
  }
}
