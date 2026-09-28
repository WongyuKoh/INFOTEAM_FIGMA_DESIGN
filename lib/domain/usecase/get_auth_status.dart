import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/entity/auth_status.dart';
import 'package:figma_design/domain/repository/auth_repository.dart';

/// 현재 인증 상태(로그인 여부/세션 유효성/사용자 정보) 스냅샷을 반환한다.
@injectable
class GetAuthStatus {
  const GetAuthStatus(this._repository);

  final AuthRepository _repository;

  AuthStatus call() => _repository.currentStatus();
}
