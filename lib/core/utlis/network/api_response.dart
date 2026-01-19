class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({required this.success, required this.message, this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T? Function(Object? raw) fromJsonT,
  ) {
    final rawSuccess = json['success'];
    final bool successValue = rawSuccess is bool
        ? rawSuccess
        : (rawSuccess?.toString().toLowerCase() == 'true');

    final messageValue = json['message']?.toString() ?? '';

    final rawData = json.containsKey('data') ? json['data'] : null;
    final parsedData = rawData == null ? null : fromJsonT(rawData);

    return ApiResponse<T>(
      success: successValue,
      message: messageValue,
      data: parsedData,
    );
  }

  ApiResponse<T> copyWith({bool? success, String? message, T? data}) {
    return ApiResponse<T>(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
