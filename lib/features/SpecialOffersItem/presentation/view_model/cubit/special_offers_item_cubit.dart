import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/model/offer_item_model.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/data/repo/get_offer_item_imp.dart';

part 'special_offers_item_state.dart';

class SpecialOffersItemCubit extends Cubit<SpecialOffersItemState> {
  SpecialOffersItemCubit() : super(SpecialOffersInitial());

  GetOfferItemImp getOfferItemImp = GetOfferItemImp(Get.find<ApiService>());
  int page = 1;
  int pageSize = 10;
  bool isLoading = false;
  List<Products> products = [];
  void getOffer({required String id}) async {
    isLoading = true;
    emit(SpecialOfferLoading());

    Either<Failure, SpecialOfferItemModel> res = await getOfferItemImp
        .getSpecialOfferItem(id: id, page: page, pageSize: pageSize);

    if (isClosed) return;

    res.fold(
      (failure) => emit(
        SpecialOffersFailed(failure.errorMessage),
      ),
      (specialOfferItemModel) {
        for (var product in specialOfferItemModel.offer!.pagedProducts!.items) {
          if (!products.any((element) => element.id == product.id)) {
            products.add(product);
          }
        }
        page++;
        emit(
          SpecialOffersSuccess(specialOfferItemModel),
        );
      },
    );
    isLoading = false;
  }
}
