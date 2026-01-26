import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/network/app_urls.dart';

class CheckMaintenance extends GetxService {
  final ApiService api;
  CheckMaintenance({required this.api});

  String? massege;
  Future<MaintenanceModel> checkMaintenance() async {
    try {
      final cancelToken = CancelToken();
      Timer(const Duration(seconds: 10), () {
        if (!cancelToken.isCancelled) {
          cancelToken.cancel();
        }
      });
      final response = await api.get(
        endpoint: AppUrls.checkMaintenanceUrl(),
        cancelToken: cancelToken,
      );
      MaintenanceModel maintenanceModel = MaintenanceModel.fromJson(response);
      massege = maintenanceModel.massege;
      return maintenanceModel;
    } catch (e) {
      return MaintenanceModel(avilbal: true, massege: '');
    }
  }
}

class MaintenanceModel {
  MaintenanceModel({required this.avilbal, required this.massege});

  final bool? avilbal;
  final String? massege;

  factory MaintenanceModel.fromJson(Map<String, dynamic> json) {
    return MaintenanceModel(avilbal: json["avilbal"], massege: json["massege"]);
  }
}
