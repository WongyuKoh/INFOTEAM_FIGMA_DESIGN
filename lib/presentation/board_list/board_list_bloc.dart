import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:figma_design/domain/entity/board.dart';
import 'package:figma_design/domain/usecase/get_boards.dart';

part 'board_list_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class BoardListEvent with _$BoardListEvent {
  /// 화면 진입 시 최초 로드.
  const factory BoardListEvent.started() = BoardListStarted;

  /// 당겨서 새로고침 / 게시판 생성 후 다시 로드.
  const factory BoardListEvent.refreshed() = BoardListRefreshed;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
@freezed
sealed class BoardListState with _$BoardListState {
  /// 아무것도 하기 전. 화면에 아무것도 그리지 않는다.
  /// started 이벤트가 들어오면 즉시 loading 으로 바뀐다.
  const factory BoardListState.init() = BoardListInit;

  const factory BoardListState.loading() = BoardListLoading;
  const factory BoardListState.loaded(List<Board> boards) = BoardListLoaded;
  const factory BoardListState.failure(String message) = BoardListFailure;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
/// 게시판 목록.
///
/// ⭐ 한 Bloc 클래스를 여러 화면이 재사용하는 예:
///   - ViewGridPage       : 게시판 목록 화면 본체
///   - HomePage 의 선택 시트 : 글을 쓸 게시판을 고르는 바텀시트
/// 클래스는 하나지만 화면마다 인스턴스는 따로 생긴다.
@injectable
class BoardListBloc extends Bloc<BoardListEvent, BoardListState> {
  BoardListBloc(this._getBoards) : super(const BoardListState.init()) {
    on<BoardListStarted>(_onLoad);
    on<BoardListRefreshed>(_onLoad);
  }

  // ── ViewModel 스타일 공개 API ── View 는 Event 를 몰라도 된다.
  void load() => add(const BoardListEvent.started());
  void refresh() => add(const BoardListEvent.refreshed());

  final GetBoards _getBoards;

  Future<void> _onLoad(
    BoardListEvent event,
    Emitter<BoardListState> emit,
  ) async {
    emit(const BoardListState.loading());
    try {
      final boards = await _getBoards();
      emit(BoardListState.loaded(boards));
    } catch (e) {
      emit(BoardListState.failure(t.board.loadFailure(error: e)));
    }
  }
}
