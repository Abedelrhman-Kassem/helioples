import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
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

  GetPricesRepoImp getPricesRepoImp = GetPricesRepoImp(
    apiService: Get.find<ApiService>(),
  );

  UpdateCartModel? updateCartModel;

  List<Map<String, Object?>> tableValues = [];
  List<Map<String, Object?>> tableIdValues = [];

  void getCartProducts() async {
    emit(CartLoadingState());
    log("start getCartProducts");

    List<String> ids = [];

    tableIdValues = await DBHelper.queryData(
      table: cartTable,
      columns: [cartItemId],
    );

    for (var value in tableIdValues) {
      ids.add(value[cartItemId] as String);
    }

    Either<Failure, UpdateCartModel> res = await getPricesRepoImp
        .getCartProducts(ids);

    res.fold(
      (failure) => {
        if (!isClosed) {emit(CartFailedState(error: failure.errorMessage))},
      },
      (updateCart) async {
        tableValues = await updateDBData(updateCart);
        DbChangeNotifier productsCount = DbChangeNotifier();
        productsCount.fetchItemCount();
        updateCartModel = updateCart;

        if (!isClosed) {
          emit(CartSuccessState(updateCartModel: updateCart));
        }
      },
    );
  }

  Future<List<Map<String, Object?>>> updateDBData(
    UpdateCartModel updateCartModel,
  ) async {
    tableValues = await DBHelper.queryData(table: cartTable);

    for (var product in updateCartModel.products!) {
      if (product.availableQuantity! == 0) {
        await DBHelper.deleteData(
          table: cartTable,
          where: 'id = ?',
          whereArgs: [product.id],
        );
      } else {
        Map<String, dynamic> values = {
          cartItemPrice: product.price!,
          cartItemDiscount: product.discount ?? 0,
        };

        for (var item in tableValues) {
          if (item[cartItemId] == product.id &&
              item[cartItemQty] as int > product.availableQuantity!) {
            values[cartItemQty] = product.availableQuantity;
          }
        }

        await DBHelper.updateData(
          table: cartTable,
          values: values,
          where: 'id = ?',
          whereArgs: [product.id],
        );
      }
    }
    return DBHelper.queryData(table: cartTable);
  }

  Future<void> deleteItem(String id) async {
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

  int getAvailablePieces(String id) {
    for (var product in updateCartModel!.products!) {
      if (product.id == id) {
        return product.availableQuantity!;
      }
    }
    throw Exception('Product with id $id not found');
  }
}
