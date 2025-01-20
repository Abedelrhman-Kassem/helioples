part of 'home_layout_cubit.dart';

@immutable
sealed class HomeLayoutState {}

final class HomeLayoutInitial extends HomeLayoutState {}

final class HomeLayoutChangeBottomNav extends HomeLayoutState {}

final class HomeLayoutChangeHomeScreen extends HomeLayoutState {}

final class ChangeHomeScreenCategory extends HomeLayoutState {}

final class FetchCategoriesLoading extends HomeLayoutState {}

final class FetchCategoriesSuccess extends HomeLayoutState {
  final AllCategoriesModel categories;

  FetchCategoriesSuccess(this.categories);
}

final class FetchCategoriesFailure extends HomeLayoutState {
  final String error;

  FetchCategoriesFailure(this.error);
}

final class FetchConfigsLoading extends HomeLayoutState {}

final class FetchConfigsSuccess extends HomeLayoutState {
  final HomeSliderModel homeSliderModel;

  FetchConfigsSuccess(this.homeSliderModel);
}

final class FetchConfigsFailed extends HomeLayoutState {
  final String error;

  FetchConfigsFailed(this.error);
}

final class FetchOffersLoading extends HomeLayoutState {}

final class FetchOffersSuccess extends HomeLayoutState {
  final SpecialOfferModel specialOfferModel;

  FetchOffersSuccess(this.specialOfferModel);
}

final class FetchOffersFailed extends HomeLayoutState {
  final String error;

  FetchOffersFailed(this.error);
}
