import 'package:figma_design/domain/entity/board.dart';

/// 게시판 데이터 접근 "계약".
abstract interface class BoardRepository {
  Future<List<Board>> getBoards();

  Future<void> createBoard(String title);

  Future<void> deleteBoard(String uuid);
}
