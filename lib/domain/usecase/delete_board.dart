import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/board_repository.dart';

/// 게시판 삭제.
@injectable
class DeleteBoard {
  const DeleteBoard(this._repository);

  final BoardRepository _repository;

  Future<void> call(String uuid) => _repository.deleteBoard(uuid);
}
