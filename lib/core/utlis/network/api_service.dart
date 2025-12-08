import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:negmt_heliopolis/core/utlis/services/checkinternet.dart';

class ApiService {
  Dio dio = Dio();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    final String? token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> removeToken() async {
    await _storage.delete(key: 'token');
    log('Token removed from secure storage');
  }

  var mainHeader = {
    'Content-Type': 'application/json',
    // 'pass': 'GciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
  };

  Future<void> setAuthorizationHeader() async {
    try {
      final token = await _storage.read(key: 'token');
      log('token api service $token');

      if (token != null) {
        mainHeader['token'] = token;
      } else {
        // If token is null, user is not authenticated
        // Handle the case accordingly, such as redirecting to login screen
        // or displaying an error message
        // Example: throw Exception('User not authenticated');
      }
    } catch (error) {
      // Handle error retrieving token from secure storage
      // Example: print('Error retrieving token: $error');
      // You can rethrow the error or handle it gracefully based on your requirements
      // rethrow;
    }
  }

  Future<Response> post({
    required String endPoints,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    // await setAuthorizationHeader();
    mainHeader.addAll(headers ?? {});

    try {
      var response = await dio.post(
        endPoints,
        data: data,
        options: Options(
          method: 'POST',
          headers: mainHeader,
          sendTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      return response;
    } catch (error) {
      debugPrint(' $error');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
    CancelToken? cancelToken,
  }) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    await setAuthorizationHeader();
    // print('Request Headers: ${dio.options.headers}');
    // print(endpoint);

    mainHeader.addAll(headers ?? {});
    try {
      var response = await dio.get(
        endpoint,
        options: Options(
          headers: mainHeader,
        ),
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        if (CancelToken.isCancel(e)) {
          print("Request canceled: $e");
        }
        rethrow;
      } else {
        rethrow;
      }
    }
  }

  Future<Response> delete({required String endPoints}) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    try {
      var response = await dio.delete(
        endPoints,
        options: Options(
          method: 'DELETE',
          headers: mainHeader,
        ),
      );
      return response;
    } catch (error) {
      debugPrint('Delete error: $error');
      rethrow;
    }
  }

  Future<Response> put({
    required String endPoints,
    required Map<String, dynamic> data,
  }) async {
    if (!await checkInternet()) {
      throw Exception('No internet connection');
    }
    try {
      await setAuthorizationHeader(); // Ensure authorization header is set

      var response = await dio.put(
        endPoints,
        data: data,
        options: Options(
          method: 'PUT',
          headers: mainHeader,
        ),
      );
      return response;
    } catch (error) {
      debugPrint('Put error: $error');
      rethrow; // Re-throw the error for handling in the caller
    }
  }
}
