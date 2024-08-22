import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'all_special_offer_state.dart';

class AllSpecialOfferCubit extends Cubit<AllSpecialOfferState> {
  AllSpecialOfferCubit() : super(AllSpecialOfferInitial());

  bool isGrid = false;

  void changeGrid(BuildContext context, String routeName) {
    isGrid = !isGrid;
    emit(ChangeGridAllSpecialOffer());
  }
}
