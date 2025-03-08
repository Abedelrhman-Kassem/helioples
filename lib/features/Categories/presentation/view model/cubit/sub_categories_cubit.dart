import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  SubCategoriesCubit() : super(SubCategoriesStateInitial());

  final SubCategoriesRepoImp repo = SubCategoriesRepoImp(api: ApiService());

  final SubCategoriesNotifier notifier = SubCategoriesNotifier();

  Future<void> fetchSubCategories(int categoryId) async {
    emit(LoadingMainSubCategories());

    Either<Failure, List<SubCategories>> response =
        await repo.getSubCategories(categoryId);

    response.fold(
      (failure) => emit(GetMainSubCategoriesFailed(failure.errorMessage)),
      (subCategories) => emit(GetMainSubCategoriesSuccess(subCategories)),
    );
  }

  Map<int, int> subCategoriesPages = {};

  Future<void> fetchProductsInSubCategory(
    int subCategoryId,
    BuildContext context,
  ) async {
    if (notifier.isFetching[subCategoryId] == true ||
        notifier.endFetching[subCategoryId] == true) {
      return;
    }

    notifier.isFetching[subCategoryId] = true;
    notifier.triggerNotification();

    Either<Failure, List<RelatedProductsModel>> response =
        await repo.getProductsInSubCategory(
      subCategoryId,
      subCategoriesPages[subCategoryId]!,
    );

    response.fold(
      (failure) {
        CustomSnackBar.show(
          context: context,
          duration: const Duration(seconds: 10),
          text: failure.errorMessage,
          isGreen: false,
        );

        notifier.isFetching[subCategoryId] = false;
        notifier.endFetching[subCategoryId] = true;
        notifier.triggerNotification();
      },
      (subCategoriesProducts) {
        if (subCategoriesProducts.isEmpty) {
          notifier.endFetching[subCategoryId] = true;
        }

        subCategoriesPages[subCategoryId] =
            subCategoriesPages[subCategoryId]! + 1;

        notifier.subCategoriesProducts[subCategoryId] = subCategoriesProducts;

        notifier.isFetching[subCategoryId] = false;

        notifier.triggerNotification();
      },
    );
  }

  Future<void> fetchAllPRoductsOfSubCategory(int subCategoryId) async {}
}
