import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Explore/data/models/search_model.dart';
import 'package:negmt_heliopolis/features/Explore/data/repo/search_repo_imp.dart';

part 'explore_state.dart';

class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit() : super(ExploreInitial());

  SearchRepoImp searchRepoImp = SearchRepoImp(ApiService());

  void insertSearchDbData(String value) async {
    int row = await DBHelper.insertData(
      table: searchTable,
      values: {
        searchItemName: value,
      },
    );
    print(row);
  }

  void search(String query, int page) async {
    emit(ExploreLoading());

    Either<Failure, SearchModel> res =
        await searchRepoImp.search(query: query, page: page);

    res.fold(
      (failure) {
        if (!isClosed) {
          emit(
            ExploreFailed(failure.errorMessage),
          );
        }
      },
      (products) {
        if (!isClosed) {
          emit(
            ExploreSuccess(products),
          );
        }
      },
    );
  }
}
