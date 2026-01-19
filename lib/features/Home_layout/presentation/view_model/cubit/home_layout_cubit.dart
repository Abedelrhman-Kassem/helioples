import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/cart_screen.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/explore_screen.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/liked_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/profile_screen.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/all_categories_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/home_slider_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/repo/home_screen_imp.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/home_screen.dart';
import 'package:negmt_heliopolis/core/utlis/services/services_helper.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial()) {
    loadCategoryPreference();
  }

  String? token;

  // Future<void> _init() async {
  //   token = await ApiService.getToken();
  // }

  int selectedIndex = 0;
  int previousIndex = 0;

  List<Widget> screens = const [
    HomeScreen(),
    ExploreScreen(),
    LikedScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  List<int> previousIndexList = [0];

  void changeCurrentIndex(BuildContext context, int index) {
    if (selectedIndex != index) {
      previousIndex = selectedIndex;
      selectedIndex = index;

      if (index == 0) {
        previousIndexList = [];
      }

      previousIndexList.add(index);

      emit(HomeLayoutChangeBottomNav());
    }
  }

  void returnIndex(BuildContext context) {
    if (previousIndexList.length >= 2) {
      previousIndexList.removeLast();
      previousIndex = previousIndexList.removeLast();

      changeCurrentIndex(context, previousIndex);
    } else {
      changeCurrentIndex(context, 0);
    }
  }

  // home screen things
  bool isCategoryRow = false;

  bool gettingCategories = false;
  bool gettingConfigs = false;
  bool gettingOffers = false;

  List<CategoryModel> categories = [];

  List<ItemSlider> configs = [];

  List<Offer> offers = [];

  void changeCategory() {
    isCategoryRow = !isCategoryRow;
    ServicesHelper.saveLocal('isCategoryRow', isCategoryRow.toString());
    emit(ChangeHomeScreenCategory());
  }

  void loadCategoryPreference() async {
    final savedIsCategoryRow = await ServicesHelper.getLocal('isCategoryRow');
    if (savedIsCategoryRow != null) {
      isCategoryRow = savedIsCategoryRow == 'true';
      emit(ChangeHomeScreenCategory());
    }
  }

  HomeScreenRepoImp homeScreenImp = HomeScreenRepoImp(
    apiService: Get.find<ApiService>(),
  );

  Future<void> getAllCategories({
    required bool homeScreen,
    required int page,
    required int pageSize,
  }) async {
    emit(FetchCategoriesLoading());

    Either<Failure, AllCategoriesModel> res = await homeScreenImp
        .getAllCategories(
          homeScreen: homeScreen,
          page: page,
          pageSize: pageSize,
        );

    res.fold((failure) => emit(FetchCategoriesFailure(failure.errorMessage)), (
      categories,
    ) {
      gettingCategories = true;
      emit(FetchCategoriesSuccess(categories));
    });
  }

  Future<void> getConfigs() async {
    emit(FetchConfigsLoading());

    Either<Failure, HomeSliderModel> res = await homeScreenImp.getConfigs();

    res.fold((failure) => emit(FetchConfigsFailed(failure.errorMessage)), (
      homeSliderModel,
    ) {
      gettingConfigs = true;
      emit(FetchConfigsSuccess(homeSliderModel));
    });
  }

  int page = 1;
  bool isLoading = false;
  bool isLastPage = false;
  Future<void> getSpecialOffers({required bool homeScreen}) async {
    if (isLastPage) return;
    isLoading = true;
    emit(FetchOffersLoading());

    Either<Failure, SpecialOfferModel> res = await homeScreenImp
        .getSpecialOffers(homeScreen: homeScreen, page: page);

    res.fold(
      (failure) {
        isLoading = false;
        emit(FetchOffersFailed(failure.errorMessage));
      },
      (offersModel) {
        isLoading = false;
        gettingOffers = true;
        offers.addAll(offersModel.data!.items);
        page++;
        if (offersModel.data!.items.isEmpty) {
          isLastPage = true;
        }
        emit(FetchOffersSuccess(offersModel));
      },
    );
  }
}
