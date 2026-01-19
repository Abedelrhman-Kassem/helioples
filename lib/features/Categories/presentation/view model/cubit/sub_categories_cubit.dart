import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/featur_model.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';
import 'package:negmt_heliopolis/features/Categories/data/repo/sub_categories_repo_imp.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  final SubCategoriesRepoImp repo;
  SubCategoriesCubit({required this.repo}) : super(SubCategoriesStateInitial());

  final SubCategoriesNotifier notifier = SubCategoriesNotifier();
  List<FeaturData> featuresList = [];
  List<Products> productsListFeatured = [];
  CategoryModel? category;

  Future<void> fetchSubCategories(
    String categoryId, {
    CategoryModel? categoryModel,
  }) async {
    emit(LoadingMainSubCategories());

    if (categoryModel != null) {
      category = categoryModel;
    } else {
      // Fetch category if not provided (from notification)
      try {
        final allCategoriesResult = await repo.api.get(
          endpoint: AppUrls.getCategoriesUrl(page: 1, pageSize: 100),
        );
        final allCategories = AllCategoriesModel.fromJson(allCategoriesResult);
        category = allCategories.categories.firstWhere(
          (c) => c.id == categoryId,
        );
      } catch (e) {
        log("Error fetching category details: $e");
      }
    }

    // Fetch both requests concurrently
    final results = await Future.wait([
      repo.getSubCategories(categoryId),
      repo.getFeatures(categoryId),
    ]);

    final subCategoriesResult =
        results[0] as Either<Failure, List<SubCatByCatidData>>;
    final featuresResult = results[1] as Either<Failure, FeaturMdel>;

    // Handle SubCategories result
    subCategoriesResult.fold(
      (failure) => emit(GetMainSubCategoriesFailed(failure.errorMessage)),
      (subCategories) {
        // Handle Features result inside success of SubCategories
        featuresResult.fold(
          (failure) {
            // Log error but proceed with empty features
            // log("Failed to fetch features: ${failure.errorMessage}");
          },
          (featuresModel) {
            featuresList = featuresModel.features;
          },
        );

        emit(
          GetMainSubCategoriesSuccess(
            subCategories,
            features: featuresList,
            category: category,
          ),
        );
      },
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
    // log("subCategoriesPages ${subCategoriesPages[subCategoryId]! + 2}");
    // log(
    //   "fetchProductsInSubCategory $subCategoryId",
    //   time: DateTime.now(),
    // );

    notifier.isFetching[subCategoryId] = true;
    notifier.triggerNotification();

    Either<Failure, List<Products>> response = await repo
        .getProductsInSubCategory(
          subCategoryId,
          (subCategoriesPages[subCategoryId] ?? 0) + 2,
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
            (subCategoriesPages[subCategoryId] ?? 0) + 1;

        notifier.subCategoriesProducts[subCategoryId] = subCategoriesProducts;

        notifier.isFetching[subCategoryId] = false;

        notifier.triggerNotification();
      },
    );
  }

  Map<String, int> productsFeaturedPages = {};

  Future<void> fetchProductsFeatured(
    String featureId,
    BuildContext context,
  ) async {
    if (notifier.isFetching[featureId] == true ||
        notifier.endFetching[featureId] == true) {
      return;
    }
    // log("subCategoriesPages ${subCategoriesPages[subCategoryId]! + 2}");
    // log(
    //   "fetchProductsInSubCategory $subCategoryId",
    //   time: DateTime.now(),
    // );

    notifier.isFetching[featureId] = true;
    notifier.triggerNotification();

    Either<Failure, List<Products>> response = await repo.getProductsFeatured(
      featureId,
      (productsFeaturedPages[featureId] ?? 0) + 2,
      10,
    );

    response.fold(
      (failure) {
        log("failure ${failure.errorMessage}");
        CustomSnackBar.show(
          context: context,
          duration: const Duration(seconds: 10),
          text: failure.errorMessage,
          isGreen: false,
        );

        notifier.isFetching[featureId] = false;
        notifier.endFetching[featureId] = true;
        notifier.triggerNotification();
      },
      (subCategoriesProducts) {
        if (subCategoriesProducts.isEmpty) {
          notifier.endFetching[featureId] = true;
        }

        productsFeaturedPages[featureId] =
            (productsFeaturedPages[featureId] ?? 0) + 1;

        notifier.productsFeatured[featureId] = subCategoriesProducts;

        notifier.isFetching[featureId] = false;

        notifier.triggerNotification();
      },
    );
  }

  // Future<void> fetchAllPRoductsOfSubCategory(int subCategoryId) async {}
}
