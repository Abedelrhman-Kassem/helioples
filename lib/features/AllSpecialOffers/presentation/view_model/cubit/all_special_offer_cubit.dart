import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/home_screen_imp.dart';

part 'all_special_offer_state.dart';

class AllSpecialOfferCubit extends Cubit<AllSpecialOfferState> {
  AllSpecialOfferCubit() : super(AllSpecialOfferInitial());

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
    emit(ChangeGridAllSpecialOffer());
  }

  Future<void> getSpecialOffers({
    required bool homeScreen,
    required int page,
  }) async {
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
        emit(FetchOffersSuccess(offersModel));
      },
    );
  }
}
