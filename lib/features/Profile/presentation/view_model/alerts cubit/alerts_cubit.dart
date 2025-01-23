import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/alerts%20cubit/alerts_states.dart';

class AlertsCubit  extends Cubit<FetchAlertsState>{

  final ProfileRepo repo ; 
   AlertsCubit(this.repo) : super(FetchAlertsInitial());

   Future<void> getAlerts () async
   {
    emit(FetchAlertsLoading());
    var result = await repo.getAlerts();

    result.fold((failure)=> emit(FetchAlertsFailure(failure.errorMessage)),(alerts)=> emit(FetchAlertsSuccess(alerts)) );

   }
}