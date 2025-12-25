import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/home_screen_imp.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';

part 'all_special_offer_state.dart';

class AllSpecialOfferCubit extends Cubit<AllSpecialOfferState> {
  AllSpecialOfferCubit() : super(AllSpecialOfferInitial()) {
    loadViewPreference();
  }

  double initialOffset = 0;
  bool isGrid = false;

  HomeScreenRepoImp offersRepo = HomeScreenRepoImp(apiService: ApiService());

  void changeOffset() {
    if (isGrid) {
      initialOffset += 1.5;
    } else {
      initialOffset -= 1.5;
    }
    isGrid = !isGrid;
    ServicesHelper.saveLocal('all_special_offers_is_grid', isGrid.toString());
    emit(ChangeGridAllSpecialOffer());
  }

  void loadViewPreference() async {
    final savedIsGrid =
        await ServicesHelper.getLocal('all_special_offers_is_grid');
    if (savedIsGrid != null) {
      isGrid = savedIsGrid == 'true';
      if (isGrid) {
        initialOffset = -1.5;
      } else {
        initialOffset = 0;
      }
      emit(ChangeGridAllSpecialOffer());
    }
  }

  int page = 1;
  List<Offer> offers = [];
  bool isLoading = false;
  bool isLastPage = false;
  Future<void> getSpecialOffers({
    bool? homeScreen,
  }) async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    emit(FetchOffersLoading());

    Either<Failure, SpecialOfferModel> res = await offersRepo.getSpecialOffers(
      homeScreen: homeScreen,
      page: page,
    );

    res.fold(
      (failure) => emit(
        FetchOffersFailed(failure.errorMessage),
      ),
      (offersModel) {
        offers.addAll(offersModel.data!.items);
        page++;
        if (offersModel.data!.items.isEmpty) {
          isLastPage = true;
        }
        emit(FetchOffersSuccess(offersModel));
      },
    );
    isLoading = false;
  }
}
