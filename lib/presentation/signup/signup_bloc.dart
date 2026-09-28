import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:figma_design/domain/usecase/register.dart';

part 'signup_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.submitted({
    required String email,
    required String nickname,
    required String password,
  }) = SignUpSubmitted;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
enum SignUpStatus { initial, submitting, success, failure }

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(SignUpStatus.initial) SignUpStatus status,
    @Default('') String errorMessage,
  }) = _SignUpState;

  const SignUpState._();

  bool get isSubmitting => status == SignUpStatus.submitting;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
@injectable
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._register) : super(const SignUpState()) {
    on<SignUpSubmitted>(_onSubmitted);
  }

  // ── ViewModel 스타일 공개 API ── View 는 Event 를 몰라도 된다.
  void submit({
    required String email,
    required String nickname,
    required String password,
  }) => add(
    SignUpEvent.submitted(email: email, nickname: nickname, password: password),
  );

  final Register _register;

  Future<void> _onSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    if (event.email.isEmpty ||
        event.nickname.isEmpty ||
        event.password.isEmpty) {
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: t.auth.emptyFields,
        ),
      );
      return;
    }
    if (state.isSubmitting) return;

    emit(state.copyWith(status: SignUpStatus.submitting, errorMessage: ''));
    try {
      await _register(
        email: event.email,
        nickname: event.nickname,
        password: event.password,
      );
      emit(state.copyWith(status: SignUpStatus.success));
    } catch (e) {
      // 서버가 보낸 에러 본문(예: "이미 존재하는 이메일")이 있으면 그걸 보여준다.
      final detail = (e is DioException && e.response?.data != null)
          ? '${e.response?.statusCode}: ${e.response?.data}'
          : '$e';
      emit(
        state.copyWith(
          status: SignUpStatus.failure,
          errorMessage: t.auth.signupFailure(error: detail),
        ),
      );
    }
  }
}
