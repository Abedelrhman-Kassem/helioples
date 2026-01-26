part of 'explore_cubit.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class ExploreLoading extends ExploreState {}

final class ExploreSuccess extends ExploreState {
  final List<Products> products;
  ExploreSuccess(this.products);
}

final class ExploreFailed extends ExploreState {
  final String error;
  ExploreFailed(this.error);
}
