part of 'explore_cubit.dart';

@immutable
sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class ChangeSearchExplore extends ExploreState {}

final class SearchTapExplore extends ExploreState {}
