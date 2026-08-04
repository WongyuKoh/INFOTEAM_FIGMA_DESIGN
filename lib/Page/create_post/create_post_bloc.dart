import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'create_post_bloc.freezed.dart';

// ------------------------------------------------------------
// Event
// ------------------------------------------------------------
@freezed
sealed class CreatePostEvent with _$CreatePostEvent {
  /// 갤러리에서 사진을 고른다.
  const factory CreatePostEvent.photosRequested() = CreatePostPhotosRequested;

  /// 고른 사진 중 하나를 뺀다.
  const factory CreatePostEvent.photoRemoved(int index) =
      CreatePostPhotoRemoved;

  /// 에러 메시지를 한 번 보여준 뒤 지운다.
  const factory CreatePostEvent.errorShown() = CreatePostErrorShown;
}

// ------------------------------------------------------------
// State
// ------------------------------------------------------------
/// 제목/본문은 TextEditingController 가 들고 있는 순수 UI 상태라 Bloc 에 두지 않는다.
/// 여기서 관리하는 건 "고른 사진 목록"처럼 위젯 하나에 담기지 않는 상태다.
@freezed
abstract class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    /// base64 로 인코딩된 사진들. 서버가 이미지를 base64 로 주고받는다.
    @Default(<String>[]) List<String> images,
    @Default('') String errorMessage,
  }) = _CreatePostState;
}

// ------------------------------------------------------------
// Bloc
// ------------------------------------------------------------
class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc({ImagePicker? picker})
    : _picker = picker ?? ImagePicker(),
      super(const CreatePostState()) {
    on<CreatePostPhotosRequested>(_onPhotosRequested);
    on<CreatePostPhotoRemoved>(_onPhotoRemoved);
    on<CreatePostErrorShown>(
      (event, emit) => emit(state.copyWith(errorMessage: '')),
    );
  }

  final ImagePicker _picker;

  Future<void> _onPhotosRequested(
    CreatePostPhotosRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    try {
      // 원본 그대로 base64 로 보내면 본문이 너무 커져서 크기/품질을 줄인다.
      final picked = await _picker.pickMultiImage(
        maxWidth: 1440,
        maxHeight: 1440,
        imageQuality: 85,
      );
      if (picked.isEmpty) return;

      final encoded = <String>[];
      for (final file in picked) {
        encoded.add(base64Encode(await file.readAsBytes()));
      }

      // ⚠️ state.images.addAll(...) 로 기존 리스트를 고치면 같은 인스턴스라
      //    == 비교에 걸려 emit 이 무시된다. 반드시 새 리스트를 만든다.
      emit(state.copyWith(images: [...state.images, ...encoded]));
    } catch (e) {
      emit(state.copyWith(errorMessage: '사진을 불러오지 못했습니다: $e'));
    }
  }

  void _onPhotoRemoved(
    CreatePostPhotoRemoved event,
    Emitter<CreatePostState> emit,
  ) {
    if (event.index < 0 || event.index >= state.images.length) return;
    final next = [...state.images]..removeAt(event.index);
    emit(state.copyWith(images: next));
  }
}
