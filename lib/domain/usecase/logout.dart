import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/auth_repository.dart';

/// 로그아웃. 저장된 토큰을 지운다.
@injectable
class Logout {
  const Logout(this._repository);

  final AuthRepository _repository;

  Future<void> call() => _repository.logout();
}
