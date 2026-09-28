import 'package:injectable/injectable.dart';

import 'package:figma_design/data/service/post_service.dart';
import 'package:figma_design/domain/entity/post.dart';
import 'package:figma_design/domain/repository/post_repository.dart';

/// [PostRepository] 의 실제 구현. retrofit [PostService] 로 서버와 통신한다.
///
/// 화면마다 필요한 건 `List<Post>` 뿐이므로 응답 래퍼(PostListResponse)는
/// 여기서 벗겨내고 목록만 넘긴다.
@LazySingleton(as: PostRepository)
class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._service);

  final PostService _service;

  @override
  Future<List<Post>> getPosts({String? boardUuid, String? tag}) async {
    final response = await _service.getPosts(boardUuid: boardUuid, tag: tag);
    return response.list;
  }

  @override
  Future<List<Post>> searchPosts(String keyword) async {
    final response = await _service.searchPosts(keyword);
    return response.list;
  }

  @override
  Future<void> createPost({
    required String boardUuid,
    required String title,
    required String body,
    required List<String> tags,
    required List<String> images,
  }) {
    return _service.createPost(boardUuid, {
      'title': title,
      'body': body,
      'tags': tags,
      'images': images,
    });
  }
}
