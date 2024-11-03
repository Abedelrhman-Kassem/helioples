import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/sub_categories_states.dart';

class SubCategoriesCubit extends Cubit<FetchCategoriesState> {
  final SubCategoriesRepoImp repo;
  bool isFetchingMoreProducts = false;
  List<Products> allProducts = [];

  SubCategoriesCubit(this.repo) : super(SubCategoriesInitial());

  Future<void> fetchSubCategories(int categoryId) async {
    emit(SubCategoriesLoading());

    final result = await repo.getSubCategories(categoryId);
    result.fold(
      (failure) => emit(SubCategoriesFailure(failure.errorMessage)),
      (subCategories) => emit(SubCategoriesSuccess(subCategories)),
    );
  }

  Future<void> fetchProductsInSubCategory(int subCategoryId, int page, {bool isPagination = false}) async {
    if (isPagination) {
      if (isFetchingMoreProducts) return;
      isFetchingMoreProducts = true;
      emit(ProductsPaginationLoading(allProducts)); 
    } else {
      emit(ProductsLoading());
      allProducts = []; 
    }

    final result = await repo.getProductsInSubCategory(subCategoryId, page);
    result.fold(
      (failure) {
        isFetchingMoreProducts = false;
        if (isPagination) {
          emit(ProductsPaginationLoading(allProducts)); 
        } else {
          emit(ProductsFailure(failure.errorMessage));
        }
      },
      (products) {
        allProducts.addAll(products);
        isFetchingMoreProducts = false;
        emit(ProductsSuccess(allProducts));
      },
    );
  }
}
