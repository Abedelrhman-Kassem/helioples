import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/features/Cart/presentation/view/cart_screen.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/explore_screen.dart';
import 'package:negmt_heliopolis/features/Liked/presentation/view/liked_screen.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/profile_screen.dart';
import 'package:negmt_heliopolis/features/homeScreen/presentation/view/home_screen.dart';

part 'home_layout_state.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutState> {
  HomeLayoutCubit() : super(HomeLayoutInitial());

  int selectedIndex = 0;
  int previousIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    const ExploreScreen(),
    const LikedScreen(),
    const CartScreen(),
    const ProfileScreen(),
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
    previousIndexList.removeLast();
    previousIndex = previousIndexList.removeLast();

    changeCurrentIndex(context, previousIndex);
  }
}
