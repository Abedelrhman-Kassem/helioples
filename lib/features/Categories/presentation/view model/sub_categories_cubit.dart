import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Categories/presentation/view%20model/sub_categories_states.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

class SubCategoriesCubit extends Cubit<FetchCategoriesState> {
  final SubCategoriesRepoImp repo;
  bool isFetchingMoreProducts = false;
  //List<Products> allProducts = [];

  Map<int,int> subCategoryPages = {} ; 
  Map<int, List<RelatedProductsModel>> subCategoryProducts = {};

  SubCategoriesCubit(this.repo) : super(SubCategoriesInitial());

  Future<void> fetchSubCategories(int categoryId) async {
    emit(SubCategoriesLoading());

    final result = await repo.getSubCategories(categoryId);
    result.fold(
      (failure)  {if(!isClosed) {
        emit(SubCategoriesFailure(failure.errorMessage));
      }},
      (subCategories) { 

        for(var subCategory in subCategories )
        {
          subCategoryPages[subCategory.id!] = 0 ; 
          subCategoryProducts[subCategory.id!] = [];
        }
        emit(SubCategoriesSuccess(subCategories));}
    );
  }

  Future<void> fetchProductsInSubCategory(int subCategoryId, {bool isPagination = false}) async {
    int page = subCategoryPages[subCategoryId] ?? 0 ; 
    print("insdide cubit");
    if (isPagination) {
      if (isFetchingMoreProducts) return;
      isFetchingMoreProducts = true;
      //emit(ProductsPaginationLoading(subCategoryProducts[subCategoryId]!)); 
    } else {
      emit(ProductsLoading());
   
    }

    final result = await repo.getProductsInSubCategory(subCategoryId, page);
    result.fold(
      (failure) {
        print("inside failure");
        isFetchingMoreProducts = false;
        if (isPagination) {
          emit(ProductsPaginationLoading(subCategoryProducts[subCategoryId]!)); 
        } else {
          emit(ProductsFailure(failure.errorMessage));
        }
      },
      (products) {
        print("inside products");
        print(subCategoryProducts[subCategoryId]!.length);
        subCategoryProducts[subCategoryId]!.addAll(products);
        print(subCategoryProducts[subCategoryId]!.length);

        subCategoryPages[subCategoryId] = page + 1 ; 
        isFetchingMoreProducts = false;
        emit(ProductsSuccess(subCategoryProducts[subCategoryId]!));
      },
    );
  }
}
