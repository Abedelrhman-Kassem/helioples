import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final baseUrl = 'http://167.88.169.140/';

  Dio dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var mainHeader = {
    'Content-Type': 'application/json',
    'pass': 'GciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',

  };

  Future<void> setAuthorizationHeader() async {
    try {
      // Retrieve token from secure storage
      final token = await _storage.read(key: 'token');

      // print('tokennnn $token');
      // Check if token exists
      if (token != null) {
        // Add token to the headers of the Dio instance
        dio.options.headers['Authorization'] = 'Bearer $token';
        mainHeader['token'] = '$token';
         print(mainHeader);
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
    mainHeader.addAll(headers ?? {});

    try {
      var response = await dio.post(
        '$baseUrl$endPoints',
        data: data,
        options: Options(
          method: 'POST',
          headers: mainHeader,
        ),
      );
      return response;
    } catch (error) {
      debugPrint(' $error');
      rethrow; // Re-throw the error for handling in the caller
    }
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
  }) async {
    // await setAuthorizationHeader();
    // print('Request Headers: ${dio.options.headers}');
    // print(endpoint);

    mainHeader.addAll(headers ?? {});
    try {
      var response = await dio.get(
        '$baseUrl$endpoint',
        options: Options(
          headers: mainHeader,
        ),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete({required String endPoints}) async {
    try {
      var response = await dio.delete(
        '$baseUrl$endPoints',
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
    try {
      await setAuthorizationHeader(); // Ensure authorization header is set

      var response = await dio.put(
        '$baseUrl$endPoints',
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
