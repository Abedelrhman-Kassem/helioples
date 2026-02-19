import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/cache_helper.dart';
import 'package:negmt_heliopolis/features/Liked/data/models/liked_model.dart';
import 'package:negmt_heliopolis/features/Liked/data/repo/liked_repo_imp.dart';

import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  LikedCubit() : super(LikedInitial());

  LikedRepoImp likedRepoImp = LikedRepoImp(ApiService());

  LikedModel likedModel = LikedModel.fromJson({});

  int page = 1;
  int pageSize = 10;
  bool isLoading = false;
  bool endFetching = false;
  List<Products> products = [];

  Future<void> getLikedProducts() async {
    String? token = await CacheHelper.instance.getLocal(tokenKey);

    if (token == null) {
      emit(UnLoggedState());
      return;
    }

    if (isLoading || endFetching) return;

    emit(FetchLikedLoading());
    isLoading = true;

    Either<Failure, LikedModel> res = await likedRepoImp.getAllLikedProducts(
      page: page,
      pageSize: pageSize,
    );

    res.fold(
      (failure) {
        if (!isClosed) {
          isLoading = false;
          emit(FetchLikedFailure(failure.errorMessage));
        }
      },
      (likedProducts) {
        if (!isClosed) {
          products.addAll(likedProducts.data?.items ?? []);
          if ((likedProducts.data?.items ?? []).isEmpty) {
            endFetching = true;
          }
          isLoading = false;
          page++;
          emit(FetchLikedSuccess(likedProducts));
        }
      },
    );
  }

  void removeProduct(String id) {
    products.removeWhere((element) => element.id == id);
    if (products.isEmpty) {
      emit(FetchLikedSuccess(LikedModel.fromJson({})));
    } else {
      emit(
        FetchLikedSuccess(
          LikedModel.fromJson({
            'data': {'items': products},
          }),
        ),
      );
    }
  }
}
