import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Product/data/model/product_model.dart';
import 'package:negmt_heliopolis/features/Product/data/repo/get_product_repo_imp.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  GetProductImp getCategoriesImp = GetProductImp(
    apiService: Get.find<ApiService>(),
  );
  bool isLoading = false;
  bool isFirstFetch = true;

  ProductDetailsModel? productModel;
  int page = 1;
  int pageSize = 15;
  List<Products> products = [];
  void getProductDetails(String product) async {
    isLoading = true;
    emit(GetProductLoading());

    Either<Failure, ProductDetailsModel> res = await getCategoriesImp
        .getProductDetails(product, page, pageSize);

    res.fold(
      (failure) => {
        if (!isClosed) {emit(GetProductFailure(failure.errorMessage))},
      },
      (product) => {
        productModel = product,
        products.addAll(product.data!.relatedProducts!.items),
        if (!isClosed) {emit(GetProductSuccess(product))},
      },
    );
    isLoading = false;
    page++;
    if (isFirstFetch) {
      Future.delayed(const Duration(milliseconds: 300), () {
        isFirstFetch = false;
      });
    }
  }
}
