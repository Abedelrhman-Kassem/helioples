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

  bool canSearch = false;

  void getSearchApi(String value) {
    if (value.length > 1) {
      canSearch = true;
    } else {
      canSearch = false;
    }

    searchController.text = value;
    emit(ChangeSearchExplore());
  }

  bool isSearching = false;

  void changeIsSearching(bool search) {
    isSearching = search;
    emit(SearchTapExplore());
  }
}
