import '../api/core/api_client.dart';
import '../api/post/post_models.dart';
import '../api/post/post_service.dart';

/// 게시글 관련 데이터 접근.
///
/// 화면마다 필요한 건 `List<Post>` 뿐이므로 응답 래퍼(PostListResponse)는
/// 여기서 벗겨내고 목록만 넘긴다.
class PostRepository {
  PostRepository({PostService? service})
    : _service = service ?? PostService(ApiClient().dio);

  final PostService _service;

  /// [boardUuid] 를 주면 해당 게시판의 글만, 없으면 전체 글을 가져온다.
  Future<List<Post>> getPosts({String? boardUuid, String? tag}) async {
    final response = await _service.getPosts(boardUuid: boardUuid, tag: tag);
    return response.list;
  }

  Future<List<Post>> searchPosts(String keyword) async {
    final response = await _service.searchPosts(keyword);
    return response.list;
  }

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
