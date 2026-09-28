import 'package:dio/dio.dart';

import 'api_config.dart';
import 'token_storage.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio;

  /// 토큰 재발급 요청에만 쓰는 별도 Dio.
  /// 아래 인터셉터가 붙은 [dio] 로 /auth/refresh 를 부르면
  /// 그 요청이 또 401 을 받았을 때 무한 재귀에 빠지므로 분리한다.
  late final Dio _refreshDio;

  /// 동시에 여러 요청이 401 을 받아도 재발급은 한 번만 나가도록 공유하는 Future.
  Future<bool>? _refreshing;

  static const _retriedKey = '__retried';

  ApiClient._internal() {
    final options = BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    );

    dio = Dio(options);
    _refreshDio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        // ── 요청: 저장된 access token 을 헤더에 자동 첨부 ──────────────
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

        // ── 에러: 401 이면 refresh token 으로 재발급 후 원래 요청 재시도 ──
        onError: (error, handler) async {
          print(
            '[API] 에러: ${error.response?.statusCode} ${error.response?.data ?? error.message}',
          );

          if (!_shouldTryRefresh(error)) {
            return handler.next(error);
          }

          final refreshed = await _refreshTokens();
          if (!refreshed) {
            // 재발급 실패 = 세션 만료. 토큰을 지워 로그아웃 상태로 만든다.
            await TokenStorage.clear();
            return handler.next(error);
          }

          try {
            final request = error.requestOptions;
            // 새 토큰으로 갈아끼우고, 재시도임을 표시해 무한 루프를 막는다.
            request.headers['Authorization'] =
                'Bearer ${TokenStorage.accessToken}';
            request.extra[_retriedKey] = true;
            print('[API] 토큰 재발급 성공 → 재시도: ${request.path}');
            final response = await dio.fetch(request);
            return handler.resolve(response);
          } catch (_) {
            return handler.next(error);
          }
        },
      ),
    );
  }

  bool _shouldTryRefresh(DioException error) {
    if (error.response?.statusCode != 401) return false;
    // 이미 한 번 재시도한 요청이면 더 시도하지 않는다.
    if (error.requestOptions.extra[_retriedKey] == true) return false;
    // 재발급 요청 자체가 401 이면 재발급으로 풀 수 없다.
    if (error.requestOptions.path.contains('/auth/refresh')) return false;
    return TokenStorage.refreshToken != null;
  }

  /// refresh token 으로 새 토큰을 받아 저장한다. 성공하면 true.
  ///
  /// 진행 중인 재발급이 있으면 그 Future 를 함께 기다린다.
  Future<bool> _refreshTokens() {
    return _refreshing ??= _doRefresh().whenComplete(() => _refreshing = null);
  }

  Future<bool> _doRefresh() async {
    final token = TokenStorage.refreshToken;
    if (token == null) return false;
    try {
      final response = await _refreshDio.post(
        '/auth/refresh',
        data: {'refreshToken': token},
      );
      final data = response.data;
      final access = data['accessToken'] ?? data['access_token'];
      final refresh = data['refreshToken'] ?? data['refresh_token'];
      if (access == null) return false;

      TokenStorage.accessToken = access.toString();
      // 서버가 refresh token 을 새로 주지 않으면 기존 것을 유지한다.
      if (refresh != null) TokenStorage.refreshToken = refresh.toString();
      await TokenStorage.persist();
      return true;
    } catch (e) {
      print('[API] 토큰 재발급 실패: $e');
      return false;
    }
  }
}
