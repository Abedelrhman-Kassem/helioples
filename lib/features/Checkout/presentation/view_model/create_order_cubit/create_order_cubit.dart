import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/cancel_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/promocode_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/create_repo_imp.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());

  CreateOrderImp createOrderImp = CreateOrderImp(
    apiService: ApiService(),
  );

  void createOrder(CreateOrderModel data) async {
    emit(CreateOrderLoading());

    Either<Failure, OrderDetailsModel> res =
        await createOrderImp.createOrder(data);

    res.fold(
      (failure) => emit(
        CreateOrderFailed(failure.errorMessage),
      ),
      (orderDetailsModel) => emit(
        CreateOrderSuccess(orderDetailsModel),
      ),
    );
  }

  double calcPromoCode(double totalPrice, double promoCodeValue) {
    return double.parse(
      (totalPrice * (promoCodeValue / 100)).toStringAsFixed(2),
    );
  }

  void checkPromoCode(String code) async {
    emit(CheckPromoCodeLoading());

    Either<Failure, PromoCodeModel> res =
        await createOrderImp.checkPromoCode(code.trim());

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

  void cancelOrder(String reason, int orderId) async {
    emit(CancelOrderLoading());

    Either<Failure, CancelOrderModel> res =
        await createOrderImp.cancelOrder(orderId, reason);

    res.fold(
      (failure) => emit(
        CancelOrderFailed(failure.errorMessage),
      ),
      (cancelOrderModel) => emit(
        CancelOrderSuccess(cancelOrderModel),
      ),
    );
  }

  void getBranches() async {
    emit(BranchesLoading());

    Either<Failure, BranchesModel> res = await createOrderImp.getAllBranches();

    res.fold(
      (failure) => emit(
        BranchesFailed(failure.errorMessage),
      ),
      (branches) => emit(
        BranchesSuccess(branches),
      ),
    );
  }
}
