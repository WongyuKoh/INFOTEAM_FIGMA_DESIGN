// ============================================================
// 🏋️ 연습 과제 — 아래 [작성 1] ~ [작성 4] 칸을 채우세요
// ============================================================
// 목표: "특정 게시판의 게시글 목록"을 담당하는 Bloc 만들기
//
// 다 쓰면:  dart run build_runner build
//          → board_post_bloc.freezed.dart 가 생성됩니다
//
// 정답지: lib/Page/board_list/board_list_bloc.dart (같은 패턴)
// ============================================================

// ┌──────────────────────────────────────────────────────────┐
// │ [작성 1] import + part                                    │
// └──────────────────────────────────────────────────────────┘
// 필요한 것 4개:
//   package:flutter_bloc/flutter_bloc.dart          → Bloc, Emitter
//   package:freezed_annotation/freezed_annotation.dart → @freezed
//   ../../api/post/post_models.dart                 → Post 모델
//   ../../repository/post_repository.dart           → PostRepository
//
// 그리고 마지막에 생성 파일 연결 (import 아니고 part!):
//   part 'board_post_bloc.freezed.dart';

// ↓↓↓ 여기에 작성 ↓↓↓
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../api/post/post_models.dart';
import '../../repository/post_repository.dart';

part 'board_post_bloc.freezed.dart';
// ↑↑↑ 여기까지 ↑↑↑

// ┌──────────────────────────────────────────────────────────┐
// │ [작성 2] Event — "무슨 일이 일어났는가"                      │
// └──────────────────────────────────────────────────────────┘
// 뼈대:
//   @freezed
//   sealed class BoardPostEvent with _$BoardPostEvent {
//     const factory BoardPostEvent.started() = BoardPostStarted;
//     //             └─ 부를 이름 ─┘           └─ 실제 클래스 ─┘
//     ... refreshed 도 같은 형태로 하나 더
//   }
//
// 필요한 이벤트 2개:
//   started()    — 화면에 처음 들어왔을 때
//   refreshed()  — 새로고침 / 글쓰기 후 돌아왔을 때
//
// 💡 오른쪽 클래스 이름은 아래 on<> 에서 쓰이니 잘 지을 것.

// ↓↓↓ 여기에 작성 ↓↓↓
@freezed
sealed class BoardPostEvent with _$BoardPostEvent {
  const factory BoardPostEvent.started() = BoardPostStarted;
  const factory BoardPostEvent.refreshed() = BoardPostRefreshed;
}

// ↑↑↑ 여기까지 ↑↑↑

// ┌──────────────────────────────────────────────────────────┐
// │ [작성 3] State — "지금 화면은 어떤 모습인가"                 │
// └──────────────────────────────────────────────────────────┘
// Event 와 똑같이 @freezed + sealed class 로.
//
// 필요한 상태 3개:
//   loading()                  — 필드 없음 (타입 자체가 "로딩 중"이라는 정보)
//   loaded(List<Post> posts)   — 성공. 목록을 실어 나름
//   failure(String message)    — 실패. 에러 메시지를 실어 나름
//
// 💡 bool isLoading + List posts + String? error 로 안 하는 이유:
//    그러면 "로딩 중인데 에러도 있는" 불가능한 조합이 만들어진다.
//    sealed 는 그런 상태를 애초에 표현할 수 없게 막아준다.

// ↓↓↓ 여기에 작성 ↓↓↓
@freezed
sealed class BoardPostState with _$BoardPostState {
  /// 아무것도 하기 전. 화면에 아무것도 그리지 않는다.
  /// started 이벤트가 들어오면 즉시 loading 으로 바뀐다.
  const factory BoardPostState.init() = BoardPostInit;

  const factory BoardPostState.loading() = BoardPostLoading;
  const factory BoardPostState.loaded(List<Post> posts) = BoardPostLoaded;
  const factory BoardPostState.failure(String message) = BoardPostFailure;
}

// ↑↑↑ 여기까지 ↑↑↑

// ┌──────────────────────────────────────────────────────────┐
// │ [작성 4] Bloc — Event 를 State 로 바꾸는 규칙               │
// └──────────────────────────────────────────────────────────┘
// 뼈대:
//   class BoardPostBloc extends Bloc<BoardPostEvent, BoardPostState> {
//     BoardPostBloc(???) : super(???) {
//       on<???>(_onLoad);
//       on<???>(_onLoad);
//     }
//
//     final PostRepository _repository;
//     final String boardUuid;
//
//     Future<void> _onLoad(BoardPostEvent event, Emitter<BoardPostState> emit) async {
//       ...
//     }
//   }
//
// (a) 생성자가 받아야 할 것 2개
//     · PostRepository — API 호출용 도구. 밖에서 주입받는다
//                        (직접 new 하면 테스트에서 가짜로 못 바꾼다)
//     · boardUuid      — 어느 게시판인지. 화면마다 달라서 생성자로 받는다
//
// (b) super(...) 에 넣을 초기 상태
//     화면 들어오자마자 로딩을 시작하므로 loading 으로 시작하면 된다
//
// (c) on<> 등록
//     ⚠️ on<> 안에는 "실제 클래스 이름"을 쓴다 (BoardPostEvent.started 아님)
//     💡 두 이벤트가 하는 일이 같으니 핸들러를 공유해도 된다
//
// (d) _onLoad 안의 순서
//     ① emit(loading)      ← 새로고침 때는 loaded 상태니까 되돌려야 함
//     ② try { final posts = await _repository.getPosts(boardUuid: boardUuid); }
//        ⚠️ boardUuid 를 꼭 넘길 것. 안 넘기면 전체 글이 온다
//     ③ emit(loaded(posts))
//     ④ catch (e) → emit(failure('게시글을 불러오지 못했습니다: $e'))
//
// 💡 emit 은 void 를 반환하므로 await 를 붙이지 않는다.
//    await 는 _repository 호출에만 붙는다.

// ↓↓↓ 여기에 작성 ↓↓↓
class BoardPostBloc extends Bloc<BoardPostEvent, BoardPostState> {
  BoardPostBloc(this._repository, {required this.boardUuid})
    : super(const BoardPostState.init()) {
    on<BoardPostStarted>(_onLoad);
    on<BoardPostRefreshed>(_onLoad);
  }

  final PostRepository _repository;
  final String boardUuid;

  Future<void> _onLoad(
    BoardPostEvent event,
    Emitter<BoardPostState> emit,
  ) async {
    emit(const BoardPostState.loading());
    try {
      final posts = await _repository.getPosts(boardUuid: boardUuid);
      emit(BoardPostState.loaded(posts));
    } catch (e) {
      emit(BoardPostState.failure('게시글을 불러오지 못했습니다 : $e'));
    }
  }
}

// ↑↑↑ 여기까지 ↑↑↑
