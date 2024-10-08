import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/get_all_categories_repo_imp.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  bool isCategoryRow = false;

  void changeCategory() {
    isCategoryRow = !isCategoryRow;
    emit(ChangeHomeScreenCategory());
  }

  GetCategoriesImp getCategoriesImp = GetCategoriesImp(
    apiService: ApiService(),
  );
  AllCategoriesModel allCategoriesModel = AllCategoriesModel.fromJson({});

  Future<void> getAllCategories() async {
    Either<Failure, AllCategoriesModel> res =
        await getCategoriesImp.getAllCategories();
    res.fold(
      (failure) => emit(
        FetchCategoriesFailure(failure.errorMessage),
      ),
      (categories) => emit(
        FetchCategoriesSuccess(categories),
      ),
    );
  }
}
