import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());

  int oldCardNumLength = 0;

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardNameController = TextEditingController();
  TextEditingController cardExpDateController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();

  @override
  Future<void> close() {
    cardNumberController.dispose();
    cardNameController.dispose();
    cardExpDateController.dispose();
    cardCvvController.dispose();
    return super.close();
  }
}
