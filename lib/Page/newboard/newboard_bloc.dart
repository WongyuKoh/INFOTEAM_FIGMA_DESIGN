import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/board_repository.dart';

part 'newboard_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class NewboardEvent with _$NewboardEvent {
  const factory NewboardEvent.submitted(String title) = NewboardSubmitted;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
enum NewboardStatus { initial, submitting, success, failure }

@freezed
abstract class NewboardState with _$NewboardState {
  const factory NewboardState({
    @Default(NewboardStatus.initial) NewboardStatus status,
    @Default('') String errorMessage,
  }) = _NewboardState;

  const NewboardState._();

  bool get isSubmitting => status == NewboardStatus.submitting;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
class NewboardBloc extends Bloc<NewboardEvent, NewboardState> {
  NewboardBloc(this._repository) : super(const NewboardState()) {
    on<NewboardSubmitted>(_onSubmitted);
  }

  final BoardRepository _repository;

  Future<void> _onSubmitted(
    NewboardSubmitted event,
    Emitter<NewboardState> emit,
  ) async {
    final title = event.title.trim();
    if (title.isEmpty) {
      emit(
        state.copyWith(
          status: NewboardStatus.failure,
          errorMessage: '게시판 이름을 입력해주세요',
        ),
      );
      return;
    }
    if (state.isSubmitting) return;

    emit(state.copyWith(status: NewboardStatus.submitting, errorMessage: ''));
    try {
      await _repository.createBoard(title);
      emit(state.copyWith(status: NewboardStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: NewboardStatus.failure,
          errorMessage: '게시판 생성 실패: $e',
        ),
      );
    }
  }
}
