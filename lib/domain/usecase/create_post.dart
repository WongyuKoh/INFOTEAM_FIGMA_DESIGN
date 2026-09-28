import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/post_repository.dart';

/// 게시글 작성.
@injectable
class CreatePost {
  const CreatePost(this._repository);

  final PostRepository _repository;

  Future<void> call({
    required String boardUuid,
    required String title,
    required String body,
    required List<String> tags,
    required List<String> images,
  }) => _repository.createPost(
    boardUuid: boardUuid,
    title: title,
    body: body,
    tags: tags,
    images: images,
  );
}
