import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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

  GetCategoriesImp getCategoriesImp = GetCategoriesImp();
  AllCategoriesModel allCategoriesModel = AllCategoriesModel.fromJson({});

  getAllCategories() async {
    var response = await getCategoriesImp.getAllCategories();
    allCategoriesModel = response;
    print(allCategoriesModel.categories);
    emit(ChangeHomeScreenCategory());
  }
}
