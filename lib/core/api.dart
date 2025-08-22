import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Api {
  final Dio _dio = Dio();

  static const baseUrl = "https://api.zanaduhealth.com";

  // static const baseUrl = "http://10.5.49.138:5000";

  final Map<String, dynamic> headers = {
    "Content-type": "application/json"
  };

 
  Api() {
    _dio.options.baseUrl = "$baseUrl/api";
    _dio.options.headers = headers;
    _dio.interceptors.add( PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true
    ) );
    _dio.interceptors.add( RetryInterceptor(
      dio: _dio,
      retries: 3,
      retryDelays: [
        const Duration(seconds: 1),
        const Duration(seconds: 2),
        const Duration(seconds: 3)
      ]
    ) );
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool status;
  Object? data;
  String message;

  ApiResponse({
    required this.status,
    this.data,
    required this.message
  });

  /// Constructor to build the ApiResponse from the Response given by Dio
  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(
      status: response.data["status"],
      data: response.data["data"],
      message: response.data["message"] ?? ""
    );
  }
}