import 'package:figma_design/domain/entity/post.dart';

/// 게시글 데이터 접근 "계약". 구현(Data 계층)이 무엇을 쓰는지 Domain 은 모른다.
abstract interface class PostRepository {
  Future<List<Post>> getPosts({String? boardUuid, String? tag});

  Future<List<Post>> searchPosts(String keyword);

  Future<void> createPost({
    required String boardUuid,
    required String title,
    required String body,
    required List<String> tags,
    required List<String> images,
  });
}
