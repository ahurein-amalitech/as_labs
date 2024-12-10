import 'package:as_labs/utils/as_loaders.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class ApiService {
  final Dio _dio;
  final storage = GetStorage();

  // baseUrl: baseUrl ?? 'http://10.0.2.2:8080/api/v1',

  ApiService({String? baseUrl})
      : _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl ?? 'http://10.0.2.2:8080/api/v1',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  ){
    final token = storage.read("token");
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// POST request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      print("++++++++++++++++++++++++++++");
      print(storage.read('token'));
      return await _dio.post(path, data: data);
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  /// Error handling
  void _handleError(Object error) {
    if (error is DioException) {
      if (error.response != null) {
        AsLoaders.errorSnackBar(title: error.response?.data["message"]);
      } else {
        AsLoaders.errorSnackBar(title: error.message, message: "Kindly try again");
      }
    }
  }
}
