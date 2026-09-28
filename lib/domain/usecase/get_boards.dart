import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/entity/board.dart';
import 'package:figma_design/domain/repository/board_repository.dart';

/// 게시판 목록 조회.
@injectable
class GetBoards {
  const GetBoards(this._repository);

  final BoardRepository _repository;

  Future<List<Board>> call() => _repository.getBoards();
}
