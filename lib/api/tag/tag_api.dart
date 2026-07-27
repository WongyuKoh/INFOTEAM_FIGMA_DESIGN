import '../core/api_client.dart';

class TagApi {
  final dio = ApiClient().dio;

  // 태그 목록 조회
  Future<Map<String, dynamic>> getTags() async {
    final response = await dio.get('/tag');
    return response.data;
  }

  // 태그 생성
  Future<Map<String, dynamic>> createTag(String key) async {
    final response = await dio.post('/tag', data: {
      'key': key,
    });
    return response.data;
  }

  // 태그 검색
  Future<Map<String, dynamic>> searchTags(String keyword) async {
    final response = await dio.get('/tag/search', queryParameters: {
      'keyword': keyword,
    });
    return response.data;
  }
}
