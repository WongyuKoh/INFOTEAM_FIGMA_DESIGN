import '../core/api_client.dart';

class PostApi {
  final dio = ApiClient().dio;

  // 게시물 목록 조회
  Future<Map<String, dynamic>> getPosts({String? tag, String? boardUuid}) async {
    final response = await dio.get('/posts', queryParameters: {
      if (tag != null) 'tag': tag,
      if (boardUuid != null) 'boardUuid': boardUuid,
    });
    return response.data;
  }

  // 게시물 상세 조회
  Future<Map<String, dynamic>> getPost(String uuid) async {
    final response = await dio.get('/posts/$uuid');
    return response.data;
  }

  // 게시물 생성
  Future<Map<String, dynamic>> createPost({
    required String boardUuid,
    required String title,
    required String body,
    required List<String> tags,
  }) async {
    final response = await dio.post(
      '/posts',
      queryParameters: {'boardUuid': boardUuid},
      data: {
        'title': title,
        'body': body,
        'tags': tags,
      },
    );
    return response.data;
  }

  // 게시물 수정
  Future<Map<String, dynamic>> updatePost(
    String uuid, {
    String? title,
    String? body,
    List<String>? tags,
  }) async {
    final response = await dio.patch('/posts/$uuid', data: {
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (tags != null) 'tags': tags,
    });
    return response.data;
  }

  // 게시물 삭제
  Future<void> deletePost(String uuid) async {
    await dio.delete('/posts/$uuid');
  }

  // 게시물 검색
  Future<Map<String, dynamic>> searchPosts(String keyword) async {
    final response = await dio.get('/posts/search', queryParameters: {
      'keyword': keyword,
    });
    return response.data;
  }
}
