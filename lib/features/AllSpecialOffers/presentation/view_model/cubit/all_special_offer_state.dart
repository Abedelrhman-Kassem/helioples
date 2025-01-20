part of 'all_special_offer_cubit.dart';

@immutable
sealed class AllSpecialOfferState {}

final class AllSpecialOfferInitial extends AllSpecialOfferState {}

final class ChangeGridAllSpecialOffer extends AllSpecialOfferState {}

final class FetchOffersLoading extends AllSpecialOfferState {}

final class FetchOffersSuccess extends AllSpecialOfferState {
  final SpecialOfferModel specialOfferModel;

  FetchOffersSuccess(this.specialOfferModel);
}

final class FetchOffersFailed extends AllSpecialOfferState {
  final String error;

  FetchOffersFailed(this.error);
}
