import 'package:dio/dio.dart';

String dioExceptionHandler(DioException e) {
  switch (e.type) {
    case .connectionTimeout:
      return "Connection timed out. Check your internet speed.";
    case .receiveTimeout:
      return "Server is taking too long to respond. Try again later.";
    case .connectionError:
      return "Unable to connect to the server. Is your data turned on?";
    case .sendTimeout:
      return "Request timeout. Please try again.";
    case .badCertificate:
      return "Certificate error. Please try again later.";
    case .badResponse:
      final data = e.response?.data;
      if (data is Map) {
        final message = data['message'];
        if (message is Map) {
          final firstErrorList = message.values.first;
          if (firstErrorList is List && firstErrorList.isNotEmpty) {
            return firstErrorList.first.toString();
          }
          return "Validation failed.";
        }
        if (message is String) {
          return message;
        }
        return data['error']?.toString() ??
            "Server error: ${e.response?.statusCode}";
      }
      return "Server returned an invalid response.";

    case .cancel:
      return "Request was cancelled.";
    case .unknown:
      return "Something went wrong. Please try again.";
  }
}
