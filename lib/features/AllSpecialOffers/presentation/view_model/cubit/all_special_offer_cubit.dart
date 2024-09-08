import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'all_special_offer_state.dart';

class AllSpecialOfferCubit extends Cubit<AllSpecialOfferState> {
  AllSpecialOfferCubit() : super(AllSpecialOfferInitial());

  double initialOffset = 0;
  bool isGrid = false;

  void changeOffset() {
    if (isGrid) {
      initialOffset += 1.5;
    } else {
      initialOffset -= 1.5;
    }
    isGrid = !isGrid;
    emit(ChangeGridAllSpecialOffer());
  }
}
