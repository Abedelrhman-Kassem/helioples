import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Liked/data/models/liked_model.dart';
import 'package:negmt_heliopolis/features/Liked/data/repo/liked_repo_imp.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  LikedCubit() : super(LikedInitial());

  LikedRepoImp likedRepoImp = LikedRepoImp(ApiService());

  LikedModel likedModel = LikedModel.fromJson({});

  int page = 0;

  Future<void> getAllLikedProducts() async {
    String? token = await ApiService.getToken();
    if (token == null) {
      emit(UnLoggedState());
      return;
    }

    emit(FetchLikedLoading());

    Either<Failure, LikedModel> res =
        await likedRepoImp.getAllLikedProducts(page);

    res.fold(
      (failure) {
        if (!isClosed) {
          emit(
            FetchLikedFailure(failure.errorMessage),
          );
        }
      },
      (likedProducts) {
        if (!isClosed) {
          emit(
            FetchLikedSuccess(likedProducts),
          );
        }
      },
    );
  }
}
