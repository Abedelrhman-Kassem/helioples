part of 'home_screen_cubit.dart';

@immutable
sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class ChangeHomeScreenCategory extends HomeScreenState {}

final class FetchCategoriesLoading extends HomeScreenState {}

final class FetchCategoriesSuccess extends HomeScreenState {
  final AllCategoriesModel categories;

  FetchCategoriesSuccess(this.categories);
}

final class FetchCategoriesFailure extends HomeScreenState {
  final String message;

  FetchCategoriesFailure(this.message);
}
