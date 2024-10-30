import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/sub_categories_states.dart';

class SubCategoriesCubit extends Cubit<FetchSubCatigoriesState>
{
  SubCategoriesRepoImp repo ;
  List<SubCategories> subCategoriesList = [];
  int currentPage = 1 ; 
  bool isFetching = false ; 
  SubCategoriesCubit(this.repo) : super(FetchSubCatigoriesInitial());
  Future<void> fetchSubCatigories(int id) async {
  if (isFetching) return; // Prevent fetching if already in progress
  isFetching = true; 
  emit(FetchSubCatigoriesLoading());

  var result = await repo.getSubCategories(currentPage, id); 
  result.fold((failure) {
    emit(FetchSubCatigoriesFailure(failure.errorMessage));
    isFetching = false; 
  }, (fetchedSubCategories) {
    if (fetchedSubCategories.isNotEmpty) {
      subCategoriesList.addAll(fetchedSubCategories); // Correct assignment
      currentPage++;
      emit(FetchSubCatigoriesSuccess(subCategoriesList));  // Emit with updated list
    }
    isFetching = false; 
  });
}




  


}