import '../api/board/board_models.dart';
import '../api/board/board_service.dart';
import '../api/core/api_client.dart';

/// 게시판 관련 데이터 접근.
class BoardRepository {
  BoardRepository({BoardService? service})
    : _service = service ?? BoardService(ApiClient().dio);

  final BoardService _service;

  Future<List<Board>> getBoards() async {
    final response = await _service.getBoards();
    return response.list;
  }

  Future<void> createBoard(String title) {
    return _service.createBoard({'title': title});
  }

  Future<void> deleteBoard(String uuid) => _service.deleteBoard(uuid);
}
