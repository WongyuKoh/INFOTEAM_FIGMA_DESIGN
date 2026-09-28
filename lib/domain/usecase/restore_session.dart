import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/auth_repository.dart';

/// 앱 시작 시 보안 저장소의 토큰을 메모리로 복원한다.
@injectable
class RestoreSession {
  const RestoreSession(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.restoreSession();
}
