part of 'special_offers_item_cubit.dart';

sealed class SpecialOffersItemState {}

final class SpecialOffersInitial extends SpecialOffersItemState {}

final class SpecialOfferLoading extends SpecialOffersItemState {}

final class SpecialOffersSuccess extends SpecialOffersItemState {
  SpecialOfferItemModel specialOfferItemModel;
  SpecialOffersSuccess(this.specialOfferItemModel);
}

final class SpecialOffersFailed extends SpecialOffersItemState {
  String error;
  SpecialOffersFailed(this.error);
}
