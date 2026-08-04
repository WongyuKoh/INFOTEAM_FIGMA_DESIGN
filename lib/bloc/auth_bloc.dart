import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../repository/auth_repository.dart';

part 'auth_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class AuthEvent with _$AuthEvent {
  /// 앱 시작 시 한 번. 보안 저장소의 토큰을 읽어 초기 인증 상태를 결정한다.
  const factory AuthEvent.started() = AuthStarted;

  /// 로그인/회원가입 화면에서 인증에 성공했음을 알린다.
  const factory AuthEvent.loggedIn() = AuthLoggedIn;

  /// 로그아웃. 저장된 토큰을 지운다.
  const factory AuthEvent.loggedOut() = AuthLoggedOut;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
@freezed
sealed class AuthState with _$AuthState {
  /// 아직 토큰을 확인하지 못한 상태. 앱을 켠 직후 잠깐 머문다.
  const factory AuthState.unknown() = AuthUnknown;

  const factory AuthState.authenticated({
    required String nickname,
    required String email,
  }) = AuthAuthenticated;

  const factory AuthState.unauthenticated() = AuthUnauthenticated;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
/// 앱 전체의 인증 상태를 관리하는 중앙 Bloc.
///
/// main.dart 에서 라우터보다 위에 한 번만 만들어 두므로,
/// 어느 화면에서든 context.read<AuthBloc>() 으로 접근할 수 있다.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._repository) : super(const AuthState.unknown()) {
    on<AuthStarted>(_onStarted);
    on<AuthLoggedIn>((event, emit) => emit(_currentState()));
    on<AuthLoggedOut>(_onLoggedOut);
  }

  final AuthRepository _repository;

  Future<void> _onStarted(AuthStarted event, Emitter<AuthState> emit) async {
    // ① 보안 저장소 → 메모리
    await _repository.restoreSession();

    // ② access token 의 만료 시각(exp)을 확인
    if (!_repository.hasValidSession) {
      // 남아 있던 만료 토큰은 정리한다.
      if (_repository.isLoggedIn) await _repository.logout();
      emit(const AuthState.unauthenticated());
      return;
    }

    emit(_currentState());
  }

  Future<void> _onLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    await _repository.logout();
    emit(const AuthState.unauthenticated());
  }

  AuthState _currentState() {
    if (!_repository.isLoggedIn) return const AuthState.unauthenticated();
    return AuthState.authenticated(
      nickname: _repository.nickname ?? '-',
      email: _repository.email ?? '-',
    );
  }
}
