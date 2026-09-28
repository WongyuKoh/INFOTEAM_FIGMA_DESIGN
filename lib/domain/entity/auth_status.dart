/// 현재 인증 상태 스냅샷. (Data 계층의 토큰 저장소를 Domain 언어로 옮긴 것)
class AuthStatus {
  const AuthStatus({
    required this.isLoggedIn,
    required this.hasValidSession,
    this.nickname,
    this.email,
  });

  /// 토큰이 저장돼 있는지.
  final bool isLoggedIn;

  /// 저장된 access token 이 아직 만료되지 않았는지.
  final bool hasValidSession;

  final String? nickname;
  final String? email;
}
