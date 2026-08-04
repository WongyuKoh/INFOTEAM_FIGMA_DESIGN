import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/auth_repository.dart';

part 'login_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submitted({
    required String email,
    required String password,
  }) = LoginSubmitted;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
/// 폼 화면은 "종류"가 아니라 "진행 단계"가 바뀌는 것이므로
/// sealed union 대신 status 필드를 가진 데이터 클래스로 둔다.
enum LoginStatus { initial, submitting, success, failure }

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.initial) LoginStatus status,
    @Default('') String errorMessage,
  }) = _LoginState;

  // 직접 만든 getter 를 두려면 private 생성자가 필요하다.
  const LoginState._();

  bool get isSubmitting => status == LoginStatus.submitting;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repository) : super(const LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthRepository _repository;

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (event.email.isEmpty || event.password.isEmpty) {
      emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: '이메일과 비밀번호를 입력해주세요',
        ),
      );
      return;
    }
    // 연타로 중복 요청이 나가지 않게 막는다.
    if (state.isSubmitting) return;

    emit(state.copyWith(status: LoginStatus.submitting, errorMessage: ''));
    try {
      await _repository.login(email: event.email, password: event.password);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: LoginStatus.failure, errorMessage: '로그인 실패: $e'),
      );
    }
  }
}
