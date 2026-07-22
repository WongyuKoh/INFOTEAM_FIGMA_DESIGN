import '../core/api_client.dart';

class BoardApi {
  final dio = ApiClient().dio;

  // 게시판 목록 조회
  Future<Map<String, dynamic>> getBoards() async {
    final response = await dio.get('/boards');
    return response.data;
  }

  // 게시판 생성
  Future<Map<String, dynamic>> createBoard(String title) async {
    final response = await dio.post('/boards', data: {
      'title': title,
    });
    return response.data;
  }

  // 게시판 삭제
  Future<void> deleteBoard(String uuid) async {
    await dio.delete('/boards/$uuid');
  }
}
