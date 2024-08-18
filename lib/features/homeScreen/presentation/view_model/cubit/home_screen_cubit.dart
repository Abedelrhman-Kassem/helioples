import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitial());

  bool isCategoryRow = false;

  void changeCategory() {
    isCategoryRow = !isCategoryRow;
    emit(ChangeHomeScreenCategory());
  }
}
