import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:figma_design/domain/usecase/create_board.dart';

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
@injectable
class NewboardBloc extends Bloc<NewboardEvent, NewboardState> {
  NewboardBloc(this._createBoard) : super(const NewboardState()) {
    on<NewboardSubmitted>(_onSubmitted);
  }

  // ── ViewModel 스타일 공개 API ── View 는 Event 를 몰라도 된다.
  void submit(String title) => add(NewboardEvent.submitted(title));

  final CreateBoard _createBoard;

  Future<void> _onSubmitted(
    NewboardSubmitted event,
    Emitter<NewboardState> emit,
  ) async {
    final title = event.title.trim();
    if (title.isEmpty) {
      emit(
        state.copyWith(
          status: NewboardStatus.failure,
          errorMessage: t.board.nameRequired,
        ),
      );
      return;
    }
    if (state.isSubmitting) return;

    emit(state.copyWith(status: NewboardStatus.submitting, errorMessage: ''));
    try {
      await _createBoard(title);
      emit(state.copyWith(status: NewboardStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: NewboardStatus.failure,
          errorMessage: t.board.createFailure(error: e),
        ),
      );
    }
  }
}
