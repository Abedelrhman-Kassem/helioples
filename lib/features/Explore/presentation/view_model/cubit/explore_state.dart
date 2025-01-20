part of 'explore_cubit.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class ExploreLoading extends ExploreState {}

final class ExploreSuccess extends ExploreState {
  final SearchModel searchModel;
  ExploreSuccess(this.searchModel);
}

final class ExploreFailed extends ExploreState {
  final String error;
  ExploreFailed(this.error);
}
