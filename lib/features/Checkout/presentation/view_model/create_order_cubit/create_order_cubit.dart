import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/promocode_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/delivery_repo_imp.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/promocode_repo_imp.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CheckoutInitial());

  CreateOrderImp createOrderImp = CreateOrderImp(
    apiService: ApiService(),
  );

  PromocodeRepoImp promocodeRepoImp =
      PromocodeRepoImp(apiService: ApiService());

  void createOrder(CreateOrderModel data) async {
    emit(CreateOrderLoading());

    Either<Failure, OrderDetailsModel> res =
        await createOrderImp.createOrder(data);

    res.fold(
      (failure) => emit(
        CreateOrderFailed(failure.errorMessage),
      ),
      (orderDetailsModel) => emit(
        CreateOrderSuccess(orderDetailsModel.order!),
      ),
    );
  }

  double promoCodeValue = 0;
  void checkPromoCode(String code) async {
    emit(CreateOrderLoading());

    Either<Failure, PromoCodeModel> res =
        await promocodeRepoImp.checkPromoCode(code.trim());

    res.fold(
      (failure) => emit(
        CheckPromoCodeFailed(failure.errorMessage),
      ),
      (promoCodeModel) => emit(
        CheckPromoCodeSuccess(promoCodeModel),
      ),
    );
  }

  void tipsToBottomSheet(double tips) {
    emit(TipsToBottomSheet(tips));
  }
}
