import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/profile%20cubit/faqs_states.dart';

class FaqsCubit extends Cubit<FetchFaqsState> {
  final ProfileRepoImp repo;
  FaqsCubit(this.repo) : super(FetchFaqsInitial());

  Future<void> fetchFaqs() async {
    emit(FetchFaqsLoading());
    var result = await repo.getFaqs();

    result.fold((failure) => emit(FetchFaqsFailure(failure.errorMessage)),
        (faqs) => emit(FetchFaqsSuccess(faqs)));
  }
}
