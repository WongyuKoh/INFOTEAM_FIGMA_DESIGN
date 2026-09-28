import 'package:injectable/injectable.dart';

import 'package:figma_design/data/service/board_service.dart';
import 'package:figma_design/domain/entity/board.dart';
import 'package:figma_design/domain/repository/board_repository.dart';

/// [BoardRepository] 의 실제 구현.
@LazySingleton(as: BoardRepository)
class BoardRepositoryImpl implements BoardRepository {
  BoardRepositoryImpl(this._service);

  final BoardService _service;

  @override
  Future<List<Board>> getBoards() async {
    final response = await _service.getBoards();
    return response.list;
  }

  @override
  Future<void> createBoard(String title) {
    return _service.createBoard({'title': title});
  }

  @override
  Future<void> deleteBoard(String uuid) => _service.deleteBoard(uuid);
}
