import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }

  TextEditingController searchController = TextEditingController();

  void changeSearchExplore(String value) {
    if (value.length > 3) {
      canSearch = true;
    } else {
      canSearch = false;
    }

    searchController.text = value;
    emit(ChangeSearchExplore());
  }

  bool canSearch = false;
}
