import 'package:dio/dio.dart';
import 'api_config.dart';
import 'token_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = TokenStorage.accessToken;
          print(
            '[API] 요청: ${options.method} ${options.path} | 토큰: ${token != null ? "있음(${token.substring(0, token.length > 10 ? 10 : token.length)}...)" : "없음(null)"}',
          );
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            '[API] 응답: ${response.statusCode} ${response.requestOptions.path}',
          );
          handler.next(response);
        },
        onError: (error, handler) {
          print(
            '[API] 에러: ${error.response?.statusCode} ${error.response?.data ?? error.message}',
          );
          handler.next(error);
        },
      ),
    );
  }
}
