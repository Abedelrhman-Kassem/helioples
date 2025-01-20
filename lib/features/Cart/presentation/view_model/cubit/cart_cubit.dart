import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/db_change_notifier.dart';
import 'package:negmt_heliopolis/features/Cart/data/model/update_cart_model.dart';
import 'package:negmt_heliopolis/features/Cart/data/repo/get_prices_repo_imp.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  GetPricesRepoImp getPricesRepoImp =
      GetPricesRepoImp(apiService: ApiService());

  UpdateCartModel? updateCartModel;

  List<Map<String, Object?>> tableValues = [];
  List<Map<String, Object?>> tableIdValues = [];

  void getCartProducts() async {
    emit(CartLoadingState());

    List<int> ids = [];

    tableIdValues = await DBHelper.queryData(
      table: cartTable,
      columns: [cartItemId],
    );

    for (var value in tableIdValues) {
      ids.add(value[cartItemId] as int);
    }

    Either<Failure, UpdateCartModel> res =
        await getPricesRepoImp.getCartProducts(ids);

    res.fold(
      (failure) => {
        if (!isClosed) {emit(CartFailedState(error: failure.errorMessage))}
      },
      (updateCart) async {
        tableValues = await updateDBData(updateCart);
        DbChangeNotifier productsCount = DbChangeNotifier();
        productsCount.fetchItemCount();

        if (!isClosed) {
          emit(CartSuccessState(updateCartModel: updateCart));
        }
      },
    );
  }

  Future<List<Map<String, Object?>>> updateDBData(
      UpdateCartModel updateCartModel) async {
    updateCartModel.products!.forEach((product) async {
      if (product.availabelPieces! == 0) {
        await DBHelper.deleteData(
          table: cartTable,
          where: 'id = ?',
          whereArgs: [product.id],
        );
      } else {
        await DBHelper.updateData(
          table: cartTable,
          values: {
            cartItemPrice: product.price!,
            cartItemDiscount: product.currentDiscount ?? 0,
          },
          where: 'id = ?',
          whereArgs: [product.id],
        );
      }
    });
    return DBHelper.queryData(table: cartTable);
  }

  Future<void> deleteItem(int id) async {
    emit(CartLoadingState());
    try {
      await DBHelper.deleteData(
        table: cartTable,
        where: 'id = ?',
        whereArgs: [id],
      );

      List<Map<String, dynamic>> mutableTableValues = List.from(tableValues);
      mutableTableValues.removeWhere((element) => element[cartItemId] == id);

      tableValues = mutableTableValues;

      emit(CartDeletingState());
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }
}
