import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/address_repo_imp.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/home_screen_imp.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  List<Map<String, Object?>>? tableValues;
  Future<void> clearDb() async {
    tableValues = await DBHelper.queryData(table: cartTable);

    await DBHelper.deleteData(table: cartTable);
  }

  GetAddressessImp getAddressessImp = GetAddressessImp(ApiService());

  HomeScreenRepoImp homeScreenImp = HomeScreenRepoImp(
    apiService: Get.put(ApiService(), permanent: true),
  );

  bool loadingCategories = false;
  bool endFetching = false;
  List<CategoryModel> categories = [];
  int page = 1;

  Future<void> getAllCategories() async {
    emit(FetchMainCubitCategoriesLoading());
    loadingCategories = true;
    Either<Failure, AllCategoriesModel> res = await homeScreenImp
        .getAllCategories(
          // homeScreen: homeScreen,
          page: page,
          pageSize: 20,
        );
    res.fold(
      (failure) => emit(FetchMainCubitCategoriesFailure(failure.errorMessage)),
      (categoriesModel) {
        if (categoriesModel.categories.isEmpty) {
          endFetching = true;
        }
        categories.addAll(categoriesModel.categories);
        page++;
        emit(FetchMainCubitCategoriesSuccess(categoriesModel));
      },
    );
    loadingCategories = false;
  }
}
