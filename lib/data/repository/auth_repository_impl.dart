import 'package:injectable/injectable.dart';

import 'package:figma_design/data/core/token_storage.dart';
import 'package:figma_design/data/service/auth_api.dart';
import 'package:figma_design/data/service/auth_service.dart';
import 'package:figma_design/domain/entity/auth_status.dart';
import 'package:figma_design/domain/repository/auth_repository.dart';

/// [AuthRepository] 의 실제 구현.
///
/// 토큰/사용자 정보는 [TokenStorage](메모리 + 보안 저장소)에 보관한다.
/// UseCase 는 이 구현이 무엇을 쓰는지 모르고 [AuthRepository] 계약만 안다.
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._service, this._api);

  final AuthService _service;
  final AuthApi _api;

  @override
  Future<void> restoreSession() => TokenStorage.load();

  @override
  AuthStatus currentStatus() => AuthStatus(
    isLoggedIn: TokenStorage.isLoggedIn,
    hasValidSession: TokenStorage.isAccessTokenValid,
    nickname: TokenStorage.nickname,
    email: TokenStorage.email,
  );

  @override
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

  @override
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

  @override
  Future<void> logout() => TokenStorage.clear();
}
