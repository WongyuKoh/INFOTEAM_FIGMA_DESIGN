import 'package:figma_design/domain/entity/auth_status.dart';

/// 인증 데이터 접근 "계약".
abstract interface class AuthRepository {
  /// 앱 시작 시: 보안 저장소의 토큰을 메모리로 올린다.
  Future<void> restoreSession();

  /// 현재 인증 상태 스냅샷.
  AuthStatus currentStatus();

  Future<void> login({required String email, required String password});

  Future<void> register({
    required String email,
    required String nickname,
    required String password,
  });

  Future<void> logout();
}
