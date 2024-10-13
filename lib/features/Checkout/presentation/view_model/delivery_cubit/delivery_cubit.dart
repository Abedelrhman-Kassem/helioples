import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:negmt_heliopolis/core/utlis/errors/failure.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/order_details_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/repo/delivery_repo_imp.dart';

part 'delivery_state.dart';

class DeliveryCubit extends Cubit<DeliveryState> {
  DeliveryCubit() : super(CheckoutInitial());

  CreateOrderImp getCategoriesImp = CreateOrderImp(
    apiService: ApiService(),
  );

  OrderDetailsModel? orderDetailsModel;

  void createOrder() async {
    emit(CreateOrderLoading());

    Either<Failure, dynamic> res = await getCategoriesImp.createOrder(
      {
        "deliverMethod": "OnBranch",
        "paymentMethod": "cashOnDelivery",
        "tips": 20,
        // "addressId": 2,
        // "promoCode": "0",
        "items": [
          {"productId": 1, "number": 1},
          {"productId": 2, "number": 5},
        ],
      },
    );

    res.fold(
      (failure) => emit(
        CreateOrderFailed(failure.errorMessage),
      ),
      (orderDetailsModel) => emit(
        CreateOrderSuccess(orderDetailsModel.order!),
      ),
    );
  }

  void createTestOrder() async {
    final Dio dio = Dio();
    try {
      var response = await dio.post(
        'http://167.88.169.140/api/protected/orders/create',
        data: {
          "deliverMethod": "OnBranch",
          "paymentMethod": "cashOnDelivery",
          "tips": 20,
          // "addressId": 2,
          // "promoCode": "0",
          "items": [
            {"productId": 1, "number": 1},
            {"productId": 2, "number": 5},
          ],
        },
        options: Options(
          headers: {
            'token':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjE4IiwidHlwZSI6InVzZXIiLCJwdXJwb3NlIjoiYXV0aCIsImlhdCI6MTcyODMxMzY0NCwiZXhwIjoxNzI4NzQ1NjQ0fQ.Ru2kMDgnQOie3KxX_0xJlJGPiKugb8GqimPllhozTi0',
            'pass': 'GciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
          },
        ),
      );
      // Handle the success case
      print(response
          .data); // You should log this to see the full success response
    } on DioException catch (e) {
      // DioError is thrown when there's an error in the response
      if (e.response != null) {
        // The server responded with an error (like 400)
        print("Error response: ${e.response!.data}"); // Log the error message

        // You can access the error message like this
        var errorMessage = e.response!.data['error'];
        print("Error message: $errorMessage");

        // Handle the specific error in your UI or logic
        if (errorMessage == 'there is no products') {
          // Show a user-friendly error message
          print("The product you are trying to buy is no longer available.");
        }
      } else {
        // Something else happened, like no internet or a timeout
        print("Request error: ${e.message}");
      }
    }
  }
}
