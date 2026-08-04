import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../repository/post_repository.dart';
import '../../repository/tag_repository.dart';

part 'create_tag_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class CreateTagEvent with _$CreateTagEvent {
  /// 태그 입력창의 글자가 바뀜. (추가 버튼 활성화 여부에 쓰인다)
  const factory CreateTagEvent.inputChanged(String value) =
      CreateTagInputChanged;

  /// 입력한 태그를 목록에 담는다.
  const factory CreateTagEvent.tagAdded() = CreateTagAdded;

  /// 태그 등록 + 게시글 등록.
  const factory CreateTagEvent.submitted() = CreateTagSubmitted;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
enum CreateTagStatus { editing, submitting, success, failure }

@freezed
abstract class CreateTagState with _$CreateTagState {
  const factory CreateTagState({
    @Default('') String input,
    @Default(<String>[]) List<String> tags,
    @Default(CreateTagStatus.editing) CreateTagStatus status,
    @Default('') String errorMessage,
  }) = _CreateTagState;

  const CreateTagState._();

  bool get isSubmitting => status == CreateTagStatus.submitting;
  bool get isInputEmpty => input.trim().isEmpty;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
/// 태그를 붙이고 최종적으로 게시글을 등록한다.
///
/// 글 내용(제목/본문/사진)은 앞 화면에서 라우트 파라미터로 넘어오므로
/// 생성자로 받아 그대로 들고 있는다.
class CreateTagBloc extends Bloc<CreateTagEvent, CreateTagState> {
  CreateTagBloc(
    this._postRepository,
    this._tagRepository, {
    required this.boardUuid,
    required this.title,
    required this.body,
    required this.images,
  }) : super(const CreateTagState()) {
    on<CreateTagInputChanged>(
      (event, emit) => emit(state.copyWith(input: event.value)),
    );
    on<CreateTagAdded>(_onTagAdded);
    on<CreateTagSubmitted>(_onSubmitted);
  }

  final PostRepository _postRepository;
  final TagRepository _tagRepository;

  final String boardUuid;
  final String title;
  final String body;
  final List<String> images;

  void _onTagAdded(CreateTagAdded event, Emitter<CreateTagState> emit) {
    final tag = state.input.trim();
    if (tag.isEmpty || state.tags.contains(tag)) {
      emit(state.copyWith(input: ''));
      return;
    }
    // 기존 리스트를 수정하지 않고 새 리스트를 만든다.
    emit(state.copyWith(tags: [...state.tags, tag], input: ''));
  }

  Future<void> _onSubmitted(
    CreateTagSubmitted event,
    Emitter<CreateTagState> emit,
  ) async {
    // 완료를 연타하면 글이 여러 건 생성되므로 전송 중에는 무시한다.
    if (state.isSubmitting) return;

    emit(state.copyWith(status: CreateTagStatus.submitting, errorMessage: ''));
    try {
      // 서버에 등록되지 않은 태그는 글 생성 시 무시되므로 먼저 등록한다.
      for (final tag in state.tags) {
        await _tagRepository.createTagIgnoringDuplicate(tag);
      }
      await _postRepository.createPost(
        boardUuid: boardUuid,
        title: title,
        body: body,
        tags: state.tags,
        images: images,
      );
      emit(state.copyWith(status: CreateTagStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: CreateTagStatus.failure,
          errorMessage: '게시글 등록 실패: $e',
        ),
      );
    }
  }
}
