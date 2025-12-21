import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final SubCategoriesRepoImp repo;
  SubCategoriesCubit({required this.repo}) : super(SubCategoriesStateInitial());

  final SubCategoriesNotifier notifier = SubCategoriesNotifier();

  Future<void> fetchSubCategories(String categoryId) async {
    emit(LoadingMainSubCategories());

    Either<Failure, List<SubCatByCatidData>> response =
        await repo.getSubCategories(categoryId);

    response.fold(
      (failure) => emit(GetMainSubCategoriesFailed(failure.errorMessage)),
      (subCategories) => emit(GetMainSubCategoriesSuccess(subCategories)),
    );
  }

  Map<String, int> subCategoriesPages = {};

  Future<void> fetchProductsInSubCategory(
    String subCategoryId,
    BuildContext context,
  ) async {
    if (notifier.isFetching[subCategoryId] == true ||
        notifier.endFetching[subCategoryId] == true) {
      return;
    }
    log("subCategoriesPages ${subCategoriesPages[subCategoryId]! + 2}");
    log(
      "fetchProductsInSubCategory $subCategoryId",
      time: DateTime.now(),
    );

    notifier.isFetching[subCategoryId] = true;
    notifier.triggerNotification();

    Either<Failure, List<Products>> response =
        await repo.getProductsInSubCategory(
      subCategoryId,
      subCategoriesPages[subCategoryId]! + 2,
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
