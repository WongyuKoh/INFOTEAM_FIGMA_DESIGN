import 'package:injectable/injectable.dart';

import 'package:figma_design/domain/repository/auth_repository.dart';

/// 회원가입.
@injectable
class Register {
  const Register(this._repository);

  final AuthRepository _repository;

  Future<void> call({
    required String email,
    required String nickname,
    required String password,
  }) => _repository.register(
    email: email,
    nickname: nickname,
    password: password,
  );
}
