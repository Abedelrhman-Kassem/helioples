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

  List<Widget> screens = const [
    HomeScreen(),
    ExploreScreen(),
    LikedScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  void changeCurrentIndex(int index) {
    if (selectedIndex != index) {
      selectedIndex = index;
      emit(HomeLayoutChangeBottomNav());
    }
  }
}
