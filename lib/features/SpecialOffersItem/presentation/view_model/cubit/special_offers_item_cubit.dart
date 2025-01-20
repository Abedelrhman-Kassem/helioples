import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/model/offer_item_model.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/repo/get_offer_item_imp.dart';

part 'special_offers_item_state.dart';

class SpecialOffersItemCubit extends Cubit<SpecialOffersItemState> {
  SpecialOffersItemCubit() : super(SpecialOffersInitial());

  GetOfferItemImp getOfferItemImp = GetOfferItemImp(ApiService());

  void getOffer({required int id}) async {
    emit(SpecialOfferLoading());

    Either<Failure, SpecialOfferItemModel> res =
        await getOfferItemImp.getSpecialOfferItem(id: id, page: 0);

    res.fold(
      (failure) => emit(
        SpecialOffersFailed(failure.errorMessage),
      ),
      (specialOfferItemModel) => emit(
        SpecialOffersSuccess(specialOfferItemModel),
      ),
    );
  }
}
