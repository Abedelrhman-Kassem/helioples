import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/Product/data/repo/get_product_repo_imp.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  GetProductImp getCategoriesImp = GetProductImp(
    apiService: ApiService(),
  );

  ProductModel? productModel;

  void getProductDetails(int product) async {
    emit(GetProductLoading());

    Either<Failure, ProductModel> res =
        await getCategoriesImp.getProductDetails(product);

    res.fold(
      (failure) => emit(
        GetProductFailure(failure.errorMessage),
      ),
      (product) => emit(
        GetProductSuccess(product.product!),
      ),
    );
  }
}
