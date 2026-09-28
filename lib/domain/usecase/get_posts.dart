import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/entity/post.dart';
import 'package:figma_design/domain/repository/post_repository.dart';

/// 게시글 목록 조회. boardUuid 를 주면 해당 게시판만.
@injectable
class GetPosts {
  const GetPosts(this._repository);

  final PostRepository _repository;

  Future<List<Post>> call({String? boardUuid, String? tag}) =>
      _repository.getPosts(boardUuid: boardUuid, tag: tag);
}
