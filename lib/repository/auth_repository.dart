import '../api/auth/auth_api.dart';
import '../api/auth/auth_service.dart';
import '../api/core/api_client.dart';
import '../api/core/token_storage.dart';

/// 인증 관련 데이터 접근을 한 곳으로 모은다.
///
/// Bloc 은 Dio/Retrofit/TokenStorage 를 직접 알 필요 없이 이 클래스만 쓴다.
/// 테스트에서는 이 클래스를 상속한 가짜 구현으로 갈아끼우면 된다.
class AuthRepository {
  AuthRepository({AuthService? service, AuthApi? api})
    : _service = service ?? AuthService(ApiClient().dio),
      _api = api ?? AuthApi();

  final AuthService _service;
  final AuthApi _api;

  bool get isLoggedIn => TokenStorage.isLoggedIn;
  String? get nickname => TokenStorage.nickname;
  String? get email => TokenStorage.email;

  /// 앱 시작 시 호출. 보안 저장소에 남아 있는 토큰을 메모리로 올린다.
  Future<void> restoreSession() => TokenStorage.load();

  /// 저장된 access token 이 있고, 아직 만료되지 않았는지.
  bool get hasValidSession => TokenStorage.isAccessTokenValid;

  /// 로그인 후 토큰과 사용자 정보를 저장한다.
  Future<void> login({required String email, required String password}) async {
    final result = await _service.login({'email': email, 'password': password});

    final accessToken = result['accessToken'] ?? result['access_token'];
    final refreshToken = result['refreshToken'] ?? result['refresh_token'];
    TokenStorage.accessToken = accessToken?.toString();
    TokenStorage.refreshToken = refreshToken?.toString();

    // 다른 계정으로 로그인하면 이전 계정의 닉네임이 남지 않도록 정리한다.
    if (TokenStorage.email != email) TokenStorage.nickname = null;
    TokenStorage.email = email;

    // 서버에 내 정보 엔드포인트가 없어 응답/JWT/게시글에서 닉네임을 찾아온다.
    await _api.loadNickname(loginResponse: result);

    // 앱을 껐다 켜도 유지되도록 보안 저장소에 기록한다.
    await TokenStorage.persist();
  }

  Future<void> register({
    required String email,
    required String nickname,
    required String password,
  }) async {
    await _service.register({
      'email': email,
      'nickname': nickname,
      'password': password,
    });
    // 회원가입 시 입력한 정보는 미리 저장해 두어 이후 로그인 시 바로 쓸 수 있게 한다.
    TokenStorage.email = email;
    TokenStorage.nickname = nickname;
    await TokenStorage.persist();
  }

  /// 메모리와 보안 저장소를 모두 비운다.
  Future<void> logout() => TokenStorage.clear();
}
